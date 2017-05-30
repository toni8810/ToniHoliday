package flights.eu.toniholiday;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotels.eu.toniholiday.Hotel;

public class NoSpecificDate extends HttpServlet {
	private static final long serialVersionUID = -4393532873131574519L;
	String depart,destination;
	String[] flightCompanies = {"ryanair","norwegian","wizzair","britishairways","pegasus","turkishairlines"};
	Connection con;
	Statement sQuery,sUpdate;
	
	//this method executes when the request is received
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			con = DriverManager.getConnection("jdbc:mysql://mysql1000.mochahost.com/toni8810_result","toni8810_tmsldck","VZwbCWNVed");
			sQuery = con.createStatement();
			sUpdate = con.createStatement();
		} catch (SQLException e) {
			req.setAttribute("errorMessage", "Whoops!! We could not connect to the database");
			RequestDispatcher rd = req.getRequestDispatcher("errorPage.jsp");
			rd.forward(req, res);
		}
		//Getting parameters
		String oneOrReturn = req.getParameter("oneOrReturn");
		depart = req.getParameter("departFrom");
		//setting request scope attribute
		req.setAttribute("depart", depart);
		destination = req.getParameter("destination");
		req.setAttribute("destination", destination);
		String month = req.getParameter("months");
		//Deleting every character except for the first 3
		month = month.substring(0, 3);
		//If the user chose 'one-way'
		if (oneOrReturn.contentEquals("oneWay")) {
			Flight result = getLowestPriceForMonthOneWay(month,depart,destination);
			
			//set the Flight object as a request scope attribute
			req.setAttribute("flight", result);
			
			//Forwarding the request
			RequestDispatcher rd = req.getRequestDispatcher("oneWay.jsp");
			rd.forward(req, res);
		}
		//If the user chose 'return'
		else {
			int lengthOfStay = Integer.parseInt(req.getParameter("weeks"));
			Hotel hotel = new Hotel();
			Flight result = getLowestPriceForMonthReturn(month,lengthOfStay,hotel);
			
			//set the Flight object as a request scope attribute
			req.setAttribute("flight", result);
			req.setAttribute("hotel", hotel);
			
			//Forwarding the request
			RequestDispatcher rd = req.getRequestDispatcher("return.jsp");
			rd.forward(req, res);
		}
		try {
			sQuery.close();
			sUpdate.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private Flight getLowestPriceForMonthReturn(String month, int lengthOfStay,Hotel hotel) {
		Flight result = new Flight();
		//Creating id for the database
		String id = (depart+destination).toLowerCase()+""+lengthOfStay+""+month.substring(0, 3);
		try {
			//Getting the data based on the id
			ResultSet rs = sQuery.executeQuery("SELECT * FROM flights WHERE id = '"+id+"'");
			//Setting the resultSet to the first position
			rs.first();
			
			//populating the Flight object
			result.setDateOutbound(rs.getString("dateOutbound"));
			result.setDateInbound(rs.getString("dateInbound"));
			result.setNumberOfNights(rs.getInt("numberOfNights"));
			result.setFlightCompanyInbound(rs.getString("flightCompanyInbound"));
			result.setFlightCompanyOutbound(rs.getString("flightCompanyOutbound"));
			result.setPriceInbound(rs.getDouble("priceInbound"));
			result.setPriceOutbound(rs.getDouble("priceOutbound"));
			//Checking if price in foreign currency is available 
			if (rs.getString("priceInboundInForeignCurrency").contentEquals("null")) result.setPriceInboundInForeignCurrency("");
			else result.setPriceInboundInForeignCurrency(rs.getString("priceInboundInForeignCurrency"));
			if (rs.getString("priceOutboundInForeignCurrency").contentEquals("null")) result.setPriceOutboundInForeignCurrency("");
			else result.setPriceOutboundInForeignCurrency(rs.getString("priceOutboundInForeignCurrency"));
			
			//Getting hotel details from database
			rs = sQuery.executeQuery("SELECT price,link FROM hotels WHERE id = '"+id+"'");
			if (rs.isBeforeFirst()) {
				rs.first();
				hotel.setLink(rs.getString("link"));
				hotel.setPrice(rs.getDouble("price"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new NullPointerException();
		}
		
		return result;
	}
	private Flight getLowestPriceForMonthOneWay(String month,String depart, String destination) {
		String[][] result = null;
		Flight flight = new Flight();
		double lowestPrice = Double.MAX_VALUE;
		int counter = 0;
		int numOfColumns,rowsAffected;
		String columnName,currencyName,queryString;
		
		try {
			List<String> flightCompaniesWithRequiredTables = new ArrayList<String>();
			List<String> tablesInDatabase = new ArrayList<String>();
			String tableName = (depart+destination).toLowerCase();
			
			for (int i=0; i<flightCompanies.length; i++ ) {
				//Getting table names from database 
				ResultSet tablesSet = sQuery.executeQuery("SELECT table_name FROM information_schema.tables WHERE table_schema='toni8810_"+flightCompanies[i]+"'");
				while(tablesSet.next()) {
					tablesInDatabase.add(tablesSet.getString("TABLE_NAME"));
				}
				//If database contains the relevant table add it to flightCompaniesWithRequiredTables
				if (tablesInDatabase.contains(tableName)) flightCompaniesWithRequiredTables.add(flightCompanies[i]);
				tablesInDatabase.clear();
			}
			result = new String[flightCompaniesWithRequiredTables.size()][3];
			//Clearing table
			sUpdate.executeUpdate("TRUNCATE TABLE resultList");
			for (int i=0; i<flightCompaniesWithRequiredTables.size(); i++) {
				rowsAffected = sUpdate.executeUpdate("INSERT INTO resultList (Date,Price)"+
												"SELECT Date,Price FROM toni8810_"+flightCompaniesWithRequiredTables.get(i)+"."+tableName+" WHERE Date LIKE '%"+month+"%' ORDER BY Price LIMIT 1");
				//if 0 rows affected the table is empty and flight company must be removed from the list
				if (rowsAffected == 0) {
					flightCompaniesWithRequiredTables.remove(i);
					i--;
				}
			}
			ResultSet resultSet = sQuery.executeQuery("SELECT Date,Price FROM resultList");
			while (resultSet.next()) {
				//add relevant data
				result[counter][0] = resultSet.getString("Date");
				result[counter][1] = String.valueOf(resultSet.getDouble("Price"));
				//add flight company based on its location in the list
				switch (counter) {
				case 0: result[counter][2] = flightCompaniesWithRequiredTables.get(0); break;
				case 1: result[counter][2] = flightCompaniesWithRequiredTables.get(1); break;
				case 2: result[counter][2] = flightCompaniesWithRequiredTables.get(2); break;
				case 3: result[counter][2] = flightCompaniesWithRequiredTables.get(3); break;
				case 4: result[counter][2] = flightCompaniesWithRequiredTables.get(4); break;
				case 5: result[counter][2] = flightCompaniesWithRequiredTables.get(5); break;
				}
				counter++;
			}
			//looping through the results
			for (int i=0; i<result.length; i++) {
				if (result[i][1] == null) continue;
				//finding the cheapest price and populate the flight object
				if (Double.parseDouble(result[i][1]) < lowestPrice) {
					lowestPrice = Double.parseDouble(result[i][1]);
					flight.setDateOutbound(result[i][0]);
					flight.setPriceOutbound(Double.parseDouble(result[i][1]));
					flight.setFlightCompanyOutbound(result[i][2]);
				}
			}
			
			//Checking if there is price in foreign currency available
			resultSet = sQuery.executeQuery("SELECT Count(*) FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '"+tableName+"' AND TABLE_SCHEMA = 'toni8810_"+flight.getFlightCompanyOutboundWithLowercase()+"'");
			resultSet.first();
			numOfColumns = resultSet.getInt(1);
			if (numOfColumns == 3) {
				resultSet = sQuery.executeQuery("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '"+tableName+"' AND TABLE_SCHEMA = 'toni8810_"+flight.getFlightCompanyOutboundWithLowercase()+"' ");
				resultSet.last();
				columnName = resultSet.getString(1);
				currencyName = columnName.substring(5);
				if (currencyName.contentEquals("Ft")) currencyName = "Ft";
				else if (currencyName.contentEquals("Eur")) currencyName = "\u20ac";
				else currencyName = "Try";
				queryString = "SELECT "+columnName+" FROM toni8810_"+flight.getFlightCompanyOutboundWithLowercase()+"."+tableName+" WHERE date = '"+flight.getDateOutbound()+"'";
				resultSet = sQuery.executeQuery(queryString);
				resultSet.first();
				flight.setPriceOutboundInForeignCurrency("("+currencyName+""+resultSet.getDouble(columnName)+")");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return flight;
	}

}

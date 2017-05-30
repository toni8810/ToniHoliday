package flights.eu.toniholiday;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetDataByAJAX extends HttpServlet {
	private static final long serialVersionUID = 705589785403703766L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/plain");
		String date = req.getParameter("dateInput");
		String month = date.substring(date.length()-3, date.length());
		String departure = req.getParameter("departureInput");
		String destination = req.getParameter("destinationInput");
		boolean oneWay = Boolean.parseBoolean(req.getParameter("oneWayInput"));
		String tableName = (departure+destination).toLowerCase();
		String tableNameReturn = (destination+departure).toLowerCase();
		PrintWriter out = res.getWriter();
		int counter = 0;
		String href;
		try (Connection con = DriverManager.getConnection("jdbc:mysql://mysql1000.mochahost.com/toni8810_result","toni8810_tmsldck","VZwbCWNVed");
			Statement s = con.createStatement()) {
			ResultSet rs = s.executeQuery("SELECT * FROM "+tableName+" WHERE date LIKE '%"+month+"'");
			rs.last();
			String[][] result = new String[rs.getRow()][4];
			rs.beforeFirst();
			while(rs.next()){
				result[counter][0] = rs.getString("date");
				result[counter][1] = rs.getString("date");
				result[counter][2] = String.valueOf(rs.getDouble("price"));
				result[counter][3] = rs.getString("flightCompany");
				counter++;
			}
			for (int i=0; i<result.length; i++) {
				result[i][0] = result[i][0].substring(5, 7);
			}
			Comparator<String[]> myComparator = new Comparator<String[]>() {
				@Override
				public int compare(String[] entry1, String[] entry2) {
					final Integer date1 = Integer.parseInt(entry1[0]);
					final Integer date2 = Integer.parseInt(entry2[0]);
					return date1.compareTo(date2);
				}
			};
			Arrays.sort(result, myComparator);
			out.println("<h2>"+departure+" - "+destination+"</h2>");
			out.println("<table>");
			for (int i=0; i<result.length; i++) {
				result[i][3] = result[i][3].substring(0, 1).toUpperCase()+result[i][3].substring(1, result[i][3].length());
				href = getHrefValue(result[i][3], result[i][1], departure, destination);
				out.println("<tr>");
				out.println("<td>"+result[i][1]+"</td>");
				out.println("<td>"+result[i][2]+"</td>");
				out.println("<td class='flightCompany'><a href='"+href+"' target='_blank' class='link'>"+result[i][3]+"</a></td>");
				out.println("</tr>");
			}
			out.println("</table>");
			if (oneWay == true) return;
			rs = s.executeQuery("SELECT * FROM "+tableNameReturn+" WHERE date LIKE '%"+month+"'");
			rs.last();
			String[][] resultReturn = new String[rs.getRow()][4];
			rs.beforeFirst();
			counter = 0;
			while(rs.next()){
				resultReturn[counter][0] = rs.getString("date");
				resultReturn[counter][1] = rs.getString("date");
				resultReturn[counter][2] = String.valueOf(rs.getDouble("price"));
				resultReturn[counter][3] = rs.getString("flightCompany");
				counter++;
			}
			for (int i=0; i<resultReturn.length; i++) {
				resultReturn[i][0] = resultReturn[i][0].substring(5, 7);
			}
			Arrays.sort(resultReturn, myComparator);
			out.println("<h2>"+destination+" - "+departure+"</h2>");
			out.println("<table>");
			for (int i=0; i<resultReturn.length; i++) {
				resultReturn[i][3] = resultReturn[i][3].substring(0, 1).toUpperCase()+resultReturn[i][3].substring(1);
				href = getHrefValue(resultReturn[i][3], resultReturn[i][1], destination,departure);
				out.println("<tr>");
				out.println("<td>"+resultReturn[i][1]+"</td>");
				out.println("<td>"+resultReturn[i][2]+"</td>");
				out.println("<td class='flightCompany'><a href='"+href+"' target='_blank' class='link'>"+resultReturn[i][3]+"</a></td>");
				out.println("</tr>");
			}
			out.println("</table>");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	private String getHrefValue(String flightCompany, String date, String depart, String destination) {
		switch(flightCompany) {
		case "Britishairways" : return "http://www.britishairways.com/travel/home/public/en_gb";
		case "Wizzair" : return "https://wizzair.com/en-GB/FlightSearch";
		case "Ryanair" : return "https://www.ryanair.com/";
		case "Pegasus" : return "http://www.flypgs.com/en/";
		case "Turkishairlines" : return "http://www.turkishairlines.com/en-uk/";
		default : return linkBuilder(date,depart,destination);
		}
	}
	private String linkBuilder(String date,String depart, String destination) {
		String returnLink = "https://www.norwegian.com/uk/booking/flight-tickets/select-flight/?D_City=";
		if (depart.contentEquals("London")) depart = "LGW";
		else if (depart.contentEquals("Budapest")) depart = "BUD";
		returnLink += depart+"&";
		if (destination.contentEquals("London")) destination = "LGW";
		else if (destination.contentEquals("Budapest")) destination = "BUD";
		returnLink += "A_City="+destination+"&TripType=1&";
		String day = date.substring(5, 7);
		returnLink += "D_Day="+day+"&";
		String month = getMonth(date);
		String year = getYear(month);
		returnLink += "D_Month="+year+""+month+"&D_SelectedDay="+day+"&R_Day=22&R_Month=201512&R_SelectedDay=22&CurrencyCode=GBP";
		return returnLink;
		//https://www.norwegian.com/uk/booking/flight-tickets/select-flight/?D_City=LGW&A_City=BUD&TripType=1&D_Day=07&D_Month=201601&D_SelectedDay=07&R_Day=22&R_Month=201512&R_SelectedDay=22&CurrencyCode=GBP
	}
	private String getYear(String month) {
		Calendar currentDate = Calendar.getInstance();
		Calendar selectedMonth = Calendar.getInstance();
		selectedMonth.set(Calendar.MONTH, Integer.parseInt(month));
		if (currentDate.get(Calendar.MONTH)+1 > selectedMonth.get(Calendar.MONTH)) {
			return String.valueOf(currentDate.get(Calendar.YEAR)+1);
		}
		else return String.valueOf(currentDate.get(Calendar.YEAR));
	}
	private String getMonth(String date) {
		String month = date.substring(8);
		switch (month) {
		case "Jan": return "01";
		case "Feb": return "02"; 
		case "Mar": return "03"; 
		case "Apr": return "04"; 
		case "May": return "05"; 
		case "Jun": return "06"; 
		case "Jul": return "07"; 
		case "Aug": return "08"; 
		case "Sep": return "09"; 
		case "Oct": return "10"; 
		case "Nov": return "11"; 
		default: return "12";
	}
	}
}

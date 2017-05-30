package flights.eu.toniholiday;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hotels.eu.toniholiday.Hotel;

public class SpecificDate extends HttpServlet {
	private static final long serialVersionUID = 6517941017695980570L;
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//Getting parameters from the form
		String departFrom = req.getParameter("departFrom");
		String destination = req.getParameter("destination");
		req.setAttribute("depart", departFrom);
		req.setAttribute("destination", destination);
		String oneWayOrReturn = req.getParameter("oneOrReturn");
		String day = req.getParameter("day");
		String month = req.getParameter("months");
		String dayReturn = req.getParameter("dayReturn");
		String monthReturn = req.getParameter("monthsReturn");
		Flight flight = new Flight();
		Hotel hotel = new Hotel();
		//Getting best price for outbound
		try {
			getBestPrice(departFrom,destination,day,month,false,flight);
		} catch (SQLException e) {
			req.setAttribute("errorMessage", "Whoops!! We could not connect to the database");
			RequestDispatcher rd = req.getRequestDispatcher("errorPage.jsp");
			rd.forward(req, res);
		}
		if (oneWayOrReturn.contentEquals("oneWay")) { 
			req.setAttribute("flight", flight);
			RequestDispatcher rd = req.getRequestDispatcher("oneWay.jsp");
			rd.forward(req, res);
		}
		else {
			//getting best price for inbound
			try {
				getBestPrice(destination,departFrom,dayReturn,monthReturn,true,flight);
			} catch (SQLException e) {
				req.setAttribute("errorMessage", "Whoops!! We could not connect to the database");
				RequestDispatcher rd = req.getRequestDispatcher("errorPage.jsp");
				rd.forward(req, res);
			}
			
			//creating the link for hotel booking
			hotel.setLink(destination, flight.getDateOutbound(), flight.getDateInbound());
			
			req.setAttribute("flight", flight);
			req.setAttribute("hotel", hotel);
			
			RequestDispatcher rd = req.getRequestDispatcher("return.jsp");
			rd.forward(req, res);
		}
	}
	private void getBestPrice(String departure, String destination, String day, String month, boolean isReturn, Flight flight) throws SQLException {
			Connection con = DriverManager.getConnection("jdbc:mysql://mysql1000.mochahost.com/toni8810_result","toni8810_tmsldck","VZwbCWNVed");
			Statement sQuery = con.createStatement();
			String tableName = (departure+destination).toLowerCase();
			
			ResultSet rs = sQuery.executeQuery("SELECT * FROM "+tableName+" WHERE date LIKE '%"+day+" "+month.substring(0, 3)+"'");
			rs.first();
			if (isReturn == false) {
				flight.setDateOutbound(rs.getString("date"));
				flight.setPriceOutbound(rs.getDouble("price"));
				flight.setFlightCompanyOutbound(rs.getString("flightCompany"));
			}
			else {
				flight.setDateInbound(rs.getString("date"));
				flight.setPriceInbound(rs.getDouble("price"));
				flight.setFlightCompanyInbound(rs.getString("flightCompany"));
			}
			sQuery.close();
			con.close();
	}

}

package hotels.eu.toniholiday;

import java.util.Calendar;

public class Hotel {
	private double price;
	private String link;
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getLink() {
		return link;
	}
	//Building the link so that users can be redirected straight to the relevant page
	public void setLink(String destination, String checkIn, String checkOut) {
		String destinationLink = "";
		String targetID = "";
		String checkInFormatted = getMonth(checkIn)+"/"+getDay(checkIn)+"/"+getYear(getMonth(checkIn));
		String checkInStandard = getStandardMonth(checkIn)+"/"+getStandardDay(checkIn)+"/"+getYear(getMonth(checkIn));
		String checkOutFormatted = getMonth(checkOut)+"/"+getDay(checkOut)+"/"+getYear(getMonth(checkOut));
		String checkOutStandard = getStandardMonth(checkOut)+"/"+getStandardDay(checkOut)+"/"+getYear(getMonth(checkIn));
		if (destination.contentEquals("Budapest")) {
			destinationLink = "Budapest,+Nagymaros,+Hungary";
			targetID = "AREA-D0ACF2B1-08C9-4810-BB0E-BA714AC156FD|cities";
		}
		else if (destination.contentEquals("Istanbul")) {
			destinationLink = "Istanbul,+Turkey";
			targetID = "AREA-918F4E54-A951-4458-9019-5EC91D8F2AC5|cities";
		}
		else if (destination.contentEquals("London")) {
			destinationLink = "London,+United+Kingdom";
			targetID = "AREA-3D931ACE-E3FE-46B4-A243-61D44A22053B|cities";
		}
		else {
			destinationLink = "Debrecen,+Hungary";
			targetID = "AREA-F5BFEFDC-65F8-4FA9-8D15-4986CF2143B3|cities";
		}
		
		String link = "http://hotels.toniholiday.eu/templates/461718/hotels/list?lang=en&currency=GBP&secureUrlFromDataBridge=https://www.travelnow.com&requestVersion=V2&destination="+destinationLink+"&targetId="+targetID+"&roomsCount=1&rooms%5B0%5D.adultsCount=1&rooms%5B0%5D.childrenCount=0&checkin="+checkInFormatted+"&standardCheckin="+checkInStandard+"&checkout="+checkOutFormatted+"&standardCheckout="+checkOutStandard+"&filter.sortedBy=price_lh";
		this.link = link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	private String getMonth(String date) {
		if (date.substring(8).contentEquals("Jan")) return "01";
		else if (date.substring(8).contentEquals("Feb")) return "02";
		else if (date.substring(8).contentEquals("Mar")) return "03";
		else if (date.substring(8).contentEquals("Apr")) return "04";
		else if (date.substring(8).contentEquals("May")) return "05";
		else if (date.substring(8).contentEquals("Jun")) return "06";
		else if (date.substring(8).contentEquals("Jul")) return "07";
		else if (date.substring(8).contentEquals("Aug")) return "08";
		else if (date.substring(8).contentEquals("Sep")) return "09";
		else if (date.substring(8).contentEquals("Oct")) return "10";
		else if (date.substring(8).contentEquals("Nov")) return "11";
		else return "12";
	}
	private String getStandardMonth(String date) {
		if (date.substring(8).contentEquals("Jan")) return "1";
		else if (date.substring(8).contentEquals("Feb")) return "2";
		else if (date.substring(8).contentEquals("Mar")) return "3";
		else if (date.substring(8).contentEquals("Apr")) return "4";
		else if (date.substring(8).contentEquals("May")) return "5";
		else if (date.substring(8).contentEquals("Jun")) return "6";
		else if (date.substring(8).contentEquals("Jul")) return "7";
		else if (date.substring(8).contentEquals("Aug")) return "8";
		else if (date.substring(8).contentEquals("Sep")) return "9";
		else if (date.substring(8).contentEquals("Oct")) return "10";
		else if (date.substring(8).contentEquals("Nov")) return "11";
		else return "12";
	}
	private String getDay(String date) { //Tue, 23 Nov
		return date.substring(5,7);
	}
	private String getStandardDay(String date) { //Tue, 23 Nov
		String day = date.substring(5,7);
		if (day.charAt(0) == '0') day = day.substring(1);
		return day;
	}
	private String getYear(String month) {
		Calendar currentDate = Calendar.getInstance();
		if (currentDate.get(Calendar.MONTH)+1 > Integer.parseInt(month)) {
			return String.valueOf(currentDate.get(Calendar.YEAR)+1);
		}
		else return String.valueOf(currentDate.get(Calendar.YEAR));
	}
}

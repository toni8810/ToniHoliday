function linkBuilderNorwegian() {
	if (arguments[3] != undefined) {
		var date1 = arguments[0];   //Check if month is after or before current date and roll year if before 
		var date2 = arguments[1];
		var depart = arguments[2];
		var destination = arguments[3];
		var returnLink = "https://www.norwegian.com/uk/booking/flight-tickets/select-flight/?D_City=";
		if (depart === "London") depart = "LGW";
		else if (depart === "Budapest") depart = "BUD";
		returnLink += depart+"&";
		if (destination === "London") destination = "LGW";
		else if (destination === "Budapest") destination = "BUD";
		returnLink += "A_City="+destination+"&";
		var day = getDay(date1);
		returnLink += "D_Day="+day+"&";
		var month = getMonth(date1);
		var year = getYear(month);
		returnLink += "D_Month="+year+""+month+"&D_SelectedDay="+day+"&";
		day = getDay(date2);
		returnLink += "R_Day="+day+"&";
		month = getMonth(date2);
		year = getYear(month);
		returnLink += "R_Month="+year+""+month+"&R_SelectedDay="+day+"&CurrencyCode=GBP&TripType=2";
		return returnLink;
		//https://www.norwegian.com/uk/booking/flight-tickets/select-flight/?D_City=LGW&A_City=BUD&D_Day=07&D_Month=201601&D_SelectedDay=07&R_Day=21&R_Month=201601&R_SelectedDay=21&CurrencyCode=GBP&TripType=2
	}
	else {
		var date = arguments[0]; 
		var depart = arguments[1];
		var destination = arguments[2];
		var returnLink = "https://www.norwegian.com/uk/booking/flight-tickets/select-flight/?D_City=";
		if (depart === "London") depart = "LGW";
		else if (depart === "Budapest") depart = "BUD";
		returnLink += depart+"&";
		if (destination === "London") destination = "LGW";
		else if (destination === "Budapest") destination = "BUD";
		returnLink += "A_City="+destination+"&TripType=1&";
		var day = getDay(date);
		returnLink += "D_Day="+day+"&";
		var month = getMonth(date);
		var year = getYear(month);
		returnLink += "D_Month="+year+""+month+"&D_SelectedDay="+day+"&R_Day=22&R_Month=201512&R_SelectedDay=22&CurrencyCode=GBP";
		return returnLink;
		//https://www.norwegian.com/uk/booking/flight-tickets/select-flight/?D_City=LGW&A_City=BUD&TripType=1&D_Day=07&D_Month=201601&D_SelectedDay=07&R_Day=22&R_Month=201512&R_SelectedDay=22&CurrencyCode=GBP
	}
}
function getDay(date) { //Tue, 23 Nov
	return date.substring(5,7);
}
function getMonth(date) {
	switch (date.substring(8)) {
		case "Jan": return "01"; break;
		case "Feb": return "02"; break;
		case "Mar": return "03"; break;
		case "Apr": return "04"; break;
		case "May": return "05"; break;
		case "Jun": return "06"; break;
		case "Jul": return "07"; break;
		case "Aug": return "08"; break;
		case "Sep": return "09"; break;
		case "Oct": return "10"; break;
		case "Nov": return "11"; break;
		default: return "12"; break;
	}
}
function getYear(month) {
	var currentDate = new Date();
	if (currentDate.getMonth() > new Date(month+"/01/2016").getMonth()) {
		return currentDate.getFullYear()+1;
	}
	else return currentDate.getFullYear();
}
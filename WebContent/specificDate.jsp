<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<meta content="Find the cheapest flight ticket on a specific date" name="description" />
	<meta content="cheap flight tickets to Budapest,cheap flight tickets to Istanbul,flight tickets to Budapest, flight tickets to Istanbul" name="keywords" />
	<title>Cheap Flight Tickets With Specific Date</title>
	<link rel="stylesheet" type="text/css" href="cssFiles/navigation.css" />
	<link rel="stylesheet" type="text/css" href="cssFiles/flightSearch.css" />
	<script src="scripts/autoFiller.js"></script>
	<script src="scripts/formValidator.js"></script>
	<script type="text/javascript">
			var date = new Date();
			//Start of return or one way          			
			function tickIt(button) {
				var id = button.id;
				if (id == "return") {
					document.getElementById("tickReturn").style.display = "inline";
					document.getElementById("tickOneWay").style.display = "none";
					document.getElementById("hiddenRadioReturn").checked = "checked";
					document.getElementById("returnDate").style.display = "block";
				}
				else {
					document.getElementById("tickOneWay").style.display = "inline";
					document.getElementById("tickReturn").style.display = "none";
					document.getElementById("hiddenRadioOneWay").checked = "checked";
					document.getElementById("returnDate").style.display = "none";
				}
			}
			//End of return or one way
			//Enable months if not the current year
			function chooseYear(year) {
				var yearSelected = year.options[year.selectedIndex].value;
				var currentYear = date.getFullYear();
				var currentMonth = date.getMonth();
				var options = document.getElementsByName("months")[0].getElementsByTagName("option");
				var yearReturn = document.getElementsByName("yearReturn")[0].getElementsByTagName("option");
				if (yearSelected == currentYear) {
					for (var i=0; i<currentMonth; i++) {
						options[i].disabled = true;
					}
					for (var i=currentMonth; i<12; i++) options[i].disabled = false;
				}
				else {
					for (var i=0; i<12; i++) {
						options[i].disabled = false;
					}
				}
				currentMonth++;
				if ((currentMonth+6 > 12) && (yearSelected == currentYear+1)) {
					var disableAfter = (currentMonth+6) - 12;
					for (var i=disableAfter; i<12; i++) {
						options[i].disabled = true;
					}
				}
				for (var i=0; i<year.selectedIndex; i++) {
					yearReturn[i].disabled = true;
				}
				for (var i=year.selectedIndex; i<2; i++) {
					yearReturn[i].disabled = false;
				}
				yearReturn[year.selectedIndex].selected = true;
				
			}
			function chooseMonth(month) {
				var days = document.getElementsByName("day")[0].getElementsByTagName("option");
				var monthsReturn = document.getElementsByName("monthsReturn")[0].getElementsByTagName("option");
				if (month.selectedIndex == date.getMonth()) {
					for (var i=0; i<date.getDate(); i++) {
						days[i].disabled = true;
					}
				}
				else {
					for (var i=0; i<31; i++) {
						days[i].disabled = false;
					}
				}
				for (var i=0; i<month.selectedIndex; i++) {
					monthsReturn[i].disabled = true;
				}
				for (var i=month.selectedIndex; i<12; i++) {
					monthsReturn[i].disabled = false;
				}
				monthsReturn[month.selectedIndex].selected = true;
			}
			function chooseDay(day) {
				var daysReturn = document.getElementsByName("dayReturn")[0].getElementsByTagName("option");
				for (var i=0; i<day.selectedIndex; i++) {
					daysReturn[i].disabled = true;
				}
				for (var i=day.selectedIndex; i<31; i++) {
					daysReturn[i].disabled = false;
				}
				daysReturn[day.selectedIndex].selected = true;
			}
			function chooseMonthReturn(month) {
				var daysReturn = document.getElementsByName("dayReturn")[0];
				if (month.selectedIndex != document.getElementsByName("months")[0].selectedIndex) {
					for (var i=0; i<31; i++) {
						daysReturn[i].disabled = false;
					}
				}
				else {
					for (var i=0; i<document.getElementsByName("day")[0].selectedIndex; i++) {
						daysReturn[i].disabled = true;
					}
				}
			}
			function chooseYearReturn(year) {
				var currentMonth = date.getMonth();
				var yearSelected = year.options[year.selectedIndex].value;
				var currentYear = date.getFullYear();
				var monthsReturn = document.getElementsByName("monthsReturn")[0].getElementsByTagName("option");
				currentMonth++;
				if ((currentMonth+6 > 12) && (yearSelected == currentYear+1)) {
					for (var i=0; i<12; i++) {
						monthsReturn[i].disabled = false;
					}
					var disableAfter = (currentMonth+6) - 12;
					for (var i=disableAfter; i<12; i++) {
						monthsReturn[i].disabled = true;
					}
				}
			}
		</script>
		<style type="text/css">
			#returnDate {
				display: none;
			}		
		</style>
</head>
<body>
	<div>
		<img id="border1" src="pics/border1Long.png" alt="border1 here"  />
		<img id="border2" src="pics/border2Long.png" alt="border2 here" />
	</div>
	<div class="logoHolder">
		<img src="pics/logonew.png" id="logo" height="200" width="244" alt="logo is on its way"/>
	</div>
	<ol class="menu">
		<li><a href="index.jsp" title="Click here to go back to the home page"><img class="buttons" src="pics/homeButton.png" alt="Home" id="homeButton" /></a></li> 
		<li>
			<a href="hotels.jsp" title="Click here to search for hotels">
			<img id="hotelsButton" class="buttons" src="pics/hotelsButton.png" alt="Hotel" /></a>
		</li>
		<li><img class="buttons" src="pics/hoverButtons/flightButton.gif" alt="Flight" id="flightButton"/></li> 
	</ol>
	<h1>Find the cheapest flight(s) by filling out this form</h1>
	<form action="specificDate.do" method="get" onsubmit="return validateForm()">
		<table>
			<tr>
				<td>Depart From</td>
				<td>
					<input type="text" name="departFrom" onkeydown="departList(this)" autocomplete="off"  />
					<ol id="cityListDepart">
					</ol>
				</td>
			</tr>
			<tr>
				<td align="left" >Destination</td>
				<td>
					<input type="text" name="destination" onkeydown="departList(this)" autocomplete="off"/>
					<ol id="cityListDestination"></ol>
				</td>
			</tr>
		</table>
			<fieldset>
				<legend>One-Way or Return?</legend>
				<ul>
					<li id="return" onclick="tickIt(this)" >Return<img src="pics/flightTicksImages/tick.png" id="tickReturn" /></li>
					<li id="oneWay" onclick="tickIt(this)" >One-Way<img src="pics/flightTicksImages/tick.png" id="tickOneWay" /></li>
				</ul>
				<input type="radio" name="oneOrReturn" value="return" class="radioButton" id="hiddenRadioReturn" />
				<input type="radio" name="oneOrReturn" value="oneWay" class="radioButton" id="hiddenRadioOneWay" />
			</fieldset>
			<fieldset>
				<legend>Select the date you want to travel on</legend>
				<select name="day" onchange="chooseDay(this)">
					<option>01</option>
					<option>02</option>
					<option>03</option>
					<option>04</option>
					<option>05</option>
					<option>06</option>
					<option>07</option>
					<option>08</option>
					<option>09</option>
					<option>10</option>
					<option>11</option>
					<option>12</option>
					<option>13</option>
					<option>14</option>
					<option>15</option>
					<option>16</option>
					<option>17</option>
					<option>18</option>
					<option>19</option>
					<option>20</option>
					<option>21</option>
					<option>22</option>
					<option>23</option>
					<option>24</option>
					<option>25</option>
					<option>26</option>
					<option>27</option>
					<option>28</option>
					<option>29</option>
					<option>30</option>
					<option>31</option>
				</select>
				<select name="months" onchange = "chooseMonth(this)">
					<option>January</option>
					<option>February</option>
					<option>March</option>
					<option>April</option>
					<option>May</option>
					<option>June</option>
					<option>July</option>
					<option>August</option>
					<option>September</option>
					<option>October</option>
					<option>November</option>
					<option>December</option>
				</select>
				<select name="year" onchange="chooseYear(this)">
					<option selected="selected">2016</option>
				</select>
			</fieldset>
			<fieldset id="returnDate">
				<legend>Select the date you want to return on</legend>
				<select name="dayReturn">
					<option>01</option>
					<option>02</option>
					<option>03</option>
					<option>04</option>
					<option>05</option>
					<option>06</option>
					<option>07</option>
					<option>08</option>
					<option>09</option>
					<option>10</option>
					<option>11</option>
					<option>12</option>
					<option>13</option>
					<option>14</option>
					<option>15</option>
					<option>16</option>
					<option>17</option>
					<option>18</option>
					<option>19</option>
					<option>20</option>
					<option>21</option>
					<option>22</option>
					<option>23</option>
					<option>24</option>
					<option>25</option>
					<option>26</option>
					<option>27</option>
					<option>28</option>
					<option>29</option>
					<option>30</option>
					<option>31</option>
				</select>
				<select name="monthsReturn" onchange = "chooseMonthReturn(this)">
					<option>January</option>
					<option>February</option>
					<option>March</option>
					<option>April</option>
					<option>May</option>
					<option>June</option>
					<option>July</option>
					<option>August</option>
					<option>September</option>
					<option>October</option>
					<option>November</option>
					<option>December</option>
				</select>
				<select name="yearReturn" onchange="chooseYearReturn(this)">
					<option selected="selected">2016</option>
				</select>
			</fieldset>
			<input type="submit" value="search" id="submitButton"/>					
	</form>	
	<script type="text/javascript">
		var date = new Date();
		var currentMonth = date.getMonth();
		var currentDay = date.getDate();
		var options = document.getElementsByName("months")[0].getElementsByTagName("option");
		var optionsReturn = document.getElementsByName("monthsReturn")[0].getElementsByTagName("option");
		var days = document.getElementsByName("day")[0].getElementsByTagName("option");
		for (i=0; i<currentMonth; i++) {
			options[i].disabled = true;
		}
		for (i=0; i<currentDay; i++) {
			days[i].disabled = true;
		}
		currentMonth++;
		if (currentMonth+6 < 12) {              
			for (i=currentMonth+6; i<12; i++) {
				options[i].disabled = true;
				optionsReturn[i].disabled = true; //Disable dates after 6 months
			}
		}
		options[currentMonth-1].selected = 'selected';
		optionsReturn[currentMonth-1].selected = 'selected';
		days[currentDay].selected = 'selected';
		document.getElementsByName("day")[1].getElementsByTagName("option")[currentDay+1].selected = 'selected';
	</script>
	</body>
</html>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
	<meta content="cheap flight tickets to Budapest,cheap flight tickets to Istanbul,flight tickets to Budapest, flight tickets to Istanbul" name="keywords" />
	<meta content="Find the cheapest flight ticket" name="description" />
	<title>Cheap Flight Tickets With No Specific Date</title>
	<link rel="stylesheet" type="text/css" href="cssFiles/navigation.css" />
	<link rel="stylesheet" type="text/css" href="cssFiles/flightSearch.css" />
	<script src="scripts/autoFiller.js"></script>
	<script src="scripts/formValidator.js"></script>
	<script type="text/javascript">
			//Start of return or one way          			
			function tickIt(button) {
				var id = button.id;
				if (id == "return") {
					document.getElementById("tickReturn").style.display = "inline";
					document.getElementById("tickOneWay").style.display = "none";
					document.getElementById("hiddenRadioReturn").checked = "checked";
					document.getElementById("weekSelector").style.display = "block";
				}
				else {
					document.getElementById("tickOneWay").style.display = "inline";
					document.getElementById("tickReturn").style.display = "none";
					document.getElementById("hiddenRadioOneWay").checked = "checked";
					document.getElementById("weekSelector").style.display = "none";
				}
			}
			//End of return or one way
			//Enable months if not the current year
			function selectedYear(year) {
				var date = new Date();
				var yearSelected = year.options[year.selectedIndex].value;
				var currentYear = date.getFullYear();
				var currentMonth = date.getMonth();
				var options = document.getElementsByName("months")[0].getElementsByTagName("option");
				if (yearSelected == currentYear) {
					for (var i=0; i<currentMonth; i++) {
						options[i].disabled = true;
					}
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
			}
		</script>
		<style type="text/css">
			#weekSelector {
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
			<img id="hotelsButton" class="buttons" src="pics/hotelsButton.png" alt="Hotels"/></a>
		</li>
		<li><img class="buttons" src="pics/hoverButtons/flightButton.gif" alt="Flights" id="flightButton"/></li> 
	</ol>
	<h1>Find the cheapest flight(s) by filling out this form</h1>
	<form action="noDate.do" onsubmit="return validateForm()">
		<table>
			<tr>
				<td>Depart From</td>
				<td>
					<input type="text" name="departFrom" onkeydown="departList(this)" autocomplete="off" onblur="autofill(this)"  />
					<ol id="cityListDepart">
					</ol>
				</td>
			</tr>
			<tr>
				<td align="left" >Destination</td>
				<td>
					<input type="text" name="destination" onkeydown="departList(this)" autocomplete="off" onblur="autofill(this)"/>
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
				<legend>Select the month you want to travel on</legend>
				<select name="months">
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
				<select name="year" onchange="selectedYear(this)">
					<option selected="selected">2016</option>
				</select>
			</fieldset>
			<fieldset id="weekSelector">
				<legend>Select how many weeks you want to stay for</legend>
				<select name="weeks">
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
				</select>
			</fieldset>
			<input type="submit" value="search" id="submitButton"/>					
	</form>	
	<script type="text/javascript">
		var currentMonth = new Date().getMonth();
		var options = document.getElementsByName("months")[0].getElementsByTagName("option");
		for (var i=0; i<currentMonth; i++) {
			options[i].disabled = true;
		}
		currentMonth++;
		if (currentMonth+6 < 12) {              
			for (var i=currentMonth+6; i<12; i++) {
				options[i].disabled = true; //Disable dates after 6 months
			}
			
		}
		
		options[currentMonth-1].selected = 'selected';
		
		
	</script>
	</body>
</html>
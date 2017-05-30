<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>One Way</title>
<link rel="stylesheet" type="text/css" href="cssFiles/navigation.css" />
<script src="scripts/linkBuilder.js"></script>
<script src="scripts/jquery-1.12.1.min.js"></script>
<script src="scripts/AJAXScript.js"></script>
<style>
	.logoHolder {
		text-align: center;
			}		
	table {
		margin-left: auto;
		margin-right: auto;
		font-size: 50px;
		font-color: #0E5E05;
		border: 5px outset #0CA535;
	}
	td {
		border: 3px groove #1744F7;
		padding: 20px;
	}
	#newSearch {
		width: 400px;
		margin-left: auto;
		margin-right: auto;
		font-size: 40px;
		text-align: center;
		margin-top: 100px;
	}
	#link {
		text-decoration: none;
		color: #0E5E05;
	}
	#link:hover {
		background-color: #0E5E05;
		color: white;
		cursor: pointer;
	}
	.link {
		text-decoration: none;
		color: #0E5E05;
	}
	.link:hover {
		background-color: #0E5E05;
		color: white;
		cursor: pointer;
	}
	.flightCompany:hover {
		background-color: #0E5E05;
		color: white;
		cursor: pointer;
		}
	h1 {
		text-align: center;
		font-size: 60px;
	}
	h3 {
		text-align: center;
		font-size: 30px;
	}
	span {
		text-decoration: underline;
	}
	span:hover {
		color: blue;
		cursor: pointer;
	}
		@media only screen and (min-width: 0px) and (max-width: 980px) {
		table {
			margin-left: auto;
			margin-right: auto;
			font-size: 40px;
			font-color: #0E5E05;
			border: 5px outset #0CA535;
		}
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
		<li><a href="index.jsp" title="Click here to go back to the home page"><img class="buttons" src="pics/homeButton.png" alt="Home" id="homeButton" onmouseover="hoverOverButton(this,document.getElementById('flightButton'))" onmouseout="hoverOut(this,document.getElementById('flightButton'))" /></a></li> 
		<li><a href="hotels.jsp" title="Click here to search for hotels"><img id="hotelsButton" class="buttons" src="pics/hotelsButton.png" alt="Hotel" onmouseover="hoverOverButton(this,document.getElementById('flightButton'))" onmouseout="hoverOut(this,document.getElementById('flightButton'))" /></a></li>
		<li><img class="buttons" src="pics/hoverButtons/flightButton.gif" alt="Flight" id="flightButton"/></li> 
	</ol>
	<h1>${depart} - ${destination}</h1>
	<table>
		<tr>
			<td>&#163;${flight.priceOutbound} ${flight.priceOutboundInForeignCurrency}</td>
			<td>${flight.dateOutbound}</td>
			<td class="flightCompany"><a id="link" target="_blank" href="http://www.flypgs.com/en/">${flight.flightCompanyOutbound}</a></td>
		</tr>
	</table>
	<script>
		var flightCompany = "${flight.flightCompanyOutbound}";
		var link = document.getElementById("link");
		if (flightCompany == "Wizzair") link.setAttribute("href","https://wizzair.com/en-GB/FlightSearch");
		else if (flightCompany == "Ryanair") link.setAttribute("href","https://www.ryanair.com/");
		else if (flightCompany == "Pegasus") link.setAttribute("href","http://www.flypgs.com/en/");
		else if (flightCompany == "Britishairways") link.setAttribute("href","http://www.britishairways.com/travel/home/public/en_gb");
		else if (flightCompany == "Turkishairlines") link.setAttribute("href","http://www.turkishairlines.com/en-uk/");
		else link.setAttribute("href", linkBuilderNorwegian("${flight.dateOutbound}","${depart}","${destination}"));
</script>
<h3 id="ajaxResult">Not quite the dates you have been looking for?? <span onclick="ajaxFunction('${flight.dateOutbound}','${depart}','${destination}','true')">Click here</span></h3>
	<div id="newSearch">
		<a href="flights.jsp">Start a new search</a>
	</div>
</body>
</html>
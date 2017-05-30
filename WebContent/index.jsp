<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta content="ToniHoliday is website where you can book cheap flight ticket and hotel" name="description" />
<link rel="stylesheet" type="text/css" href="cssFiles/navigation.css" />
<link rel="stylesheet" type="text/css" href="cssFiles/flightSearch.css" />
<style type="text/css">
	.block {
		display: block;
		font-size: 50px;
		margin-top: 20px;
		margin-bottom: 20px;
		font-family: "Baskerville Old Face", "Times New Roman", Arial;
	}
	#options {
		border: 6px ridge #0D6200;
		width: 610px;
		margin-left: auto;
		margin-right: auto;
		padding-right: 20px;
	}
	a {
		color: #B36704;
	}
	a:hover {
		color: #553204;
	}
	#promotion {
	text-align: center;
	font-family: Algerian, "Baskerville Old Face", Arial;
	font-size: 40px;
	}
	#promotion p span {
		font-size: 20px;
	}
</style>
<title>ToniHoliday</title>
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
		<li><img class="buttons" src="pics/hoverButtons/homeButton.gif" alt="Home" id="homeButton"  /></li> 
		<li><a href="hotels.jsp" title="Click here to search for hotels"><img id="hotelsButton" class="buttons" src="pics/hotelsButton.png" alt="Hotels" /></a></li>
		<li><a href="flights.jsp" title="Click here to search for cheap flight tickets"><img class="buttons" src="pics/flightButton.png" alt="Flights" id="flightButton"/></a></li> 
	</ol>
	<div id="promotion">
		<p>Budapest flight + accomodation 5 nights  <br />from &#163;60 <br /><span>Click the picture to book</span></p>
		<a href="flightNoSpecificDate.jsp"><img src="pics/budapest.jpg" alt="budapest"/></a>
	</div>
</body>
</html>
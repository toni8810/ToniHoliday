<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" type="text/css" href="cssFiles/navigation.css" />
<link rel="stylesheet" type="text/css" href="cssFiles/flightSearch.css" />
<style type="text/css">
	.block {
		display: block;
		font-size: 50px;
		margin-top: 20px;
		margin-bottom: 20px;
		font-family: "Baskerville Old Face", "Times New Roman", Arial;
		text-shadow: 2px 2px 2px white;
	}
	#options {
		border: 6px ridge #0D6200;
		border-radius: 30px;
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
</style>
<title>Flights</title>
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
		<li><img class="buttons" src="pics/hoverButtons/flightButton.gif" alt="Flights" id="flightButton"/></li> 
	</ol>
	<ol id="options">
		<li class="block"><a href="flightNoSpecificDate.jsp">I do <b>NOT</b> have a specific date</a></li>
		<li class="block"><a href="specificDate.jsp">I do have a specific date</a></li>
	</ol>
</body>
</html>
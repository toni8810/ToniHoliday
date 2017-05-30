<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page isErrorPage="true" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>No data</title>
<link rel="stylesheet" type="text/css" href="cssFiles/navigation.css" />
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
	#flightCompany:hover, #link:hover {
		background-color: #0E5E05;
		color: white;
		cursor: pointer;
	}
	h1 {
		width: 85%;
		margin: auto;
		text-align: center;
		font-size: 60px;
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
		<li><a href="hotels.html" title="Click here to search for hotels"><img id="hotelsButton" class="buttons" src="pics/hotelsButton.png" alt="Hotel" onmouseover="hoverOverButton(this,document.getElementById('flightButton'))" onmouseout="hoverOut(this,document.getElementById('flightButton'))" /></a></li>
		<li><img class="buttons" src="pics/hoverButtons/flightButton.gif" alt="Flight" id="flightButton"/></li> 
	</ol>
	<c:if test="${errorMessage == null}">
		<h1>Whoooops!! It seems that we have a NullPointerException please refresh the page</h1>
	</c:if>
	<c:if test="${errorMessage != null}">
		<h1>${errorMessage}</h1>
	</c:if>
	<div id="newSearch">
		<a href="flights.jsp">Start a new search</a>
	</div>
</body>
</html>
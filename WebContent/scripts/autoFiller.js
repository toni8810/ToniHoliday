//Executes when user starts to type departure or destination city
function departList(departCity) {
	var ol;
	var departureBoxContent = "";
	//deciding if the user started to type into departure or destination box
	if (departCity.name == "departFrom") ol = document.getElementById("cityListDepart");
	else ol = document.getElementById("cityListDestination");
	//capturing what have been typed so far
	var typed = departCity.value;
	//if something has been typed, capitalize the first character
	if (typed.length > 0) typed = typed.replace(typed.charAt(0),typed.charAt(0).toUpperCase());
	//Emptying the list
	while (ol.firstChild) {
		ol.removeChild(ol.firstChild);
		}
	//If the user is typing into the destination box
	if (ol.id == "cityListDestination") {
		departureBoxContent = document.getElementsByName("departFrom")[0].value;
	}
	//Going through all the cities
	for (var i=0; i<cityList.length; i++) {
		if ((cityList[i].indexOf(typed) > -1) && (cityList[i] != departureBoxContent) ) {
			var li = document.createElement("li");
			li.setAttribute("class","departListElement");
			li.setAttribute("onclick","writeDestinationInTheBox(this,'"+departCity.name+"')");
			var textNode = document.createTextNode(cityList[i]);
			li.appendChild(textNode);
			ol.appendChild(li);
			ol.style.display = "block";
			if (ol.id == "cityListDepart") ol.style.top = "410px";
			else ol.style.top = "460px";
		}
	}
}
function writeDestinationInTheBox(listElement,departOrDest) {
	var inputBox = document.getElementsByName(departOrDest)[0];
	inputBox.value = listElement.innerHTML;
	if (departOrDest == "departFrom") {
		document.getElementById("cityListDepart").style.display = "none";
	}
	else {
		document.getElementById("cityListDestination").style.display = "none";
	}				
}
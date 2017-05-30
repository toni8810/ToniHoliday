var cityList = ["London","Budapest","Istanbul","Debrecen"];
function validateForm() {
	var departFrom = document.getElementsByName("departFrom")[0];
	var destination = document.getElementsByName("destination")[0];
	var onewayOrReturn = document.getElementsByName("oneOrReturn");
	// Check if departure is filled
	if (departFrom.value === "") {
		alert("Whoops you have not chosen departure!!");
		departFrom.style.border = "groove 10px #ED2626";
		departFrom.focus();
		return false;
		}
	//Check if departure city is valid
	else if (contains(departFrom.value) == false) {
		alert("Whoops the city you typed in is unknown");
		departFrom.style.border = "groove 10px #ED2626";
		departFrom.focus();
		return false;
		}
	// Check if destination is filled
	if (destination.value === "") {
		alert("Whoops you have not chosen destination!!");
		destination.style.border = "groove 10px #ED2626";
		destination.focus();
		return false;
		}
	//Check if destination city is valid
	else if (contains(destination.value) == false) {
		alert("Whoops the city you typed in is unknown");
		destination.style.border = "groove 10px #ED2626";
		destination.focus();
		return false;
		}
	//Check if radiobuttons are checked
	if ((onewayOrReturn[0].checked == false) && ((onewayOrReturn[1].checked == false))) {
		alert("Whoops!! You have not chosen if you are looking for a oneway or a return ticket!!");
		document.getElementsByTagName("fieldset")[0].style.border = "groove 10px #ED2626";
		return false;
		}
	return true;				
}
function contains(city) {
	for (var i=0; i<cityList.length; i++) {
		if (city === cityList[i]) return true;
	}
	return false;
}
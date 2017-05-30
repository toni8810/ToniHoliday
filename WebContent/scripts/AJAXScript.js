	function ajaxFunction(date,departure,destination,oneWay) {
		$.ajax({
			type:'POST',
			data: {dateInput: date, departureInput: departure, destinationInput: destination, oneWayInput: oneWay},
			url: 'getDataAjax.do',
			success: function(result) {
				$('#ajaxResult').html(result);
			}
		});
	}
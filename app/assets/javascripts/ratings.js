$(function() {

	console.log("ratings.js working");

	$("#ratings-submit").on('click', function(e){
		e.preventDefault();
		console.log("in on submit");
		var result = $("#ratings-form input:radio:checked").get();
		formatData(result, function(results_array){
			sendDataToController(results_array);
		});
	});

	function formatData(result, callback){
		console.log("formatData");
		var results_array = [];
		$.map(result, function(element) {
	    	var e = $(element);
	    	results_array.push([e.attr("id"), e.attr("value")]);
	    });
		callback(results_array);
	}

	function sendDataToController(results_array){
		console.log("sendDataToController");
		$.ajax({
			type: "POST",
			url: '/setratings',
			data: {ratings: results_array},
			success: function (data) {
				console.log("Sent");
				console.log(data);
				location.reload();
		    },
		    error: function (error) {
		      console.log("Error: ");
		      console.error(error);
		    }
		});
	}

});
$(function() {

	console.log("settings.js working");
	var counter = 5;
	var incompletion_counter = 0;

	if($('#sync')[0]!==undefined){
		var syncing = $('#sync')[0].attributes.data.value;
	} else {
		var syncing = "false";
	}
	
	if(syncing === "true"){
		console.log("syncing = true");
		$(".progress.hidden").removeClass("hidden");

		progressBarCount();

		setInterval(function(){
			checkCompletion();
		},8000);
		
	}

	function progressBarCount() {
		time=setInterval(function(){
			if(counter > 90){
				clearInterval(time);
			} else if (counter > 80) {
				counter += 0.5;
			} else {
				counter += 1;
			}
			counter_percent = String(counter) + "%";
			console.log(counter);
			$('#progress_bar').css('width', counter_percent);
		},300);
	}

	function checkCompletion() {
		$.ajax({
			type: "GET",
			url: '/done_syncing',
			success: function (data) {
				if(data === "false"){
					clearInterval(time);
						$('#progress_bar').css('width', "100%");
						setInterval(function(){
							$('#progress-bar-check').append('<span class="glyphicon glyphicon-ok"></span>');
							setInterval(function(){
								window.location.replace("/profile");
							},1000);
						},2000);
				} else {
					console.log(data + incompletion_counter);
					incompletion_counter += 1;
					if(incompletion_counter === 4){
						$('#progress-bar-check').append('Taking longer than expected, will keeping working in the background');
						$.get('/sync_false', function(){
							setInterval(function(){
								window.location.replace("/profile");
							},4000);
						});
					}
				}
		    },
		    error: function (error) {
		      console.log("Error: ");
		      console.error(error);
		    }
		});
	}

});
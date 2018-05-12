$(document).ready(function() {

   $("#send").click(function () {
		var vet = {
			name: $("#name").val(),
			race: $("#race").val(),
			age: $("#age").val(),
			owner: $("#owner").val()
		}

		$("#dog").val(JSON.stringify(vet));
	});

});

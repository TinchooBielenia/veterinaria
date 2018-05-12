$(document).ready(function() {

   $("#send").click(function () {
		var owner = {
			name: $("#name").val(),
			surname: $("#surname").val(),
			email: $("#email").val(),
			phone: $("#phone").val()
		}

		$("#owner").val(JSON.stringify(owner));
	});

});

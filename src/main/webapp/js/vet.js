$(document).ready(function() {

   $("#send").click(function () {
		var vet = {
			name: $("#name").val(),
			surname: $("#surname").val(),
			email: $("#email").val(),
			phone: $("#phone").val(),
      vet_id:$("#vet_id").val()
		}

		$("#vet").val(JSON.stringify(vet));
	});

});

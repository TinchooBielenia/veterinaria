<html>
	<head>
		<title>Alta de veterinario</title>
	</head>
	<body>
		<form action="/veterinaria/rest/vet/create" method="post">
			<input type="hidden" name="vet" id="vet" />
			<input type="text" id="name" placeholder="Nombre..." required />
			<br />
			<input type="text" id="surname" placeholder="Apellido..." required />
			<br />
			<input type="text" id="email" placeholder="email..." required />
			<br />
			<input type="text" id="phone" placeholder="Telefono..." required />
			<br />
			<input type="text" id="vet_id" placeholder="Matricula..." required />
			<br /><br />
			<button id="send">Enviar</button>
		</form>

		<script src="/veterinaria/js/jquery.min.js"></script>
		<script src="/veterinaria/js/vet.js"></script>
	</body>
</html>

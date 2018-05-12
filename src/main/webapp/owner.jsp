<html>
	<head>
		<title>Alta de propietario</title>
	</head>
	<body>
		<form action="/veterinaria/rest/owner/create" method="post">
			<input type="hidden" name="owner" id="owner" />
			<input type="text" id="name" placeholder="Nombre..." required />
			<br />
			<input type="text" id="surname" placeholder="Apellido..." required />
			<br />
			<input type="text" id="email" placeholder="email..." required />
			<br />
			<input type="text" id="phone" placeholder="Telefono..." required />
			<br /><br />
			<button id="send">Enviar</button>
		</form>

		<script src="/veterinaria/js/jquery.min.js"></script>
		<script src="/veterinaria/js/owner.js"></script>
	</body>
</html>

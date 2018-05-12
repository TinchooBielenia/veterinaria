<html>
	<head>
		<title>Alta de mascota</title>
	</head>
	<body>
		<form action="/veterinaria/rest/dog/create" method="post">
			<input type="hidden" name="dog" id="dog" />
			<input type="text" id="name" placeholder="Nombre..." required />
			<br />
			<input type="text" id="race" placeholder="Raza..." required />
			<br />
			<input type="text" id="age" placeholder="Edad..." required />
			<br />
			<input type="text" id="owner" placeholder="Dueño..." required />
			<br /><br />
			<button id="send">Enviar</button>
		</form>

		<script src="/veterinaria/js/jquery.min.js"></script>
		<script src="/veterinaria/js/dog.js"></script>
	</body>
</html>

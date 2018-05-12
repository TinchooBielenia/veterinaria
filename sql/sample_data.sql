
SELECT webapi_owner_create (
  '{
    "name":"German",
    "surname":"Basisty",
    "phone":"1523924347",
    "email":"basisty.german@gmail.com"
  }'
);

SELECT webapi_vet_create (
	'{
		"name":"German",
		"surname":"Basisty",
		"phone":"1523924347",
		"email":"basisty.german@gmail.com",
		"vet_id":1234
	}'
);

SELECT dog('Firulais', 'Boxer', 2, 1);
SELECT consultation(1, 1234, 'Llora permanentemente');

.PHONY: clean

all: veterinaria.sql

veterinaria.sql: \
	person.ddl \
	owner.ddl \
	dog.ddl \
	vet.ddl \
	consultation.ddl

	psql -c "create database veterinaria" postgres

	touch veterinaria.sql
	cat person.ddl >> veterinaria.sql
	cat owner.ddl >> veterinaria.sql
	cat owner.sql >> veterinaria.sql
	cat dog.ddl >> veterinaria.sql
	cat dog.sql >> veterinaria.sql
	cat vet.ddl >> veterinaria.sql
	cat vet.sql >> veterinaria.sql
	cat consultation.ddl >> veterinaria.sql
	cat consultation.sql >> veterinaria.sql

	cat webapi_owner.sql >> veterinaria.sql
	cat webapi_vet.sql >> veterinaria.sql
	cat webapi_dog.sql >> veterinaria.sql

	cat sample_data.sql >> veterinaria.sql

	psql veterinaria < veterinaria.sql


clean:
	$(RM) veterinaria.sql
	psql -c "drop database if exists veterinaria" postgres

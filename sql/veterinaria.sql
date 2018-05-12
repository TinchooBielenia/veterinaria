
CREATE TABLE person (
	id                            serial PRIMARY KEY,
	name                          text NOT NULL,
	surname                       text NOT NULL,
	phone                         text NOT NULL,
	email                         text
);

CREATE TABLE owner (
	owner_id                      serial PRIMARY KEY
) INHERITS (
	person
);

CREATE OR REPLACE FUNCTION owner (
	IN p_name                     text,
	IN p_surname                  text,
	IN p_phone                    text,
	IN p_email                    text
) RETURNS owner AS
$$
	INSERT INTO owner(name, surname, phone, email)
		VALUES(p_name, p_surname, p_phone, p_email)
	RETURNING *;
$$ LANGUAGE sql VOLATILE;


CREATE OR REPLACE FUNCTION owner_search_by_surname (
	IN p_surname                  text DEFAULT '%'
) RETURNS SETOF owner AS
$$
	SELECT * FROM owner WHERE surname ILIKE p_surname || '%';
$$ LANGUAGE sql STABLE STRICT;

CREATE TABLE dog (
	id                            serial PRIMARY KEY,
	name                          text NOT NULL,
	race                          text NOT NULL,
	age                           integer NOT NULL CHECK (age >= 0),
	owner                         integer NOT NULL REFERENCES owner(owner_id)
);

CREATE OR REPLACE FUNCTION dog (
	p_name                          text,
	p_race                          text,
	p_age                           integer,
	p_owner                         integer
) RETURNS dog AS 
$$
	INSERT INTO dog(name, race, age, owner)
		VALUES(p_name, p_race, p_age, p_owner)
	RETURNING *
$$ LANGUAGE sql VOLATILE;



CREATE TABLE vet (
	vet_id                        integer PRIMARY KEY
) INHERITS (
	person
);

CREATE OR REPLACE FUNCTION vet (
	IN p_name                     text,
	IN p_surname                  text,
	IN p_phone                    text,
	IN p_email                    text,
	IN p_vet_id                   integer
) RETURNS vet AS
$$
	INSERT INTO vet(name, surname, phone, email, vet_id)
		VALUES(p_name, p_surname, p_phone, p_email, p_vet_id)
	RETURNING *
$$ LANGUAGE sql VOLATILE;

CREATE OR REPLACE FUNCTION vet_search_by_surname (
	IN p_surname                  text DEFAULT '%'
) RETURNS SETOF vet AS
$$
	SELECT * FROM vet WHERE surname ILIKE p_surname || '%';
$$ LANGUAGE sql STABLE STRICT;

CREATE TABLE consultation (
	id                            serial PRIMARY KEY,
	timestamp                     timestamp with time zone DEFAULT NOW(),
	dog                           integer NOT NULL REFERENCES dog(id),
	vet                           integer NOT NULL REFERENCES vet(vet_id),
	consultation_reason           text NOT NULL,
	diagnistic                    text
);

CREATE OR REPLACE FUNCTION consultation (
	p_dog                         integer,
	p_vet                         integer,
	p_consultation_reason         text
) RETURNS consultation AS
$$
	INSERT INTO consultation(dog, vet, consultation_reason)
		VALUES(p_dog, p_vet, p_consultation_reason)
	RETURNING *;
$$ LANGUAGE sql VOLATILE STRICT;

CREATE OR REPLACE FUNCTION webapi_owner_create (
	IN p_owner                    jsonb
) RETURNS void AS $$
BEGIN
	IF NOT p_owner ? 'name'
		OR NOT p_owner ? 'surname'
		OR NOT p_owner ? 'phone'
		OR NOT p_owner ? 'email'
	THEN
		RAISE EXCEPTION 'webapi_owner_create EXCEPTION: malformed JSON object';
	END IF;

	PERFORM owner(p_owner ->> 'name', p_owner ->> 'surname', p_owner ->> 'phone', p_owner ->> 'email');
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;


CREATE OR REPLACE FUNCTION webapi_owner_search_by_surname(
	IN p_surname                  jsonb DEFAULT '{"surname":null}'
) RETURNS jsonb AS $$
DECLARE
	v_surname                     text;

BEGIN
	IF NOT p_surname ? 'surname'
	THEN
		RAISE EXCEPTION 'webapi_owner_search_by_surname EXCEPTION: malformed JSON object';
	END IF;

	v_surname = p_surname ->> 'surname';

	RETURN array_to_json(array_agg(x)) FROM (SELECT * FROM owner_search_by_surname(v_surname)) x;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

CREATE OR REPLACE FUNCTION webapi_vet_create (
	IN p_vet                    jsonb
) RETURNS void AS $$
BEGIN
	IF NOT p_vet ? 'name'
		OR NOT p_vet ? 'surname'
		OR NOT p_vet ? 'phone'
		OR NOT p_vet ? 'email'
		OR NOT p_vet ? 'vet_id'
	THEN
		RAISE EXCEPTION 'webapi_vet_create EXCEPTION: malformed JSON object';
	END IF;

	PERFORM vet(
		p_vet ->> 'name',
		p_vet ->> 'surname',
		p_vet ->> 'phone',
		p_vet ->> 'email',
		(p_vet ->> 'vet_id')::integer
	);
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;


CREATE OR REPLACE FUNCTION webapi_vet_search_by_surname(
	IN p_surname                  jsonb DEFAULT '{"surname":null}'
) RETURNS jsonb AS $$
DECLARE
	v_surname                     text;

BEGIN
	IF NOT p_surname ? 'surname'
	THEN
		RAISE EXCEPTION 'webapi_vet_search_by_surname EXCEPTION: malformed JSON object';
	END IF;

	v_surname = p_surname ->> 'surname';

	RETURN array_to_json(array_agg(x)) FROM (SELECT * FROM vet_search_by_surname(v_surname)) x;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

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

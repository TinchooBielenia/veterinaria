
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


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
$$ LANGUAGE sql STABLE;

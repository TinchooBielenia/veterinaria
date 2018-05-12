
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



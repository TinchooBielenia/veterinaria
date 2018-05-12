
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

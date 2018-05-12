
CREATE OR REPLACE FUNCTION webapi_dog_create (
	IN p_dog                    jsonb
) RETURNS void AS $$
BEGIN
	IF NOT p_dog ? 'name'
		OR NOT p_dog ? 'race'
		OR NOT p_dog ? 'age'
		OR NOT p_dog ? 'owner'
	THEN
		RAISE EXCEPTION 'webapi_dog_create EXCEPTION: malformed JSON object';
	END IF;

	PERFORM dog(
		p_dog ->> 'name',
		p_dog ->> 'race',
		(p_dog ->> 'age')::integer,
		(p_dog ->> 'owner')::integer
	);
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

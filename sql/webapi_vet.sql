
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

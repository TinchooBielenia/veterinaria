
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

	v_surname := p_surname ->> 'surname';
	IF v_surname IS NULL
	THEN
		v_surname := '';
	END IF;

	RETURN array_to_json(array_agg(x)) FROM (SELECT * FROM owner_search_by_surname(v_surname)) x;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

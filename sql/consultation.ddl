
CREATE TABLE consultation (
	id                            serial PRIMARY KEY,
	timestamp                     timestamp with time zone DEFAULT NOW(),
	dog                           integer NOT NULL REFERENCES dog(id),
	vet                           integer NOT NULL REFERENCES vet(vet_id),
	consultation_reason           text NOT NULL,
	diagnistic                    text
);

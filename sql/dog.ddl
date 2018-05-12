
CREATE TABLE dog (
	id                            serial PRIMARY KEY,
	name                          text NOT NULL,
	race                          text NOT NULL,
	age                           integer NOT NULL CHECK (age >= 0),
	owner                         integer NOT NULL REFERENCES owner(owner_id)
);

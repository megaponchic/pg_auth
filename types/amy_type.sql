CREATE TYPE amy_type AS (
	asome_id smallint,
	asome_message text,
    amy_type_ref my_type
);
ALTER TYPE amy_type OWNER TO postgres;

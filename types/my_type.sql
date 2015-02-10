CREATE TYPE my_type AS (
	some_id smallint,
	some_message text
);
ALTER TYPE my_type OWNER TO postgres;

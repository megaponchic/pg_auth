CREATE OR REPLACE FUNCTION create_user(p_email text)
  RETURNS jsonb AS
$BODY$
/**
 @description
 Creates user in DB with given properties

 @param email
 email of the user
*/
DECLARE	
	c_int SMALLINT := 0;
		
	return_value jsonb;
BEGIN
	BEGIN
		-- Arrays and objects can be nested arbitrarily
        SELECT '{"foo": [true, "bar"], "tags": {"a": 5, "b": null}}'::jsonb; INTO return_value
	EXCEPTION 
		WHEN unique_violation THEN 
			RAISE WARNING 'Warning! core_register_user violates unqie constraint SQL_ERRCODE % SQL_ERRM %', SQLSTATE, SQLERRM;
		WHEN OTHERS THEN
			RAISE INFO 'Exception in core_register_user with SQL_ERRCODE % SQL_ERRM %', SQLSTATE, SQLERRM;
			return_value.result_status_id:=999;
			return_value.result_status_msg:=SQLSTATE::text|| ' '  || SQLERRM;
	END;
			
	RETURN return_value;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER
  COST 30;
ALTER FUNCTION create_user(text) OWNER TO pg_auth;
GRANT EXECUTE ON FUNCTION create_user(text) OWNER TO pg_auth;
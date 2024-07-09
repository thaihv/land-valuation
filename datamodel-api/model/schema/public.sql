
SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE SCHEMA IF NOT EXISTS preparation
AUTHORIZATION postgres;
COMMENT ON SCHEMA preparation IS 'Information model for preparation stage of property valuation system.It is used for collecting and maintaining property data as is, property ownership, location, size, use, physical characteristics, sales prices, rents, costs, and operating expenses';

CREATE SCHEMA IF NOT EXISTS valuation
AUTHORIZATION postgres;
COMMENT ON SCHEMA valuation IS 'Property valuation information model as LADM extension.';

CREATE SCHEMA IF NOT EXISTS source
AUTHORIZATION postgres;
COMMENT ON SCHEMA source IS 'Represents metadata about documents provided to support land valuation.';

CREATE SCHEMA IF NOT EXISTS document
AUTHORIZATION postgres;
COMMENT ON SCHEMA document IS 'Used by property valuation system to store electronic copies of documentation provided in support of land valuation related dealings.';

CREATE SCHEMA IF NOT EXISTS system
AUTHORIZATION postgres;
COMMENT ON SCHEMA system IS 'Contains system configuration for property valuation system.';

CREATE SCHEMA IF NOT EXISTS address
AUTHORIZATION postgres;
COMMENT ON SCHEMA address IS 'Capturing postal and physical addresses of valuation properties.';

CREATE SCHEMA IF NOT EXISTS application
AUTHORIZATION postgres;
COMMENT ON SCHEMA application IS 'Contains information of business process data for property valuation system.';

CREATE SCHEMA IF NOT EXISTS administrative
AUTHORIZATION postgres;
COMMENT ON SCHEMA administrative IS 'As an extension of land valuation, It is a schema from Land Registration Domain for models land use rights and restrictions how those rights and restrictions relate to property and people.';

CREATE SCHEMA IF NOT EXISTS transaction
AUTHORIZATION postgres;
COMMENT ON SCHEMA transaction IS 'Used to track all changes made to data as a result of an application service.';

CREATE OR REPLACE FUNCTION public.uuid_generate_v1(
	)
    RETURNS uuid
    LANGUAGE 'c'
    COST 1
    VOLATILE STRICT PARALLEL SAFE 
AS '$libdir/uuid-ossp', 'uuid_generate_v1'
;

ALTER FUNCTION public.uuid_generate_v1()
    OWNER TO postgres;
-- Function public.f_for_trg_track_changes --
CREATE OR REPLACE FUNCTION public.f_for_trg_track_changes(

) RETURNS trigger 
AS $$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        IF (NEW.rowversion != OLD.rowversion) THEN
            RAISE EXCEPTION 'row_has_different_change_time';
        END IF;
        IF (NEW.change_action != 'd') THEN
            NEW.change_action := 'u';
        END IF;
        IF OLD.rowversion > 200000000 THEN
            NEW.rowversion = 1;
        ELSE
            NEW.rowversion = OLD.rowversion + 1;
        END IF;
    ELSIF (TG_OP = 'INSERT') THEN
        NEW.change_action := 'i';
        NEW.rowversion = 1;
    END IF;
    NEW.change_time := now();
    IF NEW.change_user is null then
      NEW.change_user = 'db:' || current_user;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION public.f_for_trg_track_changes(

) IS 'This function is called from triggers in every table that has the columns to track changes. <br/>
If the change_user is null then it is filled with the value from the database user prefixed by ''db:''.
It also checks if the record has been already updated from another client application by checking the rowversion.';
    
-- Function public.f_for_trg_track_history --
CREATE OR REPLACE FUNCTION public.f_for_trg_track_history(

) RETURNS trigger 
AS $$
DECLARE
    table_name_main varchar;
    table_name_historic varchar;
    insert_col_part varchar;
    values_part varchar;
BEGIN
    table_name_main = TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME;
    table_name_historic = table_name_main || '_historic';
    insert_col_part = (select string_agg(column_name, ',') 
      from information_schema.columns  
      where table_schema= TG_TABLE_SCHEMA and table_name = TG_TABLE_NAME);
    values_part = '$1.' || replace(insert_col_part, ',' , ',$1.');

    IF (TG_OP = 'DELETE') THEN
        OLD.change_action := 'd';
    END IF;
    EXECUTE 'INSERT INTO ' || table_name_historic || '(' || insert_col_part || ') SELECT ' || values_part || ';' USING OLD;
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION public.f_for_trg_track_history(

) IS 'This function is called after a change is happening in a table to push the former values to the historic keeping table.';
    
-- Function public.get_translation --
CREATE OR REPLACE FUNCTION public.get_translation(mixed_value character varying, language_code character varying)
  RETURNS character varying AS
$BODY$
DECLARE
  delimiter_word varchar;
  language_index integer;
  result varchar;
BEGIN
  if mixed_value is null then
    return mixed_value;
  end if;
  delimiter_word = '::::';
  language_index = (select lng.row_number from (select row_number() over(order by item_order asc) as row_number, code from system.language) lng where lower(lng.code)=lower(language_code));
  result = split_part(mixed_value, delimiter_word, language_index);
  if result is null or result = '' then
    language_index = (select lng.row_number from (select row_number() over(order by item_order asc) as row_number, code, is_default from system.language) lng where lng.is_default limit 1);
    result = split_part(mixed_value, delimiter_word, language_index);
    if result is null or result = '' then
      result = mixed_value;
    end if;
  end if;
  return result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_translation(character varying, character varying)
  OWNER TO postgres;
COMMENT ON FUNCTION public.get_translation(character varying, character varying) IS 'This function is used to translate the values that are supposed to be multilingual like the reference data values (display_value)';

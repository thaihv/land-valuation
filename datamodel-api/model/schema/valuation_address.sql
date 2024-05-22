-- Table: address.address
CREATE TABLE IF NOT EXISTS address.address
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	description character varying(255) COLLATE pg_catalog."default",
    ext_address_id character varying(40) COLLATE pg_catalog."default",
	rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT address_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS address.address
    OWNER to postgres;

COMMENT ON TABLE address.address
    IS 'Describes a postal or physical address.';

COMMENT ON COLUMN address.address.id
    IS 'Address identifier.';

COMMENT ON COLUMN address.address.description
    IS 'The postal or physical address or if no formal addressing is used, a description or place name for the location.';

COMMENT ON COLUMN address.address.ext_address_id
    IS 'Optional identifier for the address that may reference further address details from an external system (e.g. address validation database).';

COMMENT ON COLUMN address.address.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN address.address.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
	
COMMENT ON COLUMN address.address.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN address.address.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN address.address.change_time
    IS 'The date and time the row was last modified.';
-- Index: address_on_rowidentifier
CREATE INDEX IF NOT EXISTS address_on_rowidentifier
    ON address.address USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Trigger: __track_changes
CREATE OR REPLACE TRIGGER __track_changes
    BEFORE INSERT OR UPDATE 
    ON address.address
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_changes();
-- Trigger: __track_history
CREATE OR REPLACE TRIGGER __track_history
    AFTER DELETE OR UPDATE 
    ON address.address
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_history();
    
-- Table: address.address_historic
/*
CREATE TABLE IF NOT EXISTS address.address_historic
(
	id character varying(40) COLLATE pg_catalog."default" NOT NULL,
	description character varying(255) COLLATE pg_catalog."default",
    ext_address_id character varying(40) COLLATE pg_catalog."default",
	rowidentifier character varying(40) COLLATE pg_catalog."default",
    rowversion integer,
    change_action character(1) COLLATE pg_catalog."default",
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone,	
    change_time_valid_until timestamp without time zone NOT NULL DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS address.address_historic
    OWNER to postgres;
-- Index: address_historic_on_rowidentifier
CREATE INDEX IF NOT EXISTS address_historic_on_rowidentifier
    ON address.address_historic USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;	
*/    
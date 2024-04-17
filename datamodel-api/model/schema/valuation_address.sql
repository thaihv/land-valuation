-- Table: address.address
-- + SEQUENCE: address.address_id_seq
CREATE SEQUENCE IF NOT EXISTS address.address_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    CYCLE;

ALTER SEQUENCE address.address_id_seq
    OWNER TO postgres;
COMMENT ON SEQUENCE address.address_id_seq IS 'Sequence number used as the basis for the address id field. This sequence is used by the address.';
	
CREATE TABLE IF NOT EXISTS address.address
(
    id bigint NOT NULL DEFAULT nextval('address.address_id_seq'::regclass),
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
	
-- Table: address.address_historic
CREATE TABLE IF NOT EXISTS address.address_historic
(
	id bigint,
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
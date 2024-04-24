-- Table: preparation.value_type
CREATE TABLE IF NOT EXISTS preparation.value_type
(    
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT value_type_pkey PRIMARY KEY (code),
    CONSTRAINT value_type_display_value_key UNIQUE (display_value)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.value_type
    OWNER to postgres;

COMMENT ON TABLE preparation.value_type
    IS 'Code list of value types for envaluating';

COMMENT ON COLUMN preparation.value_type.code
    IS 'The code for the value type.';

COMMENT ON COLUMN preparation.value_type.display_value
    IS 'Displayed value of the value type.';

COMMENT ON COLUMN preparation.value_type.description
    IS 'Description of the value type.';
    
COMMENT ON COLUMN preparation.value_type.status
    IS 'Status in active of the value type as active (a) or inactive (i).';
       
-- Table: preparation.valuation_unit_type
-- + SEQUENCE: preparation.valuation_unit_type_id_seq
CREATE SEQUENCE IF NOT EXISTS preparation.valuation_unit_type_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999
    CACHE 1
    CYCLE;

ALTER SEQUENCE preparation.valuation_unit_type_id_seq
    OWNER TO postgres;	
COMMENT ON SEQUENCE preparation.valuation_unit_type_id_seq IS 'Sequence number used as the basis for the valuation_unit_type id field. This sequence is used by the valuation_unit_type.';	
	
CREATE TABLE IF NOT EXISTS preparation.valuation_unit_type
(
    id bigint NOT NULL DEFAULT nextval('preparation.valuation_unit_type_id_seq'::regclass),
	name character varying(500) COLLATE pg_catalog."default" NOT NULL,    
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,        
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT public.uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
	change_time timestamp without time zone NOT NULL DEFAULT now(),	
    CONSTRAINT valuation_unit_type_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_unit_type_name_key UNIQUE (name)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.valuation_unit_type
    OWNER to postgres;

COMMENT ON TABLE preparation.valuation_unit_type
    IS 'List of the valuation unit types.';

COMMENT ON COLUMN preparation.valuation_unit_type.name
    IS 'Display name of the valuation unit type.';

COMMENT ON COLUMN preparation.valuation_unit_type.description
    IS 'Description of the valuation unit type.';

COMMENT ON COLUMN preparation.valuation_unit_type.status
    IS 'Status in active of the valuation unit type as active (a) or inactive (i).';
	
COMMENT ON COLUMN preparation.valuation_unit_type.rowidentifier
    IS 'Identifies the all change records for the row in the table.';
	
COMMENT ON COLUMN preparation.valuation_unit_type.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN preparation.valuation_unit_type.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN preparation.valuation_unit_type.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN preparation.valuation_unit_type.change_time
    IS 'The date and time the row was last modified.';
-- + Index: valuation_unit_type_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_unit_type_on_rowidentifier
    ON preparation.valuation_unit_type USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;    
-- + Version: valuation_unit_historic
CREATE OR REPLACE TRIGGER __track_changes
    BEFORE INSERT OR UPDATE 
    ON preparation.valuation_unit_type
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_changes();
CREATE OR REPLACE TRIGGER __track_history
    AFTER DELETE OR UPDATE 
    ON preparation.valuation_unit_type
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_history();	
CREATE TABLE IF NOT EXISTS preparation.valuation_unit_type_historic
(
    id bigint,
    name character varying(500),
    description character varying(1000),
    status character(1),
    rowidentifier character varying(40),
    rowversion integer,
    change_action character(1),
    change_user character varying(50),
    change_time timestamp without time zone,
    change_time_valid_until timestamp without time zone DEFAULT now() NOT NULL
);	
COMMENT ON TABLE preparation.valuation_unit_type_historic
    IS 'Version table for valuation_unit_type.';	
-- Table: preparation.valuation_unit_category
-- + SEQUENCE: preparation.valuation_unit_category_id_seq
CREATE SEQUENCE IF NOT EXISTS preparation.valuation_unit_category_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999
    CACHE 1
    CYCLE;
ALTER SEQUENCE preparation.valuation_unit_category_id_seq
    OWNER TO postgres;
COMMENT ON SEQUENCE preparation.valuation_unit_category_id_seq IS 'Sequence number used as the basis for the valuation_unit_category id field.';

CREATE TABLE IF NOT EXISTS preparation.valuation_unit_category
(
    id bigint NOT NULL DEFAULT nextval('preparation.valuation_unit_category_id_seq'::regclass),
	name character varying(500) COLLATE pg_catalog."default" NOT NULL,
	description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
	vunit_type_id bigint NOT NULL,
	rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT public.uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT valuation_unit_category_pkey PRIMARY KEY (id),
	CONSTRAINT valuation_unit_category_vunit_id_fkey FOREIGN KEY (vunit_type_id)
        REFERENCES preparation.valuation_unit_type (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.valuation_unit_category
    OWNER to postgres;

COMMENT ON TABLE preparation.valuation_unit_category
    IS 'List of the valuation unit categories';

COMMENT ON COLUMN preparation.valuation_unit_category.name
    IS 'Display name of the category.';

COMMENT ON COLUMN preparation.valuation_unit_category.description
    IS 'Description of the category.';

COMMENT ON COLUMN preparation.valuation_unit_category.status
    IS 'Status in active of the category as active (a) or inactive (i).';

COMMENT ON COLUMN preparation.valuation_unit_category.vunit_type_id
    IS 'Refer to identifying of a valuation unit type.';
	
COMMENT ON COLUMN preparation.valuation_unit_category.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN preparation.valuation_unit_category.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
	
COMMENT ON COLUMN preparation.valuation_unit_category.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN preparation.valuation_unit_category.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN preparation.valuation_unit_category.change_time
    IS 'The date and time the row was last modified.';
-- + Index: valuation_unit_type_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_unit_category_on_rowidentifier
    ON preparation.valuation_unit_category USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- + Version: valuation_unit_type_historic
CREATE OR REPLACE TRIGGER __track_changes
    BEFORE INSERT OR UPDATE 
    ON preparation.valuation_unit_category
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_changes();
CREATE OR REPLACE TRIGGER __track_history
    AFTER DELETE OR UPDATE 
    ON preparation.valuation_unit_category
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_history();	
CREATE TABLE IF NOT EXISTS preparation.valuation_unit_category_historic
(
    id bigint,
    name character varying(500),
    description character varying(1000),
    status character(1),
	vunit_type_id bigint NOT NULL,
    rowidentifier character varying(40),
    rowversion integer,
    change_action character(1),
    change_user character varying(50),
    change_time timestamp without time zone,
    change_time_valid_until timestamp without time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE preparation.valuation_unit_category_historic
    IS 'Version table for valuation_unit_category.';	

    
-- Table: preparation.valuation_parameter
-- + SEQUENCE: preparation.valuation_parameter_id_seq
CREATE SEQUENCE IF NOT EXISTS preparation.valuation_parameter_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999
    CACHE 1
    CYCLE;

ALTER SEQUENCE preparation.valuation_parameter_id_seq
    OWNER TO postgres;
    
CREATE TABLE IF NOT EXISTS preparation.valuation_parameter
(
    id bigint NOT NULL DEFAULT nextval('preparation.valuation_parameter_id_seq'::regclass),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    type character varying(64) COLLATE pg_catalog."default",
    description character varying(1000) COLLATE pg_catalog."default",
    is_active boolean NOT NULL DEFAULT true,
    is_mandatory boolean NOT NULL DEFAULT true,
    is_virtual boolean NOT NULL DEFAULT false,
    CONSTRAINT valuation_parameter_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.valuation_parameter
    OWNER to postgres;

COMMENT ON TABLE preparation.valuation_parameter
    IS 'List of all technical parameters for valuation process';

COMMENT ON COLUMN preparation.valuation_parameter.name
    IS 'Display name of the technical parameter.';

COMMENT ON COLUMN preparation.valuation_parameter.type
    IS 'Type of the technical parameter as Numeric, Boolean, Enumerated, String...';
    
COMMENT ON COLUMN preparation.valuation_parameter.description
    IS 'Description of the technical parameter.';

COMMENT ON COLUMN preparation.valuation_parameter.is_active
    IS 'Status active of the technical parameter as active (true) or inactive (false).';

COMMENT ON COLUMN preparation.valuation_parameter.is_mandatory
    IS 'Status mandatory of the technical parameter as mandatory (true) or not (false).';

COMMENT ON COLUMN preparation.valuation_parameter.is_virtual
    IS 'Status virtual of the technical parameter as for virtual (true) or not (false).';
  
-- Table: preparation.categories_parameters_links
CREATE TABLE IF NOT EXISTS preparation.categories_parameters_links
(    
    category_id bigint NOT NULL,
	parameter_id bigint NOT NULL,
	CONSTRAINT categories_parameters_links_pkey PRIMARY KEY (category_id, parameter_id),
    CONSTRAINT categories_parameters_links_parameter_id_fkey FOREIGN KEY (parameter_id)
        REFERENCES preparation.valuation_parameter (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT categories_parameters_links_category_id_fkey FOREIGN KEY (category_id)
        REFERENCES preparation.valuation_unit_category (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.categories_parameters_links
    OWNER to postgres;	
COMMENT ON TABLE preparation.categories_parameters_links
    IS 'Associates a category with one or more parameters';	
	
-- Table: preparation.parameter_setting
CREATE TABLE IF NOT EXISTS preparation.parameter_setting
(
    id bigint NOT NULL,
    key character varying(100) COLLATE pg_catalog."default" NOT NULL,
    value character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT parameter_setting_pkey PRIMARY KEY (id, key),
    CONSTRAINT parameter_setting_id_fkey FOREIGN KEY (id)
        REFERENCES preparation.valuation_parameter (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parameter_setting
    OWNER to postgres;

COMMENT ON TABLE preparation.parameter_setting
    IS 'List of parameter settings in format Key/Value';

COMMENT ON COLUMN preparation.parameter_setting.key
    IS 'Key name of a parameter setting.';

COMMENT ON COLUMN preparation.parameter_setting.value
    IS 'Value of the parameter setting key.';	
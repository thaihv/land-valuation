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
-- Table: preparation.tech_parameter
CREATE TABLE IF NOT EXISTS preparation.tech_parameter
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    type character varying(64) COLLATE pg_catalog."default",
    description character varying(1000) COLLATE pg_catalog."default",
    is_active boolean NOT NULL DEFAULT true,
    is_mandatory boolean NOT NULL DEFAULT true,
    is_virtual boolean NOT NULL DEFAULT false,
    CONSTRAINT tech_parameter_pkey PRIMARY KEY (code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.tech_parameter
    OWNER to postgres;

COMMENT ON TABLE preparation.tech_parameter
    IS 'List of all technical parameters for valuation process';
    
COMMENT ON COLUMN preparation.tech_parameter.code
    IS 'The code for the technical parameter.';    

COMMENT ON COLUMN preparation.tech_parameter.name
    IS 'Display name of the technical parameter.';

COMMENT ON COLUMN preparation.tech_parameter.type
    IS 'Type of the technical parameter as Numeric, Boolean, Enumerated, String...';
    
COMMENT ON COLUMN preparation.tech_parameter.description
    IS 'Description of the technical parameter.';

COMMENT ON COLUMN preparation.tech_parameter.is_active
    IS 'Status active of the technical parameter as active (true) or inactive (false).';

COMMENT ON COLUMN preparation.tech_parameter.is_mandatory
    IS 'Status mandatory of the technical parameter as mandatory (true) or not (false).';

COMMENT ON COLUMN preparation.tech_parameter.is_virtual
    IS 'Status virtual of the technical parameter as for virtual (true) or not (false).';
  
-- Table: preparation.parameter_setting
CREATE TABLE IF NOT EXISTS preparation.parameter_setting
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    key character varying(40) COLLATE pg_catalog."default" NOT NULL,
    value character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT parameter_setting_pkey PRIMARY KEY (code, key),
    CONSTRAINT parameter_setting_code_fkey FOREIGN KEY (code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parameter_setting
    OWNER to postgres;

COMMENT ON TABLE preparation.parameter_setting
    IS 'List of parameter settings in format Key/Value';
    
COMMENT ON COLUMN preparation.parameter_setting.code
    IS 'The code for the technical parameter.';    

COMMENT ON COLUMN preparation.parameter_setting.key
    IS 'Key name of a parameter setting.';

COMMENT ON COLUMN preparation.parameter_setting.value
    IS 'Value of the parameter setting key.';	
    
-- Table: preparation.area_type
CREATE TABLE IF NOT EXISTS preparation.area_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT area_type_pkey PRIMARY KEY (code),
    CONSTRAINT area_type_display_value UNIQUE (display_value)
);

ALTER TABLE IF EXISTS preparation.area_type
    OWNER to postgres;

COMMENT ON TABLE preparation.area_type
    IS 'Code list of area types. Identifies the types of area (calculated, official, survey defined, etc) that can be recorded for a valuation unit.';

COMMENT ON COLUMN preparation.area_type.code
    IS 'Code of the area type.';

COMMENT ON COLUMN preparation.area_type.description
    IS 'Description of the area type.';

COMMENT ON COLUMN preparation.area_type.display_value
    IS 'Displayed value of the area type.';

COMMENT ON COLUMN preparation.area_type.status
    IS 'Status in active of the area type as active (a) or inactive (i).';          
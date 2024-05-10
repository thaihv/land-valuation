-- Table: preparation.tech_parameter
-- + SEQUENCE: preparation.tech_parameter_id_seq
CREATE SEQUENCE IF NOT EXISTS preparation.tech_parameter_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999
    CACHE 1
    CYCLE;

ALTER SEQUENCE preparation.tech_parameter_id_seq
    OWNER TO postgres;
    
CREATE TABLE IF NOT EXISTS preparation.tech_parameter
(
    id bigint NOT NULL DEFAULT nextval('preparation.tech_parameter_id_seq'::regclass),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    type character varying(64) COLLATE pg_catalog."default",
    description character varying(1000) COLLATE pg_catalog."default",
    is_active boolean NOT NULL DEFAULT true,
    is_mandatory boolean NOT NULL DEFAULT true,
    is_virtual boolean NOT NULL DEFAULT false,
    CONSTRAINT tech_parameter_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.tech_parameter
    OWNER to postgres;

COMMENT ON TABLE preparation.tech_parameter
    IS 'List of all technical parameters for valuation process';

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
    id bigint NOT NULL,
    key character varying(100) COLLATE pg_catalog."default" NOT NULL,
    value character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT parameter_setting_pkey PRIMARY KEY (id, key),
    CONSTRAINT parameter_setting_id_fkey FOREIGN KEY (id)
        REFERENCES preparation.tech_parameter (id) MATCH SIMPLE
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
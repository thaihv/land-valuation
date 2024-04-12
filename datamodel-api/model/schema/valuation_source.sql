-- Table: source.source_type
CREATE TABLE IF NOT EXISTS source.source_type
(    
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(1000) COLLATE pg_catalog."default" NOT NULL,
	description character varying(1000) COLLATE pg_catalog."default",
	status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT source_type_pkey PRIMARY KEY (code),
    CONSTRAINT source_type_display_value_key UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.source_type
    OWNER to postgres;

COMMENT ON TABLE source.source_type
    IS 'Code list of source types include in valuation process';

COMMENT ON COLUMN source.source_type.code
    IS 'The code for the source type.';

COMMENT ON COLUMN source.source_type.display_value
    IS 'Displayed value of the source type.';

COMMENT ON COLUMN source.source_type.description
    IS 'Description of the source type.';
	
COMMENT ON COLUMN source.source_type.status
    IS 'Status in active of the source type as active (a) or inactive (i).';	
       
-- Table: source.source
-- + SEQUENCE: source.source_id_seq
CREATE SEQUENCE IF NOT EXISTS source.source_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 99999999
    CACHE 1
    CYCLE;

ALTER SEQUENCE source.source_id_seq
    OWNER TO postgres;	
COMMENT ON SEQUENCE source.source_id_seq IS 'Sequence number used as the basis for the source id field. This sequence is used by the source.';	
	
CREATE TABLE IF NOT EXISTS source.source
(    
    id bigint NOT NULL DEFAULT nextval('source.source_id_seq'::regclass),
	name character varying(200) COLLATE pg_catalog."default" NOT NULL,
	content character varying(4000) COLLATE pg_catalog."default",
	acceptance timestamp(6) without time zone,
    recordation timestamp(6) without time zone,
    submission timestamp without time zone NOT NULL DEFAULT now(),
	expiration timestamp(6) without time zone,
	status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    type_code character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT source_pkey PRIMARY KEY (id),
    CONSTRAINT source_code_fkey FOREIGN KEY (type_code)
        REFERENCES source.source_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.source
    OWNER to postgres;

COMMENT ON TABLE source.source
    IS 'List of the sources in valuation process.';
	
COMMENT ON COLUMN source.source.name
    IS 'Display name of the source.';

COMMENT ON COLUMN source.source.content
    IS 'Content of the source.';
	
COMMENT ON COLUMN source.source.acceptance
    IS 'The acceptance date of source.';

COMMENT ON COLUMN source.source.recordation
    IS 'The recordation date of source.';

COMMENT ON COLUMN source.source.submission
    IS 'The submission date of source.';

COMMENT ON COLUMN source.source.expiration
    IS 'The expiration date of source.';
	
COMMENT ON COLUMN source.source.status
    IS 'Status in active of the valuation unit as active (a) or inactive (i).';

COMMENT ON COLUMN source.source.type_code
    IS 'Refer to identifying of a source type.';


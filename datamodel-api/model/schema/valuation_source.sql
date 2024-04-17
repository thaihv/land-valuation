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

-- Table: source.availability_status_type
CREATE TABLE IF NOT EXISTS source.availability_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT availability_status_type_pkey PRIMARY KEY (code),
    CONSTRAINT availability_status_type_display_value_key UNIQUE (display_value)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS source.availability_status_type
    OWNER to postgres;

COMMENT ON TABLE source.availability_status_type
    IS 'Code list indicates if a document is available, archived, destroyed or incomplete';

COMMENT ON COLUMN source.availability_status_type.code
    IS 'The code for the availability status type.';

COMMENT ON COLUMN source.availability_status_type.description
    IS 'Description of the availability status type.';

COMMENT ON COLUMN source.availability_status_type.display_value
    IS 'Displayed value of the availability status type.';

COMMENT ON COLUMN source.availability_status_type.status
    IS 'Status in active of the availability status type as active (a) or inactive (i).';

-- Table: source.presentation_form_type
CREATE TABLE IF NOT EXISTS source.presentation_form_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT presentation_form_type_pkey PRIMARY KEY (code),
    CONSTRAINT presentation_form_type_display_value_key UNIQUE (display_value)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS source.presentation_form_type
    OWNER to postgres;

COMMENT ON TABLE source.presentation_form_type
    IS 'Code list indicates the original format of the document when presented to the valuation process (e.g. Hardcopy, digital, image, video, etc)';

COMMENT ON COLUMN source.presentation_form_type.code
    IS 'The code for the presentation form type.';

COMMENT ON COLUMN source.presentation_form_type.description
    IS 'Description of the presentation form type.';

COMMENT ON COLUMN source.presentation_form_type.display_value
    IS 'Displayed value of the presentation form type.';

COMMENT ON COLUMN source.presentation_form_type.status
    IS 'Status of the presentation form type as active (a) or inactive (i).';
       
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
	assess_nr character varying(20) COLLATE pg_catalog."default" NOT NULL,
	reference_nr character varying(255) COLLATE pg_catalog."default",
	content character varying(4000) COLLATE pg_catalog."default",
	archive_id bigint,
	document_id bigint,
	ext_archive_id character varying(64) COLLATE pg_catalog."default",
	owner_name character varying(255) COLLATE pg_catalog."default",
	version character varying(255) COLLATE pg_catalog."default",
	signing_date timestamp(6) without time zone,
    acceptance timestamp(6) without time zone,
    recordation timestamp(6) without time zone,
	submission timestamp without time zone NOT NULL DEFAULT now(),	    
    expiration timestamp(6) without time zone,
    description character varying(255) COLLATE pg_catalog."default",
    type_code character varying(20) COLLATE pg_catalog."default",
    present_format character varying(20) COLLATE pg_catalog."default",
    availability_status_code character varying(20) COLLATE pg_catalog."default",
    classification_code character varying(20) COLLATE pg_catalog."default",
    redact_code character varying(20) COLLATE pg_catalog."default",    
    CONSTRAINT source_pkey PRIMARY KEY (id),
    CONSTRAINT availability_status_type_fkey FOREIGN KEY (availability_status_code)
        REFERENCES source.availability_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT source_presentation_form_format_fkey FOREIGN KEY (present_format)
        REFERENCES source.presentation_form_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT source_type_fkey FOREIGN KEY (type_code)
        REFERENCES source.source_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.source
    OWNER to postgres;

COMMENT ON TABLE source.source
    IS 'List of the sources in valuation process.';

COMMENT ON COLUMN source.source.assess_nr
    IS 'Reference number or identifier assigned to the document by the land valuation assessor.';

COMMENT ON COLUMN source.source.reference_nr
    IS 'Reference number or identifier assigned to the document by an external agency.';

COMMENT ON COLUMN source.source.content
    IS 'Content of the source.';	

COMMENT ON COLUMN source.source.archive_id
    IS 'Archive identifier for the source.';

COMMENT ON COLUMN source.source.document_id
    IS 'Identifier of the source to a digital document in document table.';
	
COMMENT ON COLUMN source.source.ext_archive_id
    IS 'Identifier of the source in an external document management system, if any.';

COMMENT ON COLUMN source.source.owner_name
    IS 'The name of the party that created the document.';

COMMENT ON COLUMN source.source.version
    IS 'The document version.';	

COMMENT ON COLUMN source.source.signing_date
    IS 'The date the document was signed by all parties.';
	
COMMENT ON COLUMN source.source.acceptance
    IS 'The acceptance date of source.';

COMMENT ON COLUMN source.source.recordation
    IS 'The recordation date of source.';

COMMENT ON COLUMN source.source.submission
    IS 'The submission date of source.';
	
COMMENT ON COLUMN source.source.expiration
    IS 'The expiration date of source.';

COMMENT ON COLUMN source.source.description
    IS 'Description of the source.';

COMMENT ON COLUMN source.source.type_code
    IS 'Refer to identifying of a source type.';

COMMENT ON COLUMN source.source.present_format
    IS 'The type of the representation of the content of the source.';
	
COMMENT ON COLUMN source.source.availability_status_code
    IS 'The code describing the availability status of the document.';
	
COMMENT ON COLUMN source.source.classification_code
    IS 'The security classification for this Source. Only users with the security classification (or a higher classification) will be able to view the record. If null, the record is considered unrestricted.';

COMMENT ON COLUMN source.source.redact_code
    IS 'The redact classification for this Source. Only users with the redact classification (or a higher classification) will be able to view the record with un-redacted fields. If null, the record is considered unrestricted and no redaction to the record will occur unless bulk redaction classifications have been set for fields of the record.';

-- Table: source.archive
-- + SEQUENCE: source.archive_id_seq
CREATE SEQUENCE IF NOT EXISTS source.archive_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 99999999
    CACHE 1
    CYCLE;

ALTER SEQUENCE source.archive_id_seq
    OWNER TO postgres;	
COMMENT ON SEQUENCE source.archive_id_seq IS 'Sequence number used as the basis for the archive id field. This sequence is used by the archive.';

CREATE TABLE IF NOT EXISTS source.archive
(
    id bigint NOT NULL DEFAULT nextval('source.archive_id_seq'::regclass),
	name character varying(250) COLLATE pg_catalog."default" NOT NULL,
	rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT archive_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.archive
    OWNER to postgres;

COMMENT ON TABLE source.archive
    IS 'Represents an archive where collections of physical documents may be kept such as a filing cabinet, library or storage unit.';

COMMENT ON COLUMN source.archive.id
    IS 'Identifier for the archive.';

COMMENT ON COLUMN source.archive.name
    IS 'Description of the archive and its location.';
	
COMMENT ON COLUMN source.archive.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN source.archive.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';	
	
COMMENT ON COLUMN source.archive.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN source.archive.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN source.archive.change_time
    IS 'The date and time the row was last modified.';
-- Index: archive_on_rowidentifier
CREATE INDEX IF NOT EXISTS archive_on_rowidentifier
    ON source.archive USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;	
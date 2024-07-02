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
    IS 'Status in active of the source type as current (c) or noncurrent (x).';	

-- Table: source.availability_status_type
CREATE TABLE IF NOT EXISTS source.availability_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
	display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
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
    IS 'Status in active of the availability status type as current (c) or noncurrent (x).';

-- Table: source.presentation_form_type
CREATE TABLE IF NOT EXISTS source.presentation_form_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
	display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
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
    IS 'Status in active of the presentation form type as current (c) or noncurrent (x).';
       
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
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	assess_nr character varying(20) COLLATE pg_catalog."default" NOT NULL,
	reference_nr character varying(255) COLLATE pg_catalog."default",
	content character varying(4000) COLLATE pg_catalog."default",
	archive_id character varying(40) COLLATE pg_catalog."default",
	document_id character varying(40) COLLATE pg_catalog."default",
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
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,	
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
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
	
COMMENT ON COLUMN source.source.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN source.source.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN source.source.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN source.source.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN source.source.change_time
    IS 'The date and time the row was last modified.';
-- Index: source_on_rowidentifier
CREATE INDEX IF NOT EXISTS source_on_rowidentifier
    ON source.source USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
	
-- Table: source.archive
CREATE TABLE IF NOT EXISTS source.archive
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
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
	
-- Table: source.spatial_source_type
CREATE TABLE IF NOT EXISTS source.spatial_source_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    display_value character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT spatial_source_type_pkey PRIMARY KEY (code),
    CONSTRAINT spatial_source_type_display_value_key UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.spatial_source_type
    OWNER to postgres;

COMMENT ON TABLE source.spatial_source_type
    IS 'Code list of spatial source types included in valuation process';

COMMENT ON COLUMN source.spatial_source_type.code
    IS 'The code for the spatial source type.';

COMMENT ON COLUMN source.spatial_source_type.description
    IS 'Description of the spatial source type.';

COMMENT ON COLUMN source.spatial_source_type.display_value
    IS 'Displayed value of the spatial source type.';

COMMENT ON COLUMN source.spatial_source_type.status
    IS 'Status of the spatial source type as current (c) or noncurrent (x).';

-- Table: application.request_type_requires_source_type
CREATE TABLE IF NOT EXISTS application.request_type_requires_source_type
(
    request_type_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    source_type_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT request_type_requires_source_type_pkey PRIMARY KEY (request_type_code, source_type_code),
    CONSTRAINT request_type_requires_source_type_request_type_code_fkey FOREIGN KEY (request_type_code)
        REFERENCES application.request_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT request_type_requires_source_type_source_type_code_fkey FOREIGN KEY (source_type_code)
        REFERENCES source.source_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.request_type_requires_source_type
    OWNER to postgres;
	
-- Table: source.spatial_source
CREATE TABLE IF NOT EXISTS source.spatial_source
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    procedure character varying(255) COLLATE pg_catalog."default",
    type_code character varying(20) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,	
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),		
    CONSTRAINT spatial_source_pkey PRIMARY KEY (id),
    CONSTRAINT spatial_source_id_fkey FOREIGN KEY (id)
        REFERENCES source.source (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT spatial_source_type_fkey FOREIGN KEY (type_code)
        REFERENCES source.spatial_source_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.spatial_source
    OWNER to postgres;

COMMENT ON TABLE source.spatial_source
    IS 'A spatial source may be the final (sometimes formal) documents, or all documents related to a survey in valuation process.';

COMMENT ON COLUMN source.spatial_source.id
    IS 'Spatial source identifier.';

COMMENT ON COLUMN source.spatial_source.procedure
    IS 'Procedures, steps or method adopted.';

COMMENT ON COLUMN source.spatial_source.type_code
    IS 'Refer to identifying of a source type.';

COMMENT ON COLUMN source.spatial_source.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN source.spatial_source.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
	
COMMENT ON COLUMN source.spatial_source.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN source.spatial_source.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN source.spatial_source.change_time
    IS 'The date and time the row was last modified.';
-- Index: spatial_source_on_rowidentifier
CREATE INDEX IF NOT EXISTS spatial_source_on_rowidentifier
    ON source.spatial_source USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;	
	
-- Table: source.power_of_attorney
CREATE TABLE IF NOT EXISTS source.power_of_attorney
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    attorney_name character varying(500) COLLATE pg_catalog."default",
    person_name character varying(500) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,	
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),	
    CONSTRAINT power_of_attorney_pkey PRIMARY KEY (id),
    CONSTRAINT power_of_attorney_id_fkey FOREIGN KEY (id)
        REFERENCES source.source (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS source.power_of_attorney
    OWNER to postgres;

COMMENT ON TABLE source.power_of_attorney
    IS 'Captures details for power of attorney documents.';

COMMENT ON COLUMN source.power_of_attorney.id
    IS 'Identifier for the power of attorney record. Matches the source identifier for the power of attorney record.';

COMMENT ON COLUMN source.power_of_attorney.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN source.power_of_attorney.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN source.power_of_attorney.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN source.power_of_attorney.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN source.power_of_attorney.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN source.power_of_attorney.attorney_name
    IS 'The name of the person that will act on behalf of the grantor as their attorney.';

COMMENT ON COLUMN source.power_of_attorney.person_name
    IS 'The name of the person that is granting the power of attorney (a.k.a. grantor).';
-- Index: power_of_attorney_on_rowidentifier
CREATE INDEX IF NOT EXISTS power_of_attorney_on_rowidentifier
    ON source.power_of_attorney USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;	
	
-- Table: application.application_uses_source
CREATE TABLE IF NOT EXISTS application.application_uses_source
(
    application_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    source_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,    
    change_user character varying(50) COLLATE pg_catalog."default",
	change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT application_uses_source_pkey PRIMARY KEY (application_id, source_id),
    CONSTRAINT application_uses_source_application_id_fkey FOREIGN KEY (application_id)
        REFERENCES application.application (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT application_uses_source_source_id_fkey FOREIGN KEY (source_id)
        REFERENCES source.source (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.application_uses_source
    OWNER to postgres;

COMMENT ON TABLE application.application_uses_source
    IS 'Links the application to the sources (documents) submitted with the application.';

COMMENT ON COLUMN application.application_uses_source.application_id
    IS 'Identifier for the application the record is associated to.';

COMMENT ON COLUMN application.application_uses_source.source_id
    IS 'Identifier of the source associated to the application.';

COMMENT ON COLUMN application.application_uses_source.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN application.application_uses_source.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
	
COMMENT ON COLUMN application.application_uses_source.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN application.application_uses_source.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN application.application_uses_source.change_time
    IS 'The date and time the row was last modified.';
-- Index: application_uses_source_on_application_id
CREATE INDEX IF NOT EXISTS application_uses_source_on_application_id
    ON application.application_uses_source USING btree
    (application_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: application_uses_source_on_rowidentifier
CREATE INDEX IF NOT EXISTS application_uses_source_on_rowidentifier
    ON application.application_uses_source USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: application_uses_source_on_source_id
CREATE INDEX IF NOT EXISTS application_uses_source_on_source_id
    ON application.application_uses_source USING btree
    (source_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;	 
    
-- Table: administrative.source_describes_party
CREATE TABLE IF NOT EXISTS administrative.source_describes_party
(
    party_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    source_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),        
    CONSTRAINT source_describes_party_pkey PRIMARY KEY (party_id, source_id),
    CONSTRAINT source_describes_party_party_id_fkey FOREIGN KEY (party_id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT source_describes_party_source_id_fkey FOREIGN KEY (source_id)
        REFERENCES source.source (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.source_describes_party
    OWNER to postgres;

COMMENT ON TABLE administrative.source_describes_party
    IS 'Implements the many-to-many relationship identifying administrative source instances with party instances.';

COMMENT ON COLUMN administrative.source_describes_party.party_id
    IS 'The id of the party.';

COMMENT ON COLUMN administrative.source_describes_party.source_id
    IS 'The id of source.';

COMMENT ON COLUMN administrative.source_describes_party.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.source_describes_party.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.source_describes_party.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.source_describes_party.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.source_describes_party.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.'; 
    
       
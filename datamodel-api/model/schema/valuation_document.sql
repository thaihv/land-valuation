-- Table: document.document
-- + SEQUENCE: document.document_id_seq
CREATE SEQUENCE IF NOT EXISTS document.document_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    CYCLE;

ALTER SEQUENCE document.document_id_seq
    OWNER TO postgres;
COMMENT ON SEQUENCE document.document_id_seq IS 'Sequence number used as the basis for the document id field. This sequence is used by the document.';
-- + SEQUENCE: document.document_nr_seq
CREATE SEQUENCE IF NOT EXISTS document.document_nr_seq
    CYCLE
    INCREMENT 1
    START 100
    MINVALUE 1
    MAXVALUE 99999999
    CACHE 1;

ALTER SEQUENCE document.document_nr_seq
    OWNER TO postgres;

COMMENT ON SEQUENCE document.document_nr_seq
    IS 'Sequence number used as the basis for the document unique_number field. This sequence is used by the document.';
	
CREATE TABLE IF NOT EXISTS document.document
(
    id bigint NOT NULL DEFAULT nextval('document.document_id_seq'::regclass),
	unique_number character varying(20) COLLATE pg_catalog."default" NOT NULL,
	extension character varying(5) COLLATE pg_catalog."default" NOT NULL,
	mime_type character varying(255) COLLATE pg_catalog."default" NOT NULL,
	body bytea NOT NULL,
	description character varying(500) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,	
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT document_pkey PRIMARY KEY (id),
	CONSTRAINT document_nr_unique UNIQUE (unique_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS document.document
    OWNER to postgres;

COMMENT ON TABLE document.document
    IS 'Store electronic copies of documentation provided in support of land valuation processes.';

COMMENT ON COLUMN document.document.id
    IS 'Identifier for the document.';

COMMENT ON COLUMN document.document.unique_number
    IS 'Unique number to identify the document.';

COMMENT ON COLUMN document.document.extension
    IS 'The file extension of the electronic file. E.g. pdf, tiff, doc, etc.';
	
COMMENT ON COLUMN document.document.mime_type
    IS 'Mime type of the file.';	

COMMENT ON COLUMN document.document.body
    IS 'The content of the electronic file.';

COMMENT ON COLUMN document.document.description
    IS 'Description of the valuation unit.';

COMMENT ON COLUMN document.document.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN document.document.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
	
COMMENT ON COLUMN document.document.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN document.document.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN document.document.change_time
    IS 'The date and time the row was last modified.';
-- Index: document_on_rowidentifier
CREATE INDEX IF NOT EXISTS document_on_rowidentifier
    ON document.document USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Trigger: __track_changes
CREATE OR REPLACE TRIGGER __track_changes
    BEFORE INSERT OR UPDATE 
    ON document.document
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_changes();
-- Trigger: __track_history
CREATE OR REPLACE TRIGGER __track_history
    AFTER DELETE OR UPDATE 
    ON document.document
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_history();
	
-- Table: document.document_historic
CREATE TABLE IF NOT EXISTS document.document_historic
(
	id bigint,
	unique_number character varying(20) COLLATE pg_catalog."default",
	extension character varying(5) COLLATE pg_catalog."default",
	mime_type character varying(255) COLLATE pg_catalog."default",
	body bytea,
	description character varying(500) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default",
    rowversion integer,	
    change_action character(1) COLLATE pg_catalog."default",
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone,
    change_time_valid_until timestamp without time zone NOT NULL DEFAULT now()
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS document.document_historic
    OWNER to postgres;
-- Index: document_historic_on_rowidentifier
CREATE INDEX IF NOT EXISTS document_historic_on_rowidentifier
    ON document.document_historic USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: document.document_chunk
-- + SEQUENCE: document.document_chunk_id_seq
CREATE SEQUENCE IF NOT EXISTS document.document_chunk_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    CYCLE;

ALTER SEQUENCE document.document_chunk_id_seq
    OWNER TO postgres;
COMMENT ON SEQUENCE document.document_chunk_id_seq IS 'Sequence number used as the basis for the document_chunk id field. This sequence is used by the document_chunk.';

CREATE TABLE IF NOT EXISTS document.document_chunk
(
    id bigint NOT NULL DEFAULT nextval('document.document_chunk_id_seq'::regclass),
	document_id bigint,
	claim_id bigint,
	start_position integer,
    body bytea NOT NULL,
    size integer,    
    md5 character varying(50) COLLATE pg_catalog."default",
    creation_time timestamp without time zone NOT NULL DEFAULT now(),    
    user_name character varying(50) COLLATE pg_catalog."default",    
    CONSTRAINT document_chunk_pkey PRIMARY KEY (id),
    CONSTRAINT start_unique_document_chunk UNIQUE (document_id, start_position),
    CONSTRAINT document_id_fkey FOREIGN KEY (document_id)
        REFERENCES document.document (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS document.document_chunk
    OWNER to postgres;

COMMENT ON TABLE document.document_chunk
    IS 'Holds temporary pieces of a document uploaded on the server. In case of large files, document can be split into smaller pieces (chunks) allowing reliable upload. After all pieces uploaded, client will instruct server to create a document and remove temporary files stored in this table.';

COMMENT ON COLUMN document.document_chunk.id
    IS 'Unique ID of the chunk.';

COMMENT ON COLUMN document.document_chunk.document_id
    IS 'Document ID, which will be used to create final document object. Used to group all chunks together.';

COMMENT ON COLUMN document.document_chunk.claim_id
    IS 'Claim ID. Used to clean the table when saving claim. It will guarantee that no orphan chunks left in the table.';

COMMENT ON COLUMN document.document_chunk.start_position
    IS 'Staring position of the byte in the destination document.';
	
COMMENT ON COLUMN document.document_chunk.body
    IS 'The content of the chunk.';

COMMENT ON COLUMN document.document_chunk.size
    IS 'Size of the chunk in bytes.';

COMMENT ON COLUMN document.document_chunk.md5
    IS 'Checksum of the chunk, calculated using MD5.';
	
COMMENT ON COLUMN document.document_chunk.creation_time
    IS 'Date and time when chuck was created.';

COMMENT ON COLUMN document.document_chunk.user_name
    IS 'User id or name who has uploaded the chunk.';	
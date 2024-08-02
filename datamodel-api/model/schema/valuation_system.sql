-- Table: system.language
CREATE TABLE IF NOT EXISTS system.language (
    code character varying(10) COLLATE pg_catalog."default" NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    direction character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'left-to-right'::character varying,
    CONSTRAINT language_code_pkey PRIMARY KEY (code)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS system.language
    OWNER to postgres;

COMMENT ON TABLE system.language
    IS 'List of all languages that is supported in the system';
    
COMMENT ON COLUMN system.language.code
    IS 'The code for the language (e.g., en for English, fr for French).';

COMMENT ON COLUMN system.language.name
    IS 'The name for the language.';
    
COMMENT ON COLUMN system.language.direction
    IS 'Writing direction of the language (e.g., left-to-right, right-to-left).';    
-- Table: system.content
-- + SEQUENCE: system.content_id_seq
CREATE SEQUENCE IF NOT EXISTS system.content_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    CYCLE;

ALTER SEQUENCE system.content_id_seq
    OWNER TO postgres;
    
CREATE TABLE IF NOT EXISTS system.content (
    id bigint NOT NULL DEFAULT nextval('system.content_id_seq'::regclass),
    title character varying(255) COLLATE pg_catalog."default",
    description character varying(500) COLLATE pg_catalog."default",
    content_data character varying(1000) COLLATE pg_catalog."default",
    language_code character varying(10) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT content_id_pkey PRIMARY KEY (id),
    CONSTRAINT content_language_code_fkey FOREIGN KEY (language_code) 
    	REFERENCES system.language(code) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS system.content
    OWNER to postgres;

COMMENT ON TABLE system.content
    IS 'List of all languages that is supported in the system';

COMMENT ON COLUMN system.content.title
    IS 'Language-specific metadata for content title.';
    
COMMENT ON COLUMN system.content.description
    IS 'Language-specific metadata for content description.';

COMMENT ON COLUMN system.content.language_code
    IS 'Language code indicating the content language (e.g., en for English, fr for French).';
        
COMMENT ON COLUMN system.content.content_data
    IS 'Language-specific content data, such as text, images, or multimedia.';

-- Table: system.translation
-- + SEQUENCE: system.translation_id_seq
CREATE SEQUENCE IF NOT EXISTS system.translation_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1
    CYCLE;

ALTER SEQUENCE system.translation_id_seq
    OWNER TO postgres;
    
CREATE TABLE IF NOT EXISTS system.translation (
    id bigint NOT NULL DEFAULT nextval('system.translation_id_seq'::regclass),
    source_content_id INT NOT NULL,
    target_content_id INT NOT NULL,
    source_language_code character varying(10) COLLATE pg_catalog."default" NOT NULL,
    target_language_code character varying(10) COLLATE pg_catalog."default" NOT NULL,
    translation_data character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT translation_id_pkey PRIMARY KEY (id),    
    CONSTRAINT translation_source_content_id_fkey FOREIGN KEY (source_content_id) 
    	REFERENCES system.content(id) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT translation_target_content_id_fkey FOREIGN KEY (target_content_id) 
    	REFERENCES system.content(id) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT translation_source_language_code_fkey FOREIGN KEY (source_language_code) 
    	REFERENCES system.language(code) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT translation_target_language_code_fkey FOREIGN KEY (target_language_code) 
    	REFERENCES system.language(code) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION    	
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS system.translation
    OWNER to postgres;

COMMENT ON TABLE system.translation
    IS 'List of all translations in the system';
    
COMMENT ON COLUMN system.translation.source_content_id
    IS 'Identifier for the original content being translated.';

COMMENT ON COLUMN system.translation.target_content_id
    IS 'Identifier for the translated content.';
    
COMMENT ON COLUMN system.translation.source_language_code
    IS 'Language code of the original content.';
    
COMMENT ON COLUMN system.translation.target_language_code
    IS 'Language code of the translated content.';
    
COMMENT ON COLUMN system.translation.translation_data
    IS 'Translated content data.';    

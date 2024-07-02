-- Table: administrative.gender_type
CREATE TABLE IF NOT EXISTS administrative.gender_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT gender_type_pkey PRIMARY KEY (code),
    CONSTRAINT gender_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.gender_type
    OWNER to postgres;

COMMENT ON TABLE administrative.gender_type
    IS 'Code list of gender types. Used to identify the gender of the party where the party represents an individual.';

COMMENT ON COLUMN administrative.gender_type.code
    IS 'Code of the gender type.';

COMMENT ON COLUMN administrative.gender_type.description
    IS 'Description of the gender type.';

COMMENT ON COLUMN administrative.gender_type.display_value
    IS 'Displayed value of the gender type.';

COMMENT ON COLUMN administrative.gender_type.status
    IS 'Status in active of the gender type as active (a) or inactive (i).';
    
-- Table: administrative.party_type
CREATE TABLE IF NOT EXISTS administrative.party_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT party_type_pkey PRIMARY KEY (code),
    CONSTRAINT party_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.party_type
    OWNER to postgres;

COMMENT ON TABLE administrative.party_type
    IS 'Code list of party types.Implementation of the LADM LA_PartyType class.';

COMMENT ON COLUMN administrative.party_type.code
    IS 'Code of the party type.';

COMMENT ON COLUMN administrative.party_type.description
    IS 'Description of the party type.';

COMMENT ON COLUMN administrative.party_type.display_value
    IS 'Displayed value of the party type.';

COMMENT ON COLUMN administrative.party_type.status
    IS 'Status in active of the party type as active (a) or inactive (i).';

-- Table: administrative.id_type
CREATE TABLE IF NOT EXISTS administrative.id_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT id_type_pkey PRIMARY KEY (code),
    CONSTRAINT id_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.id_type
    OWNER to postgres;

COMMENT ON TABLE administrative.id_type
    IS 'Code list of id types. Used to identify the types of id that can be used to verify the identity of an individual, group or organisation. E.g. nationalId, nationalPassport, driverLicense, etc.';

COMMENT ON COLUMN administrative.id_type.code
    IS 'Code of the id type.';

COMMENT ON COLUMN administrative.id_type.description
    IS 'Description of the id type.';

COMMENT ON COLUMN administrative.id_type.display_value
    IS 'Displayed value of the id type.';

COMMENT ON COLUMN administrative.id_type.status
    IS 'Status in active of the id type as active (a) or inactive (i).';   
    
-- Table: administrative.communication_type
CREATE TABLE IF NOT EXISTS administrative.communication_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT communication_type_pkey PRIMARY KEY (code),
    CONSTRAINT communication_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.communication_type
    OWNER to postgres;

COMMENT ON TABLE administrative.communication_type
    IS 'Code list of communication types. Used to identify the types of communication that can be used between the land valuation assessment agency and their clients.';

COMMENT ON COLUMN administrative.communication_type.code
    IS 'Code of the communication type.';

COMMENT ON COLUMN administrative.communication_type.description
    IS 'Description of the communication type.';

COMMENT ON COLUMN administrative.communication_type.display_value
    IS 'Displayed value of the communication type.';

COMMENT ON COLUMN administrative.communication_type.status
    IS 'Status in active of the communication type as active (a) or inactive (i).';         
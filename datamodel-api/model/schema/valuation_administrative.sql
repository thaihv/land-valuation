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
    
-- Table: administrative.group_party_type
CREATE TABLE IF NOT EXISTS administrative.group_party_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT group_party_type_pkey PRIMARY KEY (code),
    CONSTRAINT group_party_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.group_party_type
    OWNER to postgres;

COMMENT ON TABLE administrative.group_party_type
    IS 'Code list of group party types. Implementation of the LADM LA_GroupPartyType class. Not used by Land Valuation.';

COMMENT ON COLUMN administrative.group_party_type.code
    IS 'Code of the group party type.';

COMMENT ON COLUMN administrative.group_party_type.description
    IS 'Description of the group party type.';

COMMENT ON COLUMN administrative.group_party_type.display_value
    IS 'Displayed value of the group party type.';

COMMENT ON COLUMN administrative.group_party_type.status
    IS 'Status in active of the group party type as active (a) or inactive (i).'; 

-- Table: administrative.party
CREATE TABLE IF NOT EXISTS administrative.party
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    ext_id character varying(255) COLLATE pg_catalog."default",
    type_code character varying(20) COLLATE pg_catalog."default",      
    name character varying(255) COLLATE pg_catalog."default",
    last_name character varying(50) COLLATE pg_catalog."default",          
    alias character varying(50) COLLATE pg_catalog."default",
    birth_date timestamp(6) without time zone,
    gender_code character varying(20) COLLATE pg_catalog."default",
    address_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),    
    id_type_code character varying(20) COLLATE pg_catalog."default",
    id_number character varying(20) COLLATE pg_catalog."default",                
    email character varying(50) COLLATE pg_catalog."default",
    mobile character varying(15) COLLATE pg_catalog."default",
    phone character varying(15) COLLATE pg_catalog."default",
    fax character varying(15) COLLATE pg_catalog."default",
    preferred_communication_code character varying(20) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),            
    CONSTRAINT party_pkey PRIMARY KEY (id),
    CONSTRAINT party_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES address.address (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_gender_code_fkey FOREIGN KEY (gender_code)
        REFERENCES administrative.gender_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_id_preferred_communication_code_fkey FOREIGN KEY (preferred_communication_code)
        REFERENCES administrative.communication_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_id_type_code_fkey FOREIGN KEY (id_type_code)
        REFERENCES administrative.id_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES administrative.party_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.party
    OWNER to postgres;

COMMENT ON TABLE administrative.party
    IS 'An individual, group or organisation that is associated in some way with land office services. Implementation of the LADM LA_Party class.';

COMMENT ON COLUMN administrative.party.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.party.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.party.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.party.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.party.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN administrative.party.alias
    IS 'Any alias for the party. A party can have more than one alias. If so, the aliases should be separated by a comma.';

COMMENT ON COLUMN administrative.party.birth_date
    IS 'Date of birth of naturalPerson party, if any.';

COMMENT ON COLUMN administrative.party.email
    IS 'The contact email address of the party.';

COMMENT ON COLUMN administrative.party.ext_id
    IS 'An identifier for the party from some external system such as a customer relationship management (CRM) system.';

COMMENT ON COLUMN administrative.party.fax
    IS ' The fax number of the party.';

COMMENT ON COLUMN administrative.party.id_number
    IS 'The number from the id used to verify the identity of the party.';

COMMENT ON COLUMN administrative.party.last_name
    IS 'The last name for the party or blank for groups and organisations.';

COMMENT ON COLUMN administrative.party.mobile
    IS 'The contact mobile phone number of the party.';

COMMENT ON COLUMN administrative.party.name
    IS 'The first name(s) for the party or the group or organisation name.';

COMMENT ON COLUMN administrative.party.phone
    IS 'The main contact phone number of the party. I.e. landline.';

COMMENT ON COLUMN administrative.party.address_id
    IS 'Identifier for the contact address of the party.';

COMMENT ON COLUMN administrative.party.preferred_communication_code
    IS 'Used to indicate the preferred means of communication the party will use with the land administration agency.';

COMMENT ON COLUMN administrative.party.gender_code
    IS 'Identifies the gender for the party. If the party is of type naturalPerson then a gender code must be specified.';

COMMENT ON COLUMN administrative.party.id_type_code
    IS 'Used to indicate the type of id used to verify the identity of the party.';

COMMENT ON COLUMN administrative.party.type_code
    IS 'The type of the party. E.g. naturalPerson, nonNaturalPerson, etc.';
    
-- Table: administrative.group_party
CREATE TABLE IF NOT EXISTS administrative.group_party
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    type_code character varying(20) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),        
    CONSTRAINT group_party_pkey PRIMARY KEY (id),
    CONSTRAINT group_party_id_fkey FOREIGN KEY (id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT group_party_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES administrative.group_party_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION  
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.group_party
    OWNER to postgres;

COMMENT ON TABLE administrative.group_party
    IS 'Groups any number of parties into a distinct entity. Implementation of the LADM LA_GroupParty class.';

COMMENT ON COLUMN administrative.group_party.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.group_party.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.group_party.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.group_party.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.group_party.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN administrative.group_party.type_code
    IS 'The type of the group party. E.g. family, tribe, association, etc.';
    
-- Table: administrative.party_member
CREATE TABLE IF NOT EXISTS administrative.party_member
(
    group_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    party_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    share numeric(17,7),    
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT party_member_pkey PRIMARY KEY (group_id, party_id),
    CONSTRAINT party_member_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES administrative.group_party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_member_party_id_fkey FOREIGN KEY (party_id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.party_member
    OWNER to postgres;

COMMENT ON TABLE administrative.party_member
    IS 'Identifies the parties belonging to a group party. Implementation of the LADM LA_PartyMember class.';

COMMENT ON COLUMN administrative.party_member.group_id
    IS 'The id of group party.';

COMMENT ON COLUMN administrative.party_member.party_id
    IS 'The id of the party.';

COMMENT ON COLUMN administrative.party_member.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.party_member.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.party_member.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.party_member.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.party_member.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN administrative.party_member.share
    IS 'The share of a RRR held by a party member expressed as a fraction with a numerator and a denominator.';
    
-- Table: administrative.party_role_type
CREATE TABLE IF NOT EXISTS administrative.party_role_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT party_role_type_pkey PRIMARY KEY (code),
    CONSTRAINT party_role_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.party_role_type
    OWNER to postgres;

COMMENT ON TABLE administrative.party_role_type
    IS 'Code list of party role types. Used to identify the types of role a party can have in relation to land office transactions and data. E.g. applicant, bank, lodgingAgent, notary, etc.';

COMMENT ON COLUMN administrative.party_role_type.code
    IS 'Code of the party role type.';

COMMENT ON COLUMN administrative.party_role_type.description
    IS 'Description of the party role type.';

COMMENT ON COLUMN administrative.party_role_type.display_value
    IS 'Displayed value of the party role type.';

COMMENT ON COLUMN administrative.party_role_type.status
    IS 'Status in active of the party role type as active (a) or inactive (i).'; 
    
-- Table: administrative.party_role
CREATE TABLE IF NOT EXISTS administrative.party_role
(
    party_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    type_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),        
    CONSTRAINT party_role_pkey PRIMARY KEY (party_id, type_code),
    CONSTRAINT party_role_party_id_fkey FOREIGN KEY (party_id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_role_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES administrative.party_role_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.party_role
    OWNER to postgres;

COMMENT ON TABLE administrative.party_role
    IS 'Identifies the roles a party has in relation to the land office transactions and data.';

COMMENT ON COLUMN administrative.party_role.party_id
    IS 'The id of the party.';

COMMENT ON COLUMN administrative.party_role.type_code
    IS 'The code of role.';

COMMENT ON COLUMN administrative.party_role.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.party_role.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.party_role.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.party_role.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.party_role.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';    
    
-- Table: administrative.rrr_group_type
CREATE TABLE IF NOT EXISTS administrative.rrr_group_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT rrr_group_type_pkey PRIMARY KEY (code),
    CONSTRAINT rrr_group_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.rrr_group_type
    OWNER to postgres;

COMMENT ON TABLE administrative.rrr_group_type
    IS 'Code list of rrr status types. E.g. current, historic, pending, previous.';

COMMENT ON COLUMN administrative.rrr_group_type.code
    IS 'Code of the RRR group type.';

COMMENT ON COLUMN administrative.rrr_group_type.description
    IS 'Description of the RRR group type.';

COMMENT ON COLUMN administrative.rrr_group_type.display_value
    IS 'Displayed value of the RRR group type.';

COMMENT ON COLUMN administrative.rrr_group_type.status
    IS 'Status in active of the RRR group type as active (a) or inactive (i).';
            
-- Table: administrative.rrr_type
CREATE TABLE IF NOT EXISTS administrative.rrr_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    rrr_group_type_code character varying(20) COLLATE pg_catalog."default",
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    is_primary boolean NOT NULL DEFAULT false,
    share_check boolean NOT NULL,
    party_required boolean NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,                
    CONSTRAINT rrr_type_pkey PRIMARY KEY (code),
    CONSTRAINT rrr_type_display_value UNIQUE (display_value),
    CONSTRAINT rrr_type_rrr_group_type_code_fkey FOREIGN KEY (rrr_group_type_code)
        REFERENCES administrative.rrr_group_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.rrr_type
    OWNER to postgres;

COMMENT ON TABLE administrative.rrr_type
    IS 'Code list of RRR types. E.g. freehold owernship, lease, mortgage, caveat, etc.';

COMMENT ON COLUMN administrative.rrr_type.code
    IS 'Code of the RRR type.';

COMMENT ON COLUMN administrative.rrr_type.description
    IS 'Description of the RRR type.';

COMMENT ON COLUMN administrative.rrr_type.display_value
    IS 'Displayed value of the RRR type.';

COMMENT ON COLUMN administrative.rrr_type.is_primary
    IS 'Flag to indicate if the RRR type is a primary RRR.';

COMMENT ON COLUMN administrative.rrr_type.party_required
    IS 'Flag to indicate at least one party must be associated with this RRR.';

COMMENT ON COLUMN administrative.rrr_type.share_check
    IS 'Flag to indicate the that the sum of all shares for this RRR must be checked to ensure it equals 1.';

COMMENT ON COLUMN administrative.rrr_type.status
    IS 'Status in active of the RRR type as active (a) or inactive (i).';

COMMENT ON COLUMN administrative.rrr_type.rrr_group_type_code
    IS 'Identifies if the RRR type is a right, restriction or a responsibility.';
    
-- Table: administrative.mortgage_type
CREATE TABLE IF NOT EXISTS administrative.mortgage_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT mortgage_type_pkey PRIMARY KEY (code),
    CONSTRAINT mortgage_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.mortgage_type
    OWNER to postgres;

COMMENT ON TABLE administrative.mortgage_type
    IS 'Code list of Mortgage types. E.g. levelPayment, linear, etc.';

COMMENT ON COLUMN administrative.mortgage_type.code
    IS 'Code of the mortgage type.';

COMMENT ON COLUMN administrative.mortgage_type.description
    IS 'Description of the mortgage type.';

COMMENT ON COLUMN administrative.mortgage_type.display_value
    IS 'Displayed value of the mortgage type.';

COMMENT ON COLUMN administrative.mortgage_type.status
    IS 'Status in active of the mortgage type as active (a) or inactive (i).';
    
-- Table: administrative.condition_type
CREATE TABLE IF NOT EXISTS administrative.condition_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT condition_type_pkey PRIMARY KEY (code),
    CONSTRAINT condition_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.condition_type
    OWNER to postgres;

COMMENT ON TABLE administrative.condition_type
    IS 'Code list of condition types.';

COMMENT ON COLUMN administrative.condition_type.code
    IS 'Code of the condition type.';

COMMENT ON COLUMN administrative.condition_type.description
    IS 'Description of the condition type.';

COMMENT ON COLUMN administrative.condition_type.display_value
    IS 'Displayed value of the condition type.';

COMMENT ON COLUMN administrative.condition_type.status
    IS 'Status in active of the condition type as active (a) or inactive (i).';        
                                  
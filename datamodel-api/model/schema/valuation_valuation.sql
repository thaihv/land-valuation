-- Table: valuation.value_type
CREATE TABLE IF NOT EXISTS valuation.value_type
(    
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT value_type_pkey PRIMARY KEY (code),
    CONSTRAINT value_type_display_value_key UNIQUE (display_value)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.value_type
    OWNER to postgres;

COMMENT ON TABLE valuation.value_type
    IS 'Code list of value types used for valuation process.';

COMMENT ON COLUMN valuation.value_type.code
    IS 'The code for the value type.';

COMMENT ON COLUMN valuation.value_type.display_value
    IS 'Displayed value of the value type.';

COMMENT ON COLUMN valuation.value_type.description
    IS 'Description of the value type.';
    
COMMENT ON COLUMN valuation.value_type.status
    IS 'Status in active of the value type as active (a) or inactive (i).';
-- Table: valuation.valuation_unit_category
-- + SEQUENCE: valuation.valuation_unit_category_id_seq
CREATE SEQUENCE IF NOT EXISTS valuation.valuation_unit_category_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999
    CACHE 1
    CYCLE;

ALTER SEQUENCE valuation.valuation_unit_category_id_seq
    OWNER TO postgres;	
COMMENT ON SEQUENCE valuation.valuation_unit_category_id_seq IS 'Sequence number used as the basis for the valuation_unit_category id field. This sequence is used by the valuation_unit_category.';	
	
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_category
(
    id bigint NOT NULL DEFAULT nextval('valuation.valuation_unit_category_id_seq'::regclass),
	name character varying(500) COLLATE pg_catalog."default" NOT NULL,    
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,        
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT public.uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
	change_time timestamp without time zone NOT NULL DEFAULT now(),	
    CONSTRAINT valuation_unit_category_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_unit_category_name_key UNIQUE (name)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_category
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_category
    IS 'List of the valuation unit categories.';

COMMENT ON COLUMN valuation.valuation_unit_category.name
    IS 'Display name of the valuation unit category.';

COMMENT ON COLUMN valuation.valuation_unit_category.description
    IS 'Description of the valuation unit category.';

COMMENT ON COLUMN valuation.valuation_unit_category.status
    IS 'Status in active of the valuation unit category as active (a) or inactive (i).';
	
COMMENT ON COLUMN valuation.valuation_unit_category.rowidentifier
    IS 'Identifies the all change records for the row in the table.';
	
COMMENT ON COLUMN valuation.valuation_unit_category.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN valuation.valuation_unit_category.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit_category.change_user
    IS 'The user id of the last person to modify the row.';
	
COMMENT ON COLUMN valuation.valuation_unit_category.change_time
    IS 'The date and time the row was last modified.';
-- + Index: valuation_unit_category_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_unit_category_on_rowidentifier
    ON valuation.valuation_unit_category USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;    
-- + Version: valuation_unit_historic
CREATE OR REPLACE TRIGGER __track_changes
    BEFORE INSERT OR UPDATE 
    ON valuation.valuation_unit_category
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_changes();
CREATE OR REPLACE TRIGGER __track_history
    AFTER DELETE OR UPDATE 
    ON valuation.valuation_unit_category
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_history();	
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_category_historic
(
    id bigint,
    name character varying(500),
    description character varying(1000),
    status character(1),
    rowidentifier character varying(40),
    rowversion integer,
    change_action character(1),
    change_user character varying(50),
    change_time timestamp without time zone,
    change_time_valid_until timestamp without time zone DEFAULT now() NOT NULL
);	
COMMENT ON TABLE valuation.valuation_unit_category_historic
    IS 'Version table for valuation_unit_category.';
    
-- Table: valuation.valuation_unit_type
-- + SEQUENCE: valuation.valuation_unit_type_id_seq
CREATE SEQUENCE IF NOT EXISTS valuation.valuation_unit_type_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999
    CACHE 1
    CYCLE;
ALTER SEQUENCE valuation.valuation_unit_type_id_seq
    OWNER TO postgres;
COMMENT ON SEQUENCE valuation.valuation_unit_type_id_seq IS 'Sequence number used as the basis for the valuation_unit_type id field.';

CREATE TABLE IF NOT EXISTS valuation.valuation_unit_type
(
    id bigint NOT NULL DEFAULT nextval('valuation.valuation_unit_type_id_seq'::regclass),
	name character varying(500) COLLATE pg_catalog."default" NOT NULL,
	description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
	vunit_category_id bigint NOT NULL,
	rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT public.uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT valuation_unit_type_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_unit_type_vunit_category_id_fkey FOREIGN KEY (vunit_category_id)
        REFERENCES valuation.valuation_unit_category (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_type
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_type
    IS 'List of the valuation unit types.';

COMMENT ON COLUMN valuation.valuation_unit_type.name
    IS 'Display name of the type.';

COMMENT ON COLUMN valuation.valuation_unit_type.description
    IS 'Description of the type.';

COMMENT ON COLUMN valuation.valuation_unit_type.status
    IS 'Status in active of the type as active (a) or inactive (i).';

COMMENT ON COLUMN valuation.valuation_unit_type.vunit_category_id
    IS 'Refer to identifying of a valuation unit category.';
	
COMMENT ON COLUMN valuation.valuation_unit_type.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_unit_type.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
	
COMMENT ON COLUMN valuation.valuation_unit_type.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit_type.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.valuation_unit_type.change_time
    IS 'The date and time the row was last modified.';
-- + Index: valuation_unit_type_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_unit_type_on_rowidentifier
    ON valuation.valuation_unit_type USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- + Version: valuation_unit_type_historic
CREATE OR REPLACE TRIGGER __track_changes
    BEFORE INSERT OR UPDATE 
    ON valuation.valuation_unit_type
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_changes();
CREATE OR REPLACE TRIGGER __track_history
    AFTER DELETE OR UPDATE 
    ON valuation.valuation_unit_type
    FOR EACH ROW
    EXECUTE FUNCTION public.f_for_trg_track_history();	
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_type_historic
(
    id bigint,
    name character varying(500),
    description character varying(1000),
    status character(1),
	vunit_category_id bigint NOT NULL,
    rowidentifier character varying(40),
    rowversion integer,
    change_action character(1),
    change_user character varying(50),
    change_time timestamp without time zone,
    change_time_valid_until timestamp without time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE valuation.valuation_unit_type_historic
    IS 'Version table for valuation_unit_type.';
    
-- Table: preparation.types_parameters_links
CREATE TABLE IF NOT EXISTS preparation.types_parameters_links
(    
    type_id bigint NOT NULL,
	parameter_id bigint NOT NULL,
	CONSTRAINT categories_parameters_links_pkey PRIMARY KEY (type_id, parameter_id),
    CONSTRAINT types_parameters_links_parameter_id_fkey FOREIGN KEY (parameter_id)
        REFERENCES preparation.tech_parameter (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT types_parameters_links_type_id_fkey FOREIGN KEY (type_id)
        REFERENCES valuation.valuation_unit_type (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.types_parameters_links
    OWNER to postgres;	
COMMENT ON TABLE preparation.types_parameters_links
    IS 'Associates a type with one or more parameters';    

-- Table: valuation.valuation_approach
CREATE TABLE IF NOT EXISTS valuation.valuation_approach
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,    
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT valuation_approach_pkey PRIMARY KEY (code),
    CONSTRAINT valuation_approach_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_approach
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_approach
    IS 'Code list that deals with three primary types of valuation methods, namely, sales comparison, income and cost methods dominant in practice.';

COMMENT ON COLUMN valuation.valuation_approach.code
    IS 'The code for the approach.';

COMMENT ON COLUMN valuation.valuation_approach.display_value
    IS 'Displayed value of the approach.';

COMMENT ON COLUMN valuation.valuation_approach.description
    IS 'Description of the approach.';
    
COMMENT ON COLUMN valuation.valuation_approach.status
    IS 'Status in active of the approach as active (a) or inactive (i).';
    
-- Table: valuation.valuation_unit_group_type
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_group_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,    
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
	description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT valuation_unit_group_type_pkey PRIMARY KEY (code),
    CONSTRAINT valuation_unit_group_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_group_type
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_group_type
    IS 'Code list that deals with three group types of valuation model as zone or locality.';

COMMENT ON COLUMN valuation.valuation_unit_group_type.code
    IS 'The code for the valuation unit group.';

COMMENT ON COLUMN valuation.valuation_unit_group_type.display_value
    IS 'Displayed value of the valuation unit group.';

COMMENT ON COLUMN valuation.valuation_unit_group_type.description
    IS 'Description of the valuation unit group.';
	
COMMENT ON COLUMN valuation.valuation_unit_group_type.status
    IS 'Status in active of the valuation unit group as active (a) or inactive (i).';	
    
-- Table: valuation.valuation_unit_group
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_group
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),        
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    vu_group_type_code character varying(20) COLLATE pg_catalog."default",
    description character varying(1000) COLLATE pg_catalog."default",
    reference_point geometry,
    geom geometry NOT NULL,
    found_in_vu_group_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),    
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT valuation_unit_group_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_unit_group_vu_group_type_code UNIQUE (vu_group_type_code),
    CONSTRAINT valuation_unit_group_found_in_vu_group_id_fkey FOREIGN KEY (found_in_vu_group_id)
        REFERENCES valuation.valuation_unit_group (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_unit_group_vu_group_type_code_fkey FOREIGN KEY (vu_group_type_code)
        REFERENCES valuation.valuation_unit_group_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_group
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_group
    IS 'For grouping or zoning valuation units, such as administrative, economic and market zones that indicate similar characteristics or functions
of valuation units (e.g., commercial, residential and agricultural).';


COMMENT ON COLUMN valuation.valuation_unit_group.name
    IS 'Display name of the valuation unit group.';
    
COMMENT ON COLUMN valuation.valuation_unit_group.vu_group_type_code
    IS 'Type of the valuation unit group as zone or locality.';      

COMMENT ON COLUMN valuation.valuation_unit_group.description
    IS 'Description of the valuation unit group.';
    
COMMENT ON COLUMN valuation.valuation_unit_group.reference_point
    IS 'Reference point at center of group geometry.';

COMMENT ON COLUMN valuation.valuation_unit_group.geom
    IS 'Multi polygon as geometry of all valuation units for spatial displaying.';
    
COMMENT ON COLUMN valuation.valuation_unit_group.found_in_vu_group_id
    IS 'Parent group where this valuation group belongs, it could be NULL as no specific parent.';  
    
COMMENT ON COLUMN valuation.valuation_unit_group.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_unit_group.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';   

COMMENT ON COLUMN valuation.valuation_unit_group.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit_group.change_user
    IS 'The user id of the last person to modify the row.'; 
    
COMMENT ON COLUMN valuation.valuation_unit_group.change_time
    IS 'The date and time the row was last modified.';
   
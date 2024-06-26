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
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_category
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	name character varying(500) COLLATE pg_catalog."default" NOT NULL,    
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,        
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT public.uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
	change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
	change_time timestamp without time zone NOT NULL DEFAULT now(),	
    CONSTRAINT valuation_unit_category_pkey PRIMARY KEY (code)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_category
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_category
    IS 'List of the valuation unit categories as parcel or improvements (building, building unit) or parcel and buildings';

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

-- Table: valuation.valuation_unit_type
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	name character varying(500) COLLATE pg_catalog."default" NOT NULL,
	description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
	vunit_category_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
	rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT public.uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT valuation_unit_type_pkey PRIMARY KEY (code),
    CONSTRAINT valuation_unit_type_vunit_category_code_fkey FOREIGN KEY (vunit_category_code)
        REFERENCES valuation.valuation_unit_category (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_type
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_type
    IS 'List of the valuation unit types as items belonged to categories.';

COMMENT ON COLUMN valuation.valuation_unit_type.name
    IS 'Display name of the type.';

COMMENT ON COLUMN valuation.valuation_unit_type.description
    IS 'Description of the type.';

COMMENT ON COLUMN valuation.valuation_unit_type.status
    IS 'Status in active of the type as active (a) or inactive (i).';

COMMENT ON COLUMN valuation.valuation_unit_type.vunit_category_code
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
/*
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
    code character varying(40),
    name character varying(500),
    description character varying(1000),
    status character(1),
	vunit_category_code character varying(40) NOT NULL,
    rowidentifier character varying(40),
    rowversion integer,
    change_action character(1),
    change_user character varying(50),
    change_time timestamp without time zone,
    change_time_valid_until timestamp without time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE valuation.valuation_unit_type_historic
    IS 'Version table for valuation_unit_type.';
*/    
-- Table: preparation.types_parameters_links
CREATE TABLE IF NOT EXISTS preparation.types_parameters_links
(    
    type_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
	parameter_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
	CONSTRAINT categories_parameters_links_pkey PRIMARY KEY (type_code, parameter_code),
    CONSTRAINT types_parameters_links_parameter_code_fkey FOREIGN KEY (parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT types_parameters_links_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES valuation.valuation_unit_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.types_parameters_links
    OWNER to postgres;	
COMMENT ON TABLE preparation.types_parameters_links
    IS 'Associates a type with one or more parameters';    

-- Table: valuation.valuation_approach_type
CREATE TABLE IF NOT EXISTS valuation.valuation_approach_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT valuation_approach_type_pkey PRIMARY KEY (code),
    CONSTRAINT valuation_approach_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_approach_type
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_approach_type
    IS 'Code list that deals with three primary types of valuation methods, namely, sales comparison, income and cost methods dominant in practice.';

COMMENT ON COLUMN valuation.valuation_approach_type.code
    IS 'The code for the approach type.';

COMMENT ON COLUMN valuation.valuation_approach_type.display_value
    IS 'Displayed value of the approach type.';

COMMENT ON COLUMN valuation.valuation_approach_type.description
    IS 'Description of the approach type.';
    
COMMENT ON COLUMN valuation.valuation_approach_type.status
    IS 'Status in active of the approach type as active (a) or inactive (i).';
    
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
    vu_group_type_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    reference_point geometry,
    geom geometry NOT NULL,
    found_in_vu_group_id character varying(40) COLLATE pg_catalog."default",    
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
    
-- Table: preparation.neighborhood_type
CREATE TABLE IF NOT EXISTS preparation.neighborhood_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT neighborhood_type_pkey PRIMARY KEY (code),
    CONSTRAINT neighborhood_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.neighborhood_type
    OWNER to postgres;

COMMENT ON TABLE preparation.neighborhood_type
    IS 'Code list of neighborhood types. E.g., urban, rural, etc';

COMMENT ON COLUMN preparation.neighborhood_type.code
    IS 'Code of the neighborhood type.';

COMMENT ON COLUMN preparation.neighborhood_type.display_value
    IS 'Displayed value of the neighborhood type.';

COMMENT ON COLUMN preparation.neighborhood_type.description
    IS 'Description of the neighborhood type.';
    
COMMENT ON COLUMN preparation.neighborhood_type.status
    IS 'Status in active of the neighborhood type as active (a) or inactive (i).';
    
-- Table: valuation.valuation_unit
CREATE TABLE IF NOT EXISTS valuation.valuation_unit
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    name character varying(500) COLLATE pg_catalog."default",
    address_id character varying(40) COLLATE pg_catalog."default",
    vu_type_code character varying(40) COLLATE pg_catalog."default",
    neighborhood_code character varying(20) COLLATE pg_catalog."default",
    creation_date timestamp without time zone,
    expiration_date timestamp without time zone,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default", 
    change_time timestamp without time zone NOT NULL DEFAULT now(),       
    CONSTRAINT valuation_unit_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_unit_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES address.address (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
   CONSTRAINT valuation_unit_neighborhood_code_fkey FOREIGN KEY (neighborhood_code)
        REFERENCES preparation.neighborhood_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,        
    CONSTRAINT valuation_unit_vu_type_code_fkey FOREIGN KEY (vu_type_code)
        REFERENCES valuation.valuation_unit_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit
    IS 'Provides information about objects of valuation unit for fundamental recording of land and improvements (buildings), which can only be land, building
or land and improvements together as land or condominium property.';

COMMENT ON COLUMN valuation.valuation_unit.name
    IS 'Display name of the valuation unit.';

COMMENT ON COLUMN valuation.valuation_unit.address_id
    IS 'Address identifier of the valuation unit.';
    
COMMENT ON COLUMN valuation.valuation_unit.vu_type_code
    IS 'Valuation type code of unit, to classify by types or categories if need.';

COMMENT ON COLUMN valuation.valuation_unit.neighborhood_code
    IS 'Neighborhood code as urban or rural, for example.';    
    
COMMENT ON COLUMN valuation.valuation_unit.creation_date
    IS 'The datetime the valuation unit is formally recognised by the land value assessment agency (i.e. registered or issued).';

COMMENT ON COLUMN valuation.valuation_unit.expiration_date
    IS 'The datetime the valuation unit was superseded and became historic.';    
    
COMMENT ON COLUMN valuation.valuation_unit.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_unit.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
    
COMMENT ON COLUMN valuation.valuation_unit.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.valuation_unit.change_time
    IS 'The date and time the row was last modified.';
            
-- Table: valuation.valuation_units_parameters_links
CREATE TABLE IF NOT EXISTS valuation.valuation_units_parameters_links
(
	unit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    parameter_code character varying(40) COLLATE pg_catalog."default" NOT NULL,    
    value character varying(500) COLLATE pg_catalog."default",
    CONSTRAINT valuation_units_parameters_links_pkey PRIMARY KEY (parameter_code, unit_id),
    CONSTRAINT valuation_units_parameters_links_parameter_code_fkey FOREIGN KEY (parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_units_parameters_links_unit_id_fkey FOREIGN KEY (unit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_units_parameters_links
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_units_parameters_links
    IS 'Value of parameters as independent variable for each unit for regression model.';

COMMENT ON COLUMN valuation.valuation_units_parameters_links.unit_id
    IS 'The id of the valuation unit.';
    
COMMENT ON COLUMN valuation.valuation_units_parameters_links.parameter_code
    IS 'The code of the technical parameter.';

COMMENT ON COLUMN valuation.valuation_units_parameters_links.value
    IS 'Value of the parameter with corresponding valuation unit.';

-- Table: valuation.valuation_unit_uses_source
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_uses_source
(
    source_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    vunit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT valuation_unit_uses_source_pkey PRIMARY KEY (source_id, vunit_id),
    CONSTRAINT valuation_unit_uses_source_source_id_fkey FOREIGN KEY (source_id)
        REFERENCES source.source (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_unit_uses_source_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_uses_source
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_uses_source
    IS 'Links the valuation unit to the sources (documents) in valuation process.';

COMMENT ON COLUMN valuation.valuation_unit_uses_source.source_id
    IS 'Identifier of the source associated to the application.';

COMMENT ON COLUMN valuation.valuation_unit_uses_source.vunit_id
    IS 'Identifier for the valuation unit the record is associated to.';

COMMENT ON COLUMN valuation.valuation_unit_uses_source.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_unit_uses_source.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
    
COMMENT ON COLUMN valuation.valuation_unit_uses_source.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit_uses_source.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.valuation_unit_uses_source.change_user
    IS 'The user id of the last person to modify the row.';
-- Index: valuation_unit_uses_source_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_unit_uses_source_on_rowidentifier
    ON valuation.valuation_unit_uses_source USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: valuation_unit_uses_source_on_source_id
CREATE INDEX IF NOT EXISTS valuation_unit_uses_source_on_source_id
    ON valuation.valuation_unit_uses_source USING btree
    (source_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: valuation_unit_uses_source_on_vunit_id
CREATE INDEX IF NOT EXISTS valuation_unit_uses_source_on_vunit_id
    ON valuation.valuation_unit_uses_source USING btree
    (vunit_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Table: preparation.parcel
CREATE TABLE IF NOT EXISTS preparation.parcel
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    area double precision,
    curent_land_use character varying(255) COLLATE pg_catalog."default",    
    planed_land_use character varying(255) COLLATE pg_catalog."default",
    geom geometry NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,    
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT parcel_pkey PRIMARY KEY (id),
    CONSTRAINT parcel_id_fkey FOREIGN KEY (id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parcel
    OWNER to postgres;

COMMENT ON TABLE preparation.parcel
    IS 'Provides detailed information about valuation unit as parcel.';

COMMENT ON COLUMN preparation.parcel.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN preparation.parcel.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN preparation.parcel.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN preparation.parcel.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN preparation.parcel.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN preparation.parcel.area
    IS 'Legal area value that recorded in cadastre.';

COMMENT ON COLUMN preparation.parcel.curent_land_use
    IS 'Code of land use.';

COMMENT ON COLUMN preparation.parcel.geom
    IS 'Geometry of parcel for spatial displaying.';

COMMENT ON COLUMN preparation.parcel.planed_land_use
    IS 'Code of planed land use.';
    
-- Table: preparation.building_use_type
CREATE TABLE IF NOT EXISTS preparation.building_use_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,    
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT building_use_type_pkey PRIMARY KEY (code),
    CONSTRAINT building_use_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_use_type
    OWNER to postgres;

COMMENT ON TABLE preparation.building_use_type
    IS 'Code list of types of building use, i.e., residential, office and industrial';

COMMENT ON COLUMN preparation.building_use_type.code
    IS 'Code of the building use type.';

COMMENT ON COLUMN preparation.building_use_type.display_value
    IS 'Displayed value of the building use type.';

COMMENT ON COLUMN preparation.building_use_type.description
    IS 'Description of the building use type.';
    
COMMENT ON COLUMN preparation.building_use_type.status
    IS 'Status in active of the building use as active (a) or inactive (i).';
    
-- Table: preparation.building
CREATE TABLE IF NOT EXISTS preparation.building
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    area double precision,
    volume double precision,
    type_use_code character varying(20) COLLATE pg_catalog."default",
    building_type character varying(255) COLLATE pg_catalog."default",
    construct_material character varying(255) COLLATE pg_catalog."default",
    date_construction timestamp(6) without time zone,
    quality character varying(255) COLLATE pg_catalog."default",
    status character varying(255) COLLATE pg_catalog."default",    
    energy_performance character varying(255) COLLATE pg_catalog."default",
    facade_material character varying(255) COLLATE pg_catalog."default",    
    heating_source character varying(255) COLLATE pg_catalog."default",
    heating_system character varying(255) COLLATE pg_catalog."default",
    number_dwellings integer,
    number_floors integer,
    elevator integer,
    airconditioning integer,
    geom geometry NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,    
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT building_pkey PRIMARY KEY (id),
    CONSTRAINT building_id_fkey FOREIGN KEY (id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_type_use_code_fkey FOREIGN KEY (type_use_code)
        REFERENCES preparation.building_use_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building
    OWNER to postgres;

COMMENT ON TABLE preparation.building
    IS 'Provides detailed information about valuation unit as building.';

COMMENT ON COLUMN preparation.building.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN preparation.building.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN preparation.building.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN preparation.building.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN preparation.building.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN preparation.building.airconditioning
    IS 'Number of air condition in the building.';

COMMENT ON COLUMN preparation.building.area
    IS 'Total area value that recorded in legality.';

COMMENT ON COLUMN preparation.building.building_type
    IS 'Type of the building if have a classification.';

COMMENT ON COLUMN preparation.building.construct_material
    IS 'Material type used for constructing of building.';

COMMENT ON COLUMN preparation.building.date_construction
    IS 'The date of construction.';

COMMENT ON COLUMN preparation.building.elevator
    IS 'Number of elevators of the building.';

COMMENT ON COLUMN preparation.building.energy_performance
    IS 'Energy performance value of the bulding.';

COMMENT ON COLUMN preparation.building.facade_material
    IS 'Material type of the building facade.';

COMMENT ON COLUMN preparation.building.geom
    IS 'Geometry of building for spatial displaying.';

COMMENT ON COLUMN preparation.building.heating_source
    IS 'Heating source type of the bulding.';

COMMENT ON COLUMN preparation.building.heating_system
    IS 'Heating system type of the bulding.';

COMMENT ON COLUMN preparation.building.number_dwellings
    IS 'Number of dwellings of the building.';

COMMENT ON COLUMN preparation.building.number_floors
    IS 'Number of floors of the building.';

COMMENT ON COLUMN preparation.building.quality
    IS 'Quality of the building if have a quality manegement.';

COMMENT ON COLUMN preparation.building.status
    IS 'Status of the building if have a status manegement.';

COMMENT ON COLUMN preparation.building.type_use_code
    IS 'Use type of the building.';

COMMENT ON COLUMN preparation.building.volume
    IS 'Total volume value of the building.';    

-- Table: preparation.parcels_buildings_links
CREATE TABLE IF NOT EXISTS preparation.parcels_buildings_links
(
    parcel_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    building_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT parcels_buildings_links_pkey PRIMARY KEY (parcel_id, building_id),
    CONSTRAINT parcels_buildings_links_building_id_fkey FOREIGN KEY (building_id)
        REFERENCES preparation.building (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT parcels_buildings_links_parcel_id_fkey FOREIGN KEY (parcel_id)
        REFERENCES preparation.parcel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parcels_buildings_links
    OWNER to postgres;    
COMMENT ON TABLE preparation.parcels_buildings_links
    IS 'Provides relationship of parcels and buildings.';
    
-- Table: preparation.building_unit
CREATE TABLE IF NOT EXISTS preparation.building_unit
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	located_number character varying(255) COLLATE pg_catalog."default",
    use_type character varying(255) COLLATE pg_catalog."default",    
    area double precision,
    volume double precision,            
    number_bathrooms integer,
    number_bedrooms integer,
    number_rooms integer,
    share_in_joint_facilities double precision,
    accessory_part boolean,
    accessory_part_type character varying(255) COLLATE pg_catalog."default",
    belongto_building_id character varying(255) COLLATE pg_catalog."default",
    geom geometry NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,    
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    change_user character varying(50) COLLATE pg_catalog."default", 
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    CONSTRAINT building_unit_pkey PRIMARY KEY (id),
    CONSTRAINT building_unit_belongto_building_id_fkey FOREIGN KEY (belongto_building_id)
        REFERENCES preparation.building (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_unit_id_fkey FOREIGN KEY (id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_unit
    OWNER to postgres;

COMMENT ON TABLE preparation.building_unit
    IS 'Provides detailed information about valuation unit as building unit.';

COMMENT ON COLUMN preparation.building_unit.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN preparation.building_unit.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN preparation.building_unit.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN preparation.building_unit.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN preparation.building_unit.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN preparation.building_unit.accessory_part
    IS 'Whether space use as accessory or not.';

COMMENT ON COLUMN preparation.building_unit.accessory_part_type
    IS 'Accessory part type of the building unit.';

COMMENT ON COLUMN preparation.building_unit.area
    IS 'Legal area value of the building unit.';

COMMENT ON COLUMN preparation.building_unit.geom
    IS 'Geometry of building for spatial displaying.';

COMMENT ON COLUMN preparation.building_unit.located_number
    IS 'Floor number or locate identifier of the bulding unit.';

COMMENT ON COLUMN preparation.building_unit.number_bathrooms
    IS 'Number of bath rooms in the bulding unit.';

COMMENT ON COLUMN preparation.building_unit.number_bedrooms
    IS 'Number of bed rooms in the bulding unit.';

COMMENT ON COLUMN preparation.building_unit.number_rooms
    IS 'Number of rooms in the bulding unit.';


COMMENT ON COLUMN preparation.building_unit.share_in_joint_facilities
    IS 'Ratio of share of using facilities.';

COMMENT ON COLUMN preparation.building_unit.use_type
    IS 'Use type of the building unit.';

COMMENT ON COLUMN preparation.building_unit.volume
    IS 'Total volume value of the building unit.';

COMMENT ON COLUMN preparation.building_unit.belongto_building_id
    IS 'Refer to identifying of a building.';        

-- Table: preparation.utility_network_status_type
CREATE TABLE IF NOT EXISTS preparation.utility_network_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT utility_network_status_type_pkey PRIMARY KEY (code),
    CONSTRAINT utility_network_status_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.utility_network_status_type
    OWNER to postgres;

COMMENT ON TABLE preparation.utility_network_status_type
    IS 'Code list of utility network status types. E.g. inUse, outOfUse, planned, etc.';

COMMENT ON COLUMN preparation.utility_network_status_type.code
    IS 'Code of the utility network status type.';

COMMENT ON COLUMN preparation.utility_network_status_type.display_value
    IS 'Displayed value of the utility network status type.';

COMMENT ON COLUMN preparation.utility_network_status_type.description
    IS 'Description of the utility network status type.';
    
COMMENT ON COLUMN preparation.utility_network_status_type.status
    IS 'Status in active of the utility network status type as active (a) or inactive (i).';

    -- Table: preparation.utility_network_type
CREATE TABLE IF NOT EXISTS preparation.utility_network_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT utility_network_type_pkey PRIMARY KEY (code),
    CONSTRAINT utility_network_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.utility_network_type
    OWNER to postgres;

COMMENT ON TABLE preparation.utility_network_type
    IS 'Code list of utility network types. E.g. gas, oil, water, etc';

COMMENT ON COLUMN preparation.utility_network_type.code
    IS 'Code of the utility network type.';

COMMENT ON COLUMN preparation.utility_network_type.display_value
    IS 'Displayed value of the utility network type.';

COMMENT ON COLUMN preparation.utility_network_type.description
    IS 'Description of the utility network type.';
    
COMMENT ON COLUMN preparation.utility_network_type.status
    IS 'Status in active of the utility network type as active (a) or inactive (i).';    

-- Table: preparation.utility_network
CREATE TABLE IF NOT EXISTS preparation.utility_network
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    ext_physical_network_id character varying(40) COLLATE pg_catalog."default",
    status_code character varying(20) COLLATE pg_catalog."default",
    type_code character varying(20) COLLATE pg_catalog."default",
    geom geometry,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,      
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),  
    CONSTRAINT utility_network_pkey PRIMARY KEY (id),
    CONSTRAINT utility_network_status_code_fkey FOREIGN KEY (status_code)
        REFERENCES preparation.utility_network_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT utility_network_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES preparation.utility_network_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.utility_network
    OWNER to postgres;

COMMENT ON TABLE preparation.utility_network
    IS 'A utility network concerns to implementation of the LADM LA_LegalSpaceUtilityNetwork class. Not used by Lao Land Valuation System.';

COMMENT ON COLUMN preparation.utility_network.ext_physical_network_id
    IS 'External identifier for a physical utility network.';

COMMENT ON COLUMN preparation.utility_network.status_code
    IS 'Status code for the utility network.';

COMMENT ON COLUMN preparation.utility_network.type_code
    IS 'Type code for the utility network.';
    
COMMENT ON COLUMN preparation.utility_network.geom
    IS 'Geometry of the utility network.';

COMMENT ON COLUMN preparation.utility_network.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN preparation.utility_network.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';  
    
COMMENT ON COLUMN preparation.utility_network.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN preparation.utility_network.change_user
    IS 'The user id of the last person to modify the row.';    

COMMENT ON COLUMN preparation.utility_network.change_time
    IS 'The date and time the row was last modified.';

-- Table: preparation.parcels_utility_networks_links
CREATE TABLE IF NOT EXISTS preparation.parcels_utility_networks_links
(
    parcel_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    utility_network_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT parcels_utility_networks_links_pkey PRIMARY KEY (parcel_id, utility_network_id),
    CONSTRAINT parcels_utility_networks_links_parcel_id_fkey FOREIGN KEY (parcel_id)
        REFERENCES preparation.parcel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT parcels_utility_networks_links_utility_network_id_fkey FOREIGN KEY (utility_network_id)
        REFERENCES preparation.utility_network (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parcels_utility_networks_links
    OWNER to postgres;    
COMMENT ON TABLE preparation.parcels_utility_networks_links
    IS 'Provides relationship of parcels and utility networks.'; 
        
-- Table: valuation.appeal_status_type
CREATE TABLE IF NOT EXISTS valuation.appeal_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT appeal_status_type_pkey PRIMARY KEY (code),
    CONSTRAINT appeal_status_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.appeal_status_type
    OWNER to postgres;

COMMENT ON TABLE valuation.appeal_status_type
    IS 'List of the appeal status types in a valuaton process';

COMMENT ON COLUMN valuation.appeal_status_type.code
    IS 'Code of the appeal status type.';

COMMENT ON COLUMN valuation.appeal_status_type.display_value
    IS 'Displayed value of the appeal status type.';
    
COMMENT ON COLUMN valuation.appeal_status_type.description
    IS 'Description of the appeal status type.';    

COMMENT ON COLUMN valuation.appeal_status_type.status
    IS 'Status in active of the appeal status type as active (a) or inactive (i).';
    
-- Table: valuation.mass_appraisal_analysis_type
CREATE TABLE IF NOT EXISTS valuation.mass_appraisal_analysis_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,    
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT mass_appraisal_analysis_type_pkey PRIMARY KEY (code),
    CONSTRAINT mass_appraisal_analysis_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.mass_appraisal_analysis_type
    OWNER to postgres;

COMMENT ON TABLE valuation.mass_appraisal_analysis_type
    IS 'List of the mass appraisal analysis types used for valuaton process, such as multiple regreesion, time serial analysis.';

COMMENT ON COLUMN valuation.mass_appraisal_analysis_type.code
    IS 'Code of the mass appraisal analysis type.';

COMMENT ON COLUMN valuation.mass_appraisal_analysis_type.display_value
    IS 'Displayed value of the mass appraisal analysis type.';

COMMENT ON COLUMN valuation.mass_appraisal_analysis_type.description
    IS 'Description of the mass appraisal analysis type.';
    
COMMENT ON COLUMN valuation.mass_appraisal_analysis_type.status
    IS 'Status in active of the mass appraisal analysis type as active (a) or inactive (i).';   
    
-- Table: valuation.appraisal_level_type
CREATE TABLE IF NOT EXISTS valuation.appraisal_level_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT appraisal_level_type_pkey PRIMARY KEY (code),
    CONSTRAINT appraisal_level_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.appraisal_level_type
    OWNER to postgres;

COMMENT ON TABLE valuation.appraisal_level_type
    IS 'List of the appraisal level types used for valuaton process, such as mean, median, weighted mean.';

COMMENT ON COLUMN valuation.appraisal_level_type.code
    IS 'Code of the appraisal level type.';

COMMENT ON COLUMN valuation.appraisal_level_type.display_value
    IS 'Displayed value of the appraisal level type.';

COMMENT ON COLUMN valuation.appraisal_level_type.description
    IS 'Description of the appraisal level type.';
    
COMMENT ON COLUMN valuation.appraisal_level_type.status
    IS 'Status in active of the appraisal level type as active (a) or inactive (i).';  
    
-- Table: valuation.appraisal_uniformity_type
CREATE TABLE IF NOT EXISTS valuation.appraisal_uniformity_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT appraisal_uniformity_type_pkey PRIMARY KEY (code),
    CONSTRAINT appraisal_uniformity_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.appraisal_uniformity_type
    OWNER to postgres;

COMMENT ON TABLE valuation.appraisal_uniformity_type
    IS 'List of the appraisal uniformity types used for valuaton process, such as standard deviation, coefficient of variation.';

COMMENT ON COLUMN valuation.appraisal_uniformity_type.code
    IS 'Code of the appraisal uniformity type.';

COMMENT ON COLUMN valuation.appraisal_uniformity_type.display_value
    IS 'Displayed value of the appraisal uniformity type.';
    
COMMENT ON COLUMN valuation.appraisal_uniformity_type.description
    IS 'Description of the appraisal uniformity type.';
    
-- Table: valuation.mass_appraisal_performance
CREATE TABLE IF NOT EXISTS valuation.mass_appraisal_performance
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    analysis_date timestamp(6) without time zone,
    appraisal_level numeric(20,2),
    appraisal_uniformity numeric(20,2),
    simple_size integer NOT NULL,
    analysis_type_code character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT mass_appraisal_performance_pkey PRIMARY KEY (id),
    CONSTRAINT mass_appraisal_performance_analysis_type_code_fkey FOREIGN KEY (analysis_type_code)
        REFERENCES valuation.mass_appraisal_analysis_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.mass_appraisal_performance
    OWNER to postgres;

COMMENT ON TABLE valuation.mass_appraisal_performance
    IS 'Presents performance indicator characteristics of mass appraisal implementation';

COMMENT ON COLUMN valuation.mass_appraisal_performance.id
    IS 'Mass appraisal identifier.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.analysis_date
    IS 'The analysis date of mass appraisal implementation.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.appraisal_level
    IS 'The appraisal level for mass appraisal process implementation.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.appraisal_uniformity
    IS 'The appraisal_uniformity for mass appraisal process implementation.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.simple_size
    IS 'Size of mass appraisal model sample.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.analysis_type_code
    IS 'Type of the mass appraisal analysis.';    
COMMENT ON COLUMN valuation.appraisal_uniformity_type.status
    IS 'Status in active of the appraisal uniformity type as active (a) or inactive (i).';   
    
-- Table: valuation.measure_performances_levels_links
CREATE TABLE IF NOT EXISTS valuation.measure_performances_levels_links
(
    performance_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    level_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    measured_value numeric(20,2),
    CONSTRAINT measure_performances_levels_links_pkey PRIMARY KEY (level_code, performance_id),
    CONSTRAINT measure_performances_levels_links_level_code_fkey FOREIGN KEY (level_code)
        REFERENCES valuation.appraisal_level_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT measure_performances_levels_links_performance_id_fkey FOREIGN KEY (performance_id)
        REFERENCES valuation.mass_appraisal_performance (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.measure_performances_levels_links
    OWNER to postgres;

COMMENT ON TABLE valuation.measure_performances_levels_links
    IS 'Value of measurement of appraisal levels.';

COMMENT ON COLUMN valuation.measure_performances_levels_links.level_code
    IS 'The code of mass appraisal level.';

COMMENT ON COLUMN valuation.measure_performances_levels_links.performance_id
    IS 'The id of the mass appraisal performance.';

COMMENT ON COLUMN valuation.measure_performances_levels_links.measured_value
    IS 'Value of the measurement.';    

-- Table: valuation.measure_performances_uniformities_links
CREATE TABLE IF NOT EXISTS valuation.measure_performances_uniformities_links
(
    performance_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    uniformity_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    measured_value numeric(20,2),
    CONSTRAINT measure_performances_uniformities_links_pkey PRIMARY KEY (performance_id, uniformity_code),
    CONSTRAINT measure_performances_levels_links_performance_id_fkey FOREIGN KEY (performance_id)
        REFERENCES valuation.mass_appraisal_performance (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT measure_performances_uniformities_links_uniformity_code_fkey FOREIGN KEY (uniformity_code)
        REFERENCES valuation.appraisal_uniformity_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.measure_performances_uniformities_links
    OWNER to postgres;

COMMENT ON TABLE valuation.measure_performances_uniformities_links
    IS 'Value of measurement of appraisal uniformities.';

COMMENT ON COLUMN valuation.measure_performances_uniformities_links.performance_id
    IS 'The id of the mass appraisal performance.';

COMMENT ON COLUMN valuation.measure_performances_uniformities_links.uniformity_code
    IS 'The code of mass appraisal uniformities.';

COMMENT ON COLUMN valuation.measure_performances_uniformities_links.measured_value
    IS 'Value of the uniformity measurement.';    
    
-- Table: valuation.cost_approach_type
CREATE TABLE IF NOT EXISTS valuation.cost_approach_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT cost_approach_type_pkey PRIMARY KEY (code),
    CONSTRAINT cost_approach_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.cost_approach_type
    OWNER to postgres;

COMMENT ON TABLE valuation.cost_approach_type
    IS 'List of the code types for cost approach of valuation, such as replacement or reproduction';

COMMENT ON COLUMN valuation.cost_approach_type.code
    IS 'Code of the cost approach type.';

COMMENT ON COLUMN valuation.cost_approach_type.display_value
    IS 'Displayed value of the cost approach type.';

COMMENT ON COLUMN valuation.cost_approach_type.description
    IS 'Description of the cost approach type.';
    
COMMENT ON COLUMN valuation.cost_approach_type.status
    IS 'Status in active of the cost approach type as active (a) or inactive (i).';
    
-- Table: valuation.taxation_type
CREATE TABLE IF NOT EXISTS valuation.taxation_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT taxation_type_pkey PRIMARY KEY (code),
    CONSTRAINT taxation_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.taxation_type
    OWNER to postgres;

COMMENT ON TABLE valuation.taxation_type
    IS 'List of the tax types.';

COMMENT ON COLUMN valuation.taxation_type.code
    IS 'Code of the tax type.';

COMMENT ON COLUMN valuation.taxation_type.display_value
    IS 'Displayed value of the tax type.';

COMMENT ON COLUMN valuation.taxation_type.description
    IS 'Description of the tax type.';
    
COMMENT ON COLUMN valuation.taxation_type.status
    IS 'Status in active of the tax type as active (a) or inactive (i).'; 
    
-- Table: valuation.taxation
CREATE TABLE IF NOT EXISTS valuation.taxation
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    assessment_tax numeric(20,2) NOT NULL DEFAULT 0,
    tax_type_code character varying(40) COLLATE pg_catalog."default",
    payment_date timestamp(6) without time zone,    
    due_date timestamp(6) without time zone,
    fiscal_year timestamp(6) without time zone,
    assement_ratio numeric(20,2) NOT NULL DEFAULT 1,
    tax_rate character varying(500) COLLATE pg_catalog."default",    
    rate_type character varying(500) COLLATE pg_catalog."default",
    tax_arrear_amount numeric(20,2) NOT NULL DEFAULT 0,
    exemption_amount numeric(20,2) NOT NULL DEFAULT 0,
    exemption_type character varying(500) COLLATE pg_catalog."default",    
    valuation_unit_id character varying(40) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,        
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT taxation_pkey PRIMARY KEY (id),
    CONSTRAINT taxation_tax_type_code_fkey FOREIGN KEY (tax_type_code)
        REFERENCES valuation.taxation_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT taxation_valuation_unit_id_fkey FOREIGN KEY (valuation_unit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.taxation
    OWNER to postgres;

COMMENT ON TABLE valuation.taxation
    IS 'An improved form of the ExtTaxation external class of LADM to support links to taxation system.';

COMMENT ON COLUMN valuation.taxation.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.taxation.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.taxation.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.taxation.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.taxation.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN valuation.taxation.assement_ratio
    IS 'The ratio of assessment to property as 1 for whole property';

COMMENT ON COLUMN valuation.taxation.assessment_tax
    IS 'Money amount on tax calculated.';

COMMENT ON COLUMN valuation.taxation.due_date
    IS 'The due date that tax has payment.';

COMMENT ON COLUMN valuation.taxation.exemption_amount
    IS 'Amount is exempted from tax calculation.';

COMMENT ON COLUMN valuation.taxation.exemption_type
    IS 'Type of tax exemption.';

COMMENT ON COLUMN valuation.taxation.fiscal_year
    IS 'The fiscal year the tax is effective.';

COMMENT ON COLUMN valuation.taxation.payment_date
    IS 'The date that tax is calculated and effective.';

COMMENT ON COLUMN valuation.taxation.rate_type
    IS 'Type of rate of taxation.';

COMMENT ON COLUMN valuation.taxation.tax_arrear_amount
    IS 'Any portion of property taxes that remain unpaid after the date on which they are due and includes late payment charges or other charges.';

COMMENT ON COLUMN valuation.taxation.tax_rate
    IS 'The tax rate calculated at the date.';
-- Index: taxation_on_rowidentifier
CREATE INDEX IF NOT EXISTS taxation_on_rowidentifier
    ON valuation.taxation USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Table: valuation.property_transaction_type
CREATE TABLE IF NOT EXISTS valuation.property_transaction_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT property_transaction_type_pkey PRIMARY KEY (code),
    CONSTRAINT property_transaction_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.property_transaction_type
    OWNER to postgres;

COMMENT ON TABLE valuation.property_transaction_type
    IS 'List of the property transaction types in a collection';

COMMENT ON COLUMN valuation.property_transaction_type.code
    IS 'Code of the property transaction type.';

COMMENT ON COLUMN valuation.property_transaction_type.display_value
    IS 'Displayed value of the property transaction type.';
    
COMMENT ON COLUMN valuation.property_transaction_type.description
    IS 'Description of the property transaction type.';

COMMENT ON COLUMN valuation.property_transaction_type.status
    IS 'Status in active of the property transaction type as active (a) or inactive (i).';
    
-- Table: valuation.transaction_price
CREATE TABLE IF NOT EXISTS valuation.transaction_price
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    contract_date timestamp(6) without time zone,
    transaction_price numeric(20,2) NOT NULL DEFAULT 0,
    transaction_type_code character varying(20) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,  
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),  
    CONSTRAINT transaction_price_pkey PRIMARY KEY (id),
    CONSTRAINT transaction_price_transaction_type_code_fkey FOREIGN KEY (transaction_type_code)
        REFERENCES valuation.property_transaction_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.transaction_price
    OWNER to postgres;

COMMENT ON TABLE valuation.transaction_price
    IS 'Represents the information related to property transactions.';

COMMENT ON COLUMN valuation.transaction_price.id
    IS 'The contract or declaration identifier.';

COMMENT ON COLUMN valuation.transaction_price.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.transaction_price.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.transaction_price.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.transaction_price.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.transaction_price.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN valuation.transaction_price.contract_date
    IS 'The date that contract or declaration implement.';

COMMENT ON COLUMN valuation.transaction_price.transaction_price
    IS 'Price of property in transaction implementation.';
-- Index: transaction_price_on_rowidentifier
CREATE INDEX IF NOT EXISTS transaction_price_on_rowidentifier
    ON valuation.transaction_price USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;    

-- Table: valuation.valuation_unit_has_transaction_price
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_has_transaction_price
(
    vunit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    transaction_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default", 
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT valuation_unit_has_transaction_price_pkey PRIMARY KEY (transaction_id, vunit_id),
    CONSTRAINT valuation_unit_has_transaction_price_transaction_id_fkey FOREIGN KEY (transaction_id)
        REFERENCES valuation.transaction_price (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_unit_has_transaction_price_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_has_transaction_price
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_has_transaction_price
    IS 'Links the valuation unit to the its recorded transaction price.';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.transaction_id
    IS 'Identifier of the contract or declaration of property transaction price.';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.vunit_id
    IS 'Identifier for the valuation unit the record is associated to.';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
-- Index: valuation_unit_has_transaction_price_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_unit_has_transaction_price_on_rowidentifier
    ON valuation.valuation_unit_has_transaction_price USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: valuation_unit_has_transaction_price_on_transaction_id
CREATE INDEX IF NOT EXISTS valuation_unit_has_transaction_price_on_transaction_id
    ON valuation.valuation_unit_has_transaction_price USING btree
    (transaction_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: valuation_unit_has_transaction_price_on_vunit_id
CREATE INDEX IF NOT EXISTS valuation_unit_has_transaction_price_on_vunit_id
    ON valuation.valuation_unit_has_transaction_price USING btree
    (vunit_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Table: valuation.sales_statistic
CREATE TABLE IF NOT EXISTS valuation.sales_statistic
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    analysis_date timestamp(6) without time zone,
    average_price_per_square_meter numeric(20,2) NOT NULL DEFAULT 0,
    base_price_index numeric(20,2) NOT NULL DEFAULT 0,
    base_price_date timestamp(6) without time zone,    
    price_index numeric(20,2) NOT NULL DEFAULT 0,
    price_date timestamp(6) without time zone,
    group_id character varying(40) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT sales_statistic_pkey PRIMARY KEY (id),
    CONSTRAINT sales_statistic_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES valuation.valuation_unit_group (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.sales_statistic
    OWNER to postgres;

COMMENT ON TABLE valuation.sales_statistic
    IS 'Represents sales statistics produced through the analysis of transaction prices for monitoring price trends.';

COMMENT ON COLUMN valuation.sales_statistic.id
    IS 'The analysis identifier.';

COMMENT ON COLUMN valuation.sales_statistic.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.sales_statistic.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.sales_statistic.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.sales_statistic.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.sales_statistic.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN valuation.sales_statistic.analysis_date
    IS 'The date that contract or declaration implement.';

COMMENT ON COLUMN valuation.sales_statistic.average_price_per_square_meter
    IS 'Price calculated average per square meter.';

COMMENT ON COLUMN valuation.sales_statistic.base_price_date
    IS 'The date to implement analysis of base price index.';

COMMENT ON COLUMN valuation.sales_statistic.base_price_index
    IS 'Base price index calculated from transaction prices.';

COMMENT ON COLUMN valuation.sales_statistic.price_date
    IS 'The date to implement analysis of price index.';

COMMENT ON COLUMN valuation.sales_statistic.price_index
    IS 'Price index calculated from transaction prices.';

COMMENT ON COLUMN valuation.sales_statistic.group_id
    IS 'Reference to valuation unit group for statistic.';    
-- Index: sales_statistic_on_rowidentifier
CREATE INDEX IF NOT EXISTS sales_statistic_on_rowidentifier
    ON valuation.sales_statistic USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;    
    
-- Table: valuation.sales_compare_calibration
CREATE TABLE IF NOT EXISTS valuation.sales_compare_calibration
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    compared_vunit_id character varying(40),
    calibrated_date timestamp(6) without time zone,
    time_adjustment numeric(20,2) NOT NULL DEFAULT 0,
    location_adjustment numeric(20,2) NOT NULL DEFAULT 0,
    physical_adjustment numeric(20,2) NOT NULL DEFAULT 0,
    estimate_value numeric(20,2) NOT NULL DEFAULT 0,
    CONSTRAINT sales_compare_calibration_pkey PRIMARY KEY (id),
    CONSTRAINT sales_compare_calibration_compared_vunit_id_fkey FOREIGN KEY (compared_vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.sales_compare_calibration
    OWNER to postgres;

COMMENT ON TABLE valuation.sales_compare_calibration
    IS 'Represents contents of adjustments of time, location and physical ones with estimated value for sales comparision between valuation units.';

COMMENT ON COLUMN valuation.sales_compare_calibration.id
    IS 'The sales comparision approach identifier.';

COMMENT ON COLUMN valuation.sales_compare_calibration.calibrated_date
    IS 'The date that sales comparision approach implemented.';

COMMENT ON COLUMN valuation.sales_compare_calibration.estimate_value
    IS 'Base price index calculated from transaction prices.';

COMMENT ON COLUMN valuation.sales_compare_calibration.location_adjustment
    IS 'Adjustments of location in value to compared valuation unit.';

COMMENT ON COLUMN valuation.sales_compare_calibration.physical_adjustment
    IS 'Adjustments of physical ones in value to compared valuation unit.';

COMMENT ON COLUMN valuation.sales_compare_calibration.time_adjustment
    IS 'Adjustments of time in value to compared valuation unit.';    
    
-- Table: valuation.cost_calibration
CREATE TABLE IF NOT EXISTS valuation.cost_calibration
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    calibrated_date timestamp(6) without time zone,
    cost_approach_type_code character varying(40) COLLATE pg_catalog."default",
    cost_price_per_square_meter numeric(20,2) NOT NULL DEFAULT 0,
    source_of_cost_price character varying(255) COLLATE pg_catalog."default",
    total_cost numeric(20,2) NOT NULL DEFAULT 0,
    chronological_age integer NOT NULL,
    effective_age integer NOT NULL,
    functional_obsolescence double precision,
    physical_obsolescence double precision,
    external_obsolescence double precision,
    total_obsolescence double precision,
    estimate_value numeric(20,2) NOT NULL DEFAULT 0,
    CONSTRAINT cost_calibration_pkey PRIMARY KEY (id),
    CONSTRAINT cost_calibration_cost_approach_type_code_fkey FOREIGN KEY (cost_approach_type_code)
        REFERENCES valuation.cost_approach_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.cost_calibration
    OWNER to postgres;

COMMENT ON TABLE valuation.cost_calibration
    IS 'Represents cost-related characteristics, such as cost type (e.g., replacement or reproduction cost), cost-related attributes, chronological and effective age of building and obsolescence for valuation approach of cost.';

COMMENT ON COLUMN valuation.cost_calibration.id
    IS 'The cost approach identifier.';

COMMENT ON COLUMN valuation.cost_calibration.calibrated_date
    IS 'The date that cost approach calibration implemented.';

COMMENT ON COLUMN valuation.cost_calibration.chronological_age
    IS 'The chronological age of property.';

COMMENT ON COLUMN valuation.cost_calibration.cost_price_per_square_meter
    IS 'The value (in currency) calculated per each square meter.';

COMMENT ON COLUMN valuation.cost_calibration.effective_age
    IS 'The effective age of property.';

COMMENT ON COLUMN valuation.cost_calibration.estimate_value
    IS 'The value (in currency) estimated from cost calibration.';

COMMENT ON COLUMN valuation.cost_calibration.external_obsolescence
    IS 'The value (in currency) calculated for external obsolescence.';

COMMENT ON COLUMN valuation.cost_calibration.functional_obsolescence
    IS 'The value (in currency) calculated for functional obsolescence.';

COMMENT ON COLUMN valuation.cost_calibration.physical_obsolescence
    IS 'The value (in currency) calculated for physical obsolescence.';

COMMENT ON COLUMN valuation.cost_calibration.source_of_cost_price
    IS 'The source of cost price the calibration refered to.';

COMMENT ON COLUMN valuation.cost_calibration.total_cost
    IS 'The value (in currency) in total cost calculated.';

COMMENT ON COLUMN valuation.cost_calibration.total_obsolescence
    IS 'The value (in currency) calculated for total obsolescence.';    
    
-- Table: valuation.income_calibration
CREATE TABLE IF NOT EXISTS valuation.income_calibration
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    calibrated_date timestamp(6) without time zone,
    net_income double precision,
    potential_gross_income double precision,
    effective_gross_income double precision,
    gross_income_multiplier double precision,
    operating_expenses double precision,    
    capitalization_rate double precision,
    discount_rate double precision,
    estimate_value numeric(20,2) NOT NULL DEFAULT 0,    
    CONSTRAINT income_calibration_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.income_calibration
    OWNER to postgres;

COMMENT ON TABLE valuation.income_calibration
    IS 'Represents income information, such as gross, effective and net income and operating expenses and capitalization rates characteristics for valuation approach of income.';

COMMENT ON COLUMN valuation.income_calibration.id
    IS 'The income approach identifier.';

COMMENT ON COLUMN valuation.income_calibration.calibrated_date
    IS 'The date that income approach calibration implemented.';

COMMENT ON COLUMN valuation.income_calibration.capitalization_rate
    IS 'The capitalization rate in calibration.';

COMMENT ON COLUMN valuation.income_calibration.discount_rate
    IS 'The discount rate in calibration.';

COMMENT ON COLUMN valuation.income_calibration.effective_gross_income
    IS 'The effective gross income value(in currency) in calibration.';

COMMENT ON COLUMN valuation.income_calibration.estimate_value
    IS 'The value estimated from income calibration.';

COMMENT ON COLUMN valuation.income_calibration.gross_income_multiplier
    IS 'The gross income multiplier used in calculated.';

COMMENT ON COLUMN valuation.income_calibration.net_income
    IS 'The net income value(in currency) in calibration.';

COMMENT ON COLUMN valuation.income_calibration.operating_expenses
    IS 'The operating_expenses (in currency) in calibration.';

COMMENT ON COLUMN valuation.income_calibration.potential_gross_income
    IS 'The potential gross income value(in currency) in calibration.';   
    
-- Table: valuation.valuation
CREATE TABLE IF NOT EXISTS valuation.valuation
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    assessed_value numeric(20,2) NOT NULL DEFAULT 0,
    purpose_valuation character varying(500) COLLATE pg_catalog."default",
    valuation_date timestamp(6) without time zone,
    appeal_status_code character varying(20) COLLATE pg_catalog."default",
    approach_type_code character varying(20) COLLATE pg_catalog."default",
    value_type_code character varying(20) COLLATE pg_catalog."default",
    valuation_unit_id character varying(40) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,    
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT valuation_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_appeal_status_code_fkey FOREIGN KEY (appeal_status_code)
        REFERENCES valuation.appeal_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_approach_type_code_fkey FOREIGN KEY (approach_type_code)
        REFERENCES valuation.valuation_approach_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_valuation_unit_id_fkey FOREIGN KEY (valuation_unit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_value_type_code_fkey FOREIGN KEY (value_type_code)
        REFERENCES valuation.value_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation
    IS 'An improved form of the ExtValuation external class of LADM and specifies output data yielded during a valuation process.';

COMMENT ON COLUMN valuation.valuation.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.valuation.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.valuation.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN valuation.valuation.assessed_value
    IS 'Value of object valuation in numeric.';

COMMENT ON COLUMN valuation.valuation.purpose_valuation
    IS 'Display purpose of the valuation.';

COMMENT ON COLUMN valuation.valuation.valuation_date
    IS 'The date that value is made for valuation.';
    
-- Index: valuation_on_rowidentifier
CREATE INDEX IF NOT EXISTS valuation_on_rowidentifier
    ON valuation.valuation USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;    
    
-- Table: valuation.mass_appraisal
CREATE TABLE IF NOT EXISTS valuation.mass_appraisal
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    mathematical_model character varying(255) COLLATE pg_catalog."default",
    estimated_value numeric(20,2) NOT NULL DEFAULT 0,    
    performance_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    CONSTRAINT mass_appraisal_pkey PRIMARY KEY (id),
    CONSTRAINT mass_appraisal_id_fkey FOREIGN KEY (id)
        REFERENCES valuation.valuation (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT mass_appraisal_performance_id_fkey FOREIGN KEY (performance_id)
        REFERENCES valuation.mass_appraisal_performance (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.mass_appraisal
    OWNER to postgres;

COMMENT ON TABLE valuation.mass_appraisal
    IS 'Provides information represents mass appraisal-related information, such as mathematical models, sample sizes and mass appraisal analysis types';

COMMENT ON COLUMN valuation.mass_appraisal.id
    IS 'Mass Appraisal identifier.';

COMMENT ON COLUMN valuation.mass_appraisal.estimated_value
    IS 'The value estimated from mass appraisal process.';

COMMENT ON COLUMN valuation.mass_appraisal.mathematical_model
    IS 'The mathematical model is used for mass appraisal valuation.';
    
-- Table: valuation.single_appraisal

-- DROP TABLE IF EXISTS valuation.single_appraisal;

CREATE TABLE IF NOT EXISTS valuation.single_appraisal
(
    id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    cost_approach_id character varying(40) COLLATE pg_catalog."default",
    income_approach_id character varying(40) COLLATE pg_catalog."default",
    sales_comparison_approach_id character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT single_appraisal_pkey PRIMARY KEY (id),
    CONSTRAINT single_appraisal_cost_approach_id_fkey FOREIGN KEY (cost_approach_id)
        REFERENCES valuation.cost_calibration (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT single_appraisal_id_fkey FOREIGN KEY (id)
        REFERENCES valuation.valuation (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT single_appraisal_income_approach_id_fkey FOREIGN KEY (income_approach_id)
        REFERENCES valuation.income_calibration (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT single_appraisal_sales_comparison_approach_id_fkey FOREIGN KEY (sales_comparison_approach_id)
        REFERENCES valuation.sales_compare_calibration (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.single_appraisal
    OWNER to postgres;

COMMENT ON TABLE valuation.single_appraisal
    IS 'Provides information on single property appraisal for valuation unit';

COMMENT ON COLUMN valuation.single_appraisal.id
    IS 'Single Appraisal identifier.';    
    
COMMENT ON COLUMN valuation.single_appraisal.cost_approach_id
    IS 'The identifier of cost approach, if any.';

COMMENT ON COLUMN valuation.single_appraisal.income_approach_id
    IS 'The identifier of income approach, if any.';

COMMENT ON COLUMN valuation.single_appraisal.sales_comparison_approach_id
    IS 'The identifier of sales comparison approach, if any.';
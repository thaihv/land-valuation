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
    amount numeric(20,2) NOT NULL DEFAULT 0,
    tax_type_code character varying(40) COLLATE pg_catalog."default",
    tax_date timestamp(6) without time zone,
    assement_ratio numeric(20,2) NOT NULL DEFAULT 0,
    fiscal_year timestamp(6) without time zone,
    type_currency character varying(500) COLLATE pg_catalog."default",
    rate character varying(500) COLLATE pg_catalog."default",    
    exemption_property character varying(500) COLLATE pg_catalog."default",
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

COMMENT ON COLUMN valuation.taxation.amount
    IS 'Money amount calculated for this valuation unit.';

COMMENT ON COLUMN valuation.taxation.assement_ratio
    IS 'The ratio of tax to assessment value.';

COMMENT ON COLUMN valuation.taxation.exemption_property
    IS 'Properties is exempted from tax calculation.';

COMMENT ON COLUMN valuation.taxation.exemption_type
    IS 'Type of tax exemption.';

COMMENT ON COLUMN valuation.taxation.fiscal_year
    IS 'The fiscal year the tax is effective.';

COMMENT ON COLUMN valuation.taxation.rate
    IS 'The rate of currency for calculating at the date.';

COMMENT ON COLUMN valuation.taxation.tax_date
    IS 'The date that tax is calculated and effective.';

COMMENT ON COLUMN valuation.taxation.type_currency
    IS 'Type of currency for taxation.';
-- Index: taxation_on_rowidentifier
CREATE INDEX IF NOT EXISTS taxation_on_rowidentifier
    ON valuation.taxation USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;    
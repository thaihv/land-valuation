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
    code character varying(40),
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
    IS 'List of the valuation unit types.';

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
    
    
-- Table: valuation.valuation_unit
CREATE TABLE IF NOT EXISTS valuation.valuation_unit
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    address_id character varying(40) COLLATE pg_catalog."default",
    vu_type_code character varying(40) COLLATE pg_catalog."default",
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
    
-- Table: preparation.parcel
CREATE TABLE IF NOT EXISTS preparation.parcel
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    area double precision,
    curent_land_use character varying(255) COLLATE pg_catalog."default",    
    planed_land_use character varying(255) COLLATE pg_catalog."default",
    s_price double precision,
    f_price double precision,
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

COMMENT ON COLUMN preparation.parcel.f_price
    IS 'Land price in average per square meter in fact.';

COMMENT ON COLUMN preparation.parcel.geom
    IS 'Geometry of parcel for spatial displaying.';

COMMENT ON COLUMN preparation.parcel.planed_land_use
    IS 'Code of planed land use.';

COMMENT ON COLUMN preparation.parcel.s_price
    IS 'Land price following the investigate in average per square meter.';    

-- Table: preparation.building
CREATE TABLE IF NOT EXISTS preparation.building
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    area double precision,
    volume double precision,
    use_type character varying(255) COLLATE pg_catalog."default",
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
    s_price double precision,
    f_price double precision,
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

COMMENT ON COLUMN preparation.building.f_price
    IS 'Building price in average per square meter in fact.';

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

COMMENT ON COLUMN preparation.building.s_price
    IS 'Building price following the investigate in average per square meter.';

COMMENT ON COLUMN preparation.building.status
    IS 'Status of the building if have a status manegement.';

COMMENT ON COLUMN preparation.building.use_type
    IS 'Use type of the building.';

COMMENT ON COLUMN preparation.building.volume
    IS 'Total volume value of the building.';    

-- Table: preparation.parcels_buildings_links
CREATE TABLE IF NOT EXISTS preparation.parcels_buildings_links
(
    parcel_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    building_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
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
    s_price double precision,
    f_price double precision,
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

COMMENT ON COLUMN preparation.building_unit.f_price
    IS 'Building unit price in average per square meter in fact.';

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

COMMENT ON COLUMN preparation.building_unit.s_price
    IS 'Building unit price following the investigate in average per square meter.';

COMMENT ON COLUMN preparation.building_unit.share_in_joint_facilities
    IS 'Ratio of share of using facilities.';

COMMENT ON COLUMN preparation.building_unit.use_type
    IS 'Use type of the building unit.';

COMMENT ON COLUMN preparation.building_unit.volume
    IS 'Total volume value of the building unit.';

COMMENT ON COLUMN preparation.building_unit.belongto_building_id
    IS 'Refer to identifying of a building.';        

    
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
    
-- Table: valuation.value_type
CREATE TABLE IF NOT EXISTS valuation.value_type
(    
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT value_type_pkey PRIMARY KEY (code),
    CONSTRAINT value_type_display_value UNIQUE (display_value)
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
    area numeric(20,2) NOT NULL DEFAULT 0,
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

COMMENT ON COLUMN valuation.valuation_unit.area
    IS 'Identifies the overall area of the Valuation Unit. This should be the sum of all parcel areas that are part of the Valuation Unit.';
    
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

-- Table: preparation.valuation_model
CREATE TABLE IF NOT EXISTS preparation.valuation_model
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    name character varying(500) COLLATE pg_catalog."default",    
    version integer NOT NULL DEFAULT 1,
    transaction_id character varying(40) COLLATE pg_catalog."default",    
    CONSTRAINT valuation_model_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_model_name_version UNIQUE (name, version),
    CONSTRAINT valuation_model_transaction_id_fkey FOREIGN KEY (transaction_id)
        REFERENCES transaction.transaction (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.valuation_model
    OWNER to postgres;

COMMENT ON TABLE preparation.valuation_model
    IS 'Used to store information about valuation model. it includes attributes such as transaction, version to trace inputs and outputs of model implementation';

COMMENT ON COLUMN preparation.valuation_model.id
    IS 'Identifier of the model.';

COMMENT ON COLUMN preparation.valuation_model.name
    IS 'Display name of the valuation model.';

COMMENT ON COLUMN preparation.valuation_model.version
    IS 'Version number of the model as system can support many versions in each transaction.';

COMMENT ON COLUMN preparation.valuation_model.transaction_id
    IS 'Identifier to which transaction is on valuation activities.';
                
-- Table: preparation.model_coefficient
CREATE TABLE IF NOT EXISTS preparation.model_coefficient
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    model_id character varying(40) COLLATE pg_catalog."default",
    parameter_code character varying(40) COLLATE pg_catalog."default",
    range_from double precision,
    range_to double precision,    
    coefficient_value numeric(20,2) NOT NULL DEFAULT 0,
    valid_from timestamp(6) without time zone,
    valid_to timestamp(6) without time zone,    
    child_list character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT model_coefficients_pkey PRIMARY KEY (id),
    CONSTRAINT model_coefficients_code_fkey FOREIGN KEY (parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT model_coefficients_model_id_fkey FOREIGN KEY (model_id)
        REFERENCES preparation.valuation_model (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.model_coefficient
    OWNER to postgres;

COMMENT ON TABLE preparation.model_coefficient
    IS 'Used to store the calculated coefficients of regression model.';

COMMENT ON COLUMN preparation.model_coefficient.id
    IS 'Identifier of the coefficient for model.';

COMMENT ON COLUMN preparation.model_coefficient.coefficient_value
    IS 'Value of the coefficient corresponding with parameter code.';

COMMENT ON COLUMN preparation.model_coefficient.model_id
    IS 'The id of the model associated. If the coefficient is not generated by a model of mass appraisal procedures it can be NULL as this coefficient is almost predefined for a parameter in a formula.';

COMMENT ON COLUMN preparation.model_coefficient.parameter_code
    IS 'The code of the technical parameter.';

COMMENT ON COLUMN preparation.model_coefficient.child_list
    IS 'The list of sub-coefficient identifiers that concatenated into a string by commas.';
    
COMMENT ON COLUMN preparation.model_coefficient.range_from
    IS 'Begining of bound of the paramater value. Necessary when segmenting parameter measurement into value ranges.';

COMMENT ON COLUMN preparation.model_coefficient.range_to
    IS 'End of bound of the paramater value. Necessary when segmenting parameter measurement into value ranges.';

COMMENT ON COLUMN preparation.model_coefficient.valid_from
    IS 'The date that coefficient is valid.';

COMMENT ON COLUMN preparation.model_coefficient.valid_to
    IS 'The date that coefficient is retired.';
    
-- Table: preparation.model_basevalue
CREATE TABLE IF NOT EXISTS preparation.model_basevalue
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    model_id character varying(40) COLLATE pg_catalog."default",
    constant_name character varying(40) COLLATE pg_catalog."default",
    parameter_code character varying(40) COLLATE pg_catalog."default",
    base_value numeric(20,2) NOT NULL DEFAULT 0,    
    valid_from timestamp(6) without time zone,
    valid_to timestamp(6) without time zone,    
    child_list character varying(255) COLLATE pg_catalog."default",    
    CONSTRAINT model_basevalue_pkey PRIMARY KEY (id),
    CONSTRAINT model_basevalue_model_id_fkey FOREIGN KEY (model_id)
        REFERENCES preparation.valuation_model (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT model_basevalue_parameter_code_fkey FOREIGN KEY (parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.model_basevalue
    OWNER to postgres;

COMMENT ON TABLE preparation.model_basevalue
    IS 'Used to store the calculated base values or contants of regression model.';

COMMENT ON COLUMN preparation.model_basevalue.id
    IS 'Identifier of the base value or constant for model.';

COMMENT ON COLUMN preparation.model_basevalue.child_list
    IS 'The list of sub-basevalue identifiers that concatenated into a string by commas.';

COMMENT ON COLUMN preparation.model_basevalue.parameter_code
    IS 'The code of the technical parameter.';
    
COMMENT ON COLUMN preparation.model_basevalue.constant_name
    IS 'The name of constant or base value, if any.';

COMMENT ON COLUMN preparation.model_basevalue.base_value
    IS 'Value of the constant name or base value.';

COMMENT ON COLUMN preparation.model_basevalue.valid_from
    IS 'The date that basevalue is valid.';

COMMENT ON COLUMN preparation.model_basevalue.valid_to
    IS 'The date that basevalue is retired.';
    
COMMENT ON COLUMN preparation.model_basevalue.model_id
    IS 'The id of the model associated. If the constant is not generated by a model of mass appraisal procedures it can be NULL as this constant is almost predefined for a parameter in a formula.';    

-- Table: preparation.valuation_formula
CREATE TABLE IF NOT EXISTS preparation.valuation_formula
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    name character varying(60) COLLATE pg_catalog."default" NOT NULL,
    sequence integer NOT NULL,
    left_coefficient_id character varying(40) COLLATE pg_catalog."default",
    left_parameter_code character varying(40) COLLATE pg_catalog."default",    
    operation character varying(60) COLLATE pg_catalog."default" NOT NULL,
    special_operation character varying(60) COLLATE pg_catalog."default",   
    right_coefficient_id character varying(40) COLLATE pg_catalog."default",
    right_parameter_code character varying(40) COLLATE pg_catalog."default",
    use_basevalue_id character varying(40) COLLATE pg_catalog."default",
    ceil double precision,
    floor double precision,     
    parent_formula_id character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT valuation_formula_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_formula_use_basevalue_id UNIQUE (use_basevalue_id),
    CONSTRAINT valuation_formula_left_coefficient_id_fkey FOREIGN KEY (left_coefficient_id)
        REFERENCES preparation.model_coefficient (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_formula_left_parameter_code_fkey FOREIGN KEY (left_parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,    
    CONSTRAINT valuation_formula_right_coefficient_id_fkey FOREIGN KEY (right_coefficient_id)
        REFERENCES preparation.model_coefficient (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_formula_right_parameter_code_fkey FOREIGN KEY (right_parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,        
    CONSTRAINT valuation_formula_parent_formula_id_fkey FOREIGN KEY (parent_formula_id)
        REFERENCES preparation.valuation_formula (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_formula_use_basevalue_id_fkey FOREIGN KEY (use_basevalue_id)
        REFERENCES preparation.model_basevalue (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.valuation_formula
    OWNER to postgres;

COMMENT ON TABLE preparation.valuation_formula
    IS 'Used to store information about functions that implementated for valuation activities. Valuation functions are used to define the actual calculation procedures by linking together coefficient, technical parameters (e.g., object area) and other valuation functions.';

COMMENT ON COLUMN preparation.valuation_formula.id
    IS 'Identifier of the formula.';

COMMENT ON COLUMN preparation.valuation_formula.ceil
    IS 'Ceil value of the formula.';

COMMENT ON COLUMN preparation.valuation_formula.floor
    IS 'Floor value of the formula.';

COMMENT ON COLUMN preparation.valuation_formula.name
    IS 'Display name of the formula.';

COMMENT ON COLUMN preparation.valuation_formula.operation
    IS 'Name of operation for formula for example sum, subtraction, product, division, min, max, lower, greater, etc.';

COMMENT ON COLUMN preparation.valuation_formula.special_operation
    IS 'Name of special operation for formula for example logical operations as is null, not, OR, AND, equals, or user defined.';
    
COMMENT ON COLUMN preparation.valuation_formula.sequence
    IS 'Sequence of the formula in relationship with its parent formula.';

COMMENT ON COLUMN preparation.valuation_formula.parent_formula_id
    IS 'Identifier of the formula where is its immediate parent, it could be NULL as no specific parent.';

COMMENT ON COLUMN preparation.valuation_formula.use_basevalue_id
    IS 'Identifier to the base value in calculation.';

COMMENT ON COLUMN preparation.valuation_formula.left_coefficient_id
    IS 'Identifier of the left coefficient in the formula.';

COMMENT ON COLUMN preparation.valuation_formula.left_parameter_code
    IS 'Identifier of the left parameter in the formula.';

COMMENT ON COLUMN preparation.valuation_formula.right_coefficient_id
    IS 'Identifier of the right coefficient in the formula.';

COMMENT ON COLUMN preparation.valuation_formula.right_parameter_code
    IS 'Identifier of the right parameter in the formula.';

-- Table: application.notify_property
CREATE TABLE IF NOT EXISTS application.notify_property
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    application_id character varying(40) COLLATE pg_catalog."default",
    vunit_id character varying(40) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,    
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT notify_property_pkey PRIMARY KEY (id),
    CONSTRAINT notify_property_application_id_fkey FOREIGN KEY (application_id)
        REFERENCES application.application (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT notify_property_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.notify_property
    OWNER to postgres;

COMMENT ON TABLE application.notify_property
    IS 'Properties are associated to a notify.';

COMMENT ON COLUMN application.notify_property.id
    IS 'Identifier for the notify property.';

COMMENT ON COLUMN application.notify_property.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN application.notify_property.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN application.notify_property.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN application.notify_property.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN application.notify_property.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN application.notify_property.application_id
    IS 'Identifier for the application the record is associated to.';

COMMENT ON COLUMN application.notify_property.vunit_id
    IS 'Reference to a record in the Valuation Unit table that matches the property details provided for the notification.';
    
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
    IS 'Links the valuation unit to the sources (e.g., documents, photographs, deeds, entry forms collected in the on-site visits or new application submission, etc.) in valuation process.';

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
    
-- Table: preparation.parcel
CREATE TABLE IF NOT EXISTS preparation.parcel
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    geom geometry NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,    
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT parcel_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parcel
    OWNER to postgres;

COMMENT ON TABLE preparation.parcel
    IS 'Provides detailed information about valuation unit as parcel.';
    
COMMENT ON COLUMN preparation.parcel.geom
    IS 'Geometry of parcel for spatial displaying.';
    
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
    type_use_code character varying(20) COLLATE pg_catalog."default",
    building_type character varying(255) COLLATE pg_catalog."default",
    construct_material_type character varying(20) COLLATE pg_catalog."default",
    facade_material_type character varying(20) COLLATE pg_catalog."default",    
    date_construction timestamp(6) without time zone,
    quality character varying(255) COLLATE pg_catalog."default",
    status character varying(255) COLLATE pg_catalog."default",        
    energy_performance_value character varying(20) COLLATE pg_catalog."default",
    heating_system_source_type character varying(20) COLLATE pg_catalog."default",
    heating_system_type character varying(20) COLLATE pg_catalog."default",    
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
    CONSTRAINT building_construct_material_type_fkey FOREIGN KEY (construct_material_type)
        REFERENCES preparation.construction_material_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_facade_material_type_fkey FOREIGN KEY (facade_material_type)
        REFERENCES preparation.facade_material_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,        
    CONSTRAINT building_energy_performance_value_fkey FOREIGN KEY (energy_performance_value)
        REFERENCES preparation.energy_performance_value (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_heating_system_source_type_fkey FOREIGN KEY (heating_system_source_type)
        REFERENCES preparation.heating_system_source_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_heating_system_type_fkey FOREIGN KEY (heating_system_type)
        REFERENCES preparation.heating_system_type (code) MATCH SIMPLE
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

COMMENT ON COLUMN preparation.building.building_type
    IS 'Type of the building if have a classification.';

COMMENT ON COLUMN preparation.building.construct_material_type
    IS 'Material type used for constructing of building.';

COMMENT ON COLUMN preparation.building.date_construction
    IS 'The date of construction.';

COMMENT ON COLUMN preparation.building.elevator
    IS 'Number of elevators of the building.';

COMMENT ON COLUMN preparation.building.energy_performance_value
    IS 'Energy performance value of the bulding.';

COMMENT ON COLUMN preparation.building.facade_material_type
    IS 'Material type of the building facade.';

COMMENT ON COLUMN preparation.building.geom
    IS 'Geometry of building for spatial displaying.';

COMMENT ON COLUMN preparation.building.heating_system_source_type
    IS 'Heating source type of the bulding.';

COMMENT ON COLUMN preparation.building.heating_system_type
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
    use_type character varying(20) COLLATE pg_catalog."default",        
    number_bathrooms integer,
    number_bedrooms integer,
    number_rooms integer,
    share_in_joint_facilities double precision,
    existed_accessory_part boolean,
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
    CONSTRAINT building_unit_use_type_fkey FOREIGN KEY (use_type)
        REFERENCES preparation.building_use_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_unit
    OWNER to postgres;

COMMENT ON TABLE preparation.building_unit
    IS 'Provides detailed information about valuation unit as building unit or also called condominium unit.';

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

COMMENT ON COLUMN preparation.building_unit.existed_accessory_part
    IS 'Whether space use as accessory or not.';

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

-- Table: preparation.parcel_area
CREATE TABLE IF NOT EXISTS preparation.parcel_area
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    parcel_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    type_code character varying(20) COLLATE pg_catalog."default",
    size numeric(20,2) NOT NULL DEFAULT 0,
    CONSTRAINT parcel_area_pkey PRIMARY KEY (id),
    CONSTRAINT parcel_area_parcel_id_fkey FOREIGN KEY (parcel_id)
        REFERENCES preparation.parcel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT parcel_area_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES preparation.area_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parcel_area
    OWNER to postgres;

COMMENT ON TABLE preparation.parcel_area
    IS 'Identifies the overall area of the parcel.';

COMMENT ON COLUMN preparation.parcel_area.size
    IS 'The value of the area. Must be in metres squared and can be converted for display if requried.';

COMMENT ON COLUMN preparation.parcel_area.parcel_id
    IS 'Identifier for the parcel this area value is associated to.';

COMMENT ON COLUMN preparation.parcel_area.type_code
    IS 'The type of area. E.g. officialArea, calculatedArea, etc.';
    
-- Table: preparation.building_area
CREATE TABLE IF NOT EXISTS preparation.building_area
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    building_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    type_code character varying(20) COLLATE pg_catalog."default",
    size numeric(20,2) NOT NULL DEFAULT 0,    
    CONSTRAINT building_area_pkey PRIMARY KEY (id),
    CONSTRAINT building_area_building_id_fkey FOREIGN KEY (building_id)
        REFERENCES preparation.building (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_area_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES preparation.area_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_area
    OWNER to postgres;

COMMENT ON TABLE preparation.building_area
    IS 'Identifies the overall area of the building.';

COMMENT ON COLUMN preparation.building_area.size
    IS 'The value of the area. Must be in metres squared and can be converted for display if requried.';

COMMENT ON COLUMN preparation.building_area.building_id
    IS 'Identifier for the building this area value is associated to.';

COMMENT ON COLUMN preparation.building_area.type_code
    IS 'The type of area. E.g. officialArea, calculatedArea, etc.'; 

-- Table: preparation.building_unit_area
CREATE TABLE IF NOT EXISTS preparation.building_unit_area
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    building_unit_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    type_code character varying(20) COLLATE pg_catalog."default",
    size numeric(20,2) NOT NULL DEFAULT 0,    
    CONSTRAINT building_unit_area_pkey PRIMARY KEY (id),
    CONSTRAINT building_unit_area_building_unit_id_fkey FOREIGN KEY (building_unit_id)
        REFERENCES preparation.building_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_unit_area_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES preparation.area_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_unit_area
    OWNER to postgres;

COMMENT ON TABLE preparation.building_unit_area
    IS 'Identifies the overall area of the building unit.';

COMMENT ON COLUMN preparation.building_unit_area.size
    IS 'The value of the area. Must be in metres squared and can be converted for display if requried.';

COMMENT ON COLUMN preparation.building_unit_area.building_unit_id
    IS 'Identifier for the building unit this area value is associated to.';

COMMENT ON COLUMN preparation.building_unit_area.type_code
    IS 'The type of area. E.g. officialArea, calculatedArea, etc.';        

-- Table: preparation.building_volume
CREATE TABLE IF NOT EXISTS preparation.building_volume
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    building_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    type_code character varying(20) COLLATE pg_catalog."default",
    size numeric(20,2) NOT NULL DEFAULT 0,    
    CONSTRAINT building_volume_pkey PRIMARY KEY (id),
    CONSTRAINT building_volume_building_id_fkey FOREIGN KEY (building_id)
        REFERENCES preparation.building (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_volume_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES preparation.volume_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_volume
    OWNER to postgres;

COMMENT ON TABLE preparation.building_volume
    IS 'Identifies the overall volume of the building.';

COMMENT ON COLUMN preparation.building_volume.size
    IS 'The value of the volume. Must be in cubic meter and can be converted for display if requried.';

COMMENT ON COLUMN preparation.building_volume.building_id
    IS 'Identifier for the building this volume value is associated to.';

COMMENT ON COLUMN preparation.building_volume.type_code
    IS 'The type of volume. E.g. officialVolume, calculatedVolume, etc.';

-- Table: preparation.building_unit_volume
CREATE TABLE IF NOT EXISTS preparation.building_unit_volume
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    building_unit_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    type_code character varying(20) COLLATE pg_catalog."default",
    size numeric(20,2) NOT NULL DEFAULT 0,    
    CONSTRAINT building_unit_volume_pkey PRIMARY KEY (id),
    CONSTRAINT building_unit_volume_building_unit_id_fkey FOREIGN KEY (building_unit_id)
        REFERENCES preparation.building_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT building_unit_volume_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES preparation.volume_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.building_unit_volume
    OWNER to postgres;

COMMENT ON TABLE preparation.building_unit_volume
    IS 'Identifies the overall volume of the building unit.';

COMMENT ON COLUMN preparation.building_unit_volume.size
    IS 'The value of the volume. Must be in metres cubic and can be converted for display if requried.';

COMMENT ON COLUMN preparation.building_unit_volume.building_unit_id
    IS 'Identifier for the parcel this area value is associated to.';

COMMENT ON COLUMN preparation.building_unit_volume.type_code
    IS 'The type of volume. E.g. officialVolume, calculatedVolume, etc.';    
    
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
    sample_size integer NOT NULL,
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
    IS 'Mass appraisal performance identifier.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.analysis_date
    IS 'The analysis date of mass appraisal implementation.';

COMMENT ON COLUMN valuation.mass_appraisal_performance.sample_size
    IS 'Size of mass appraisal implementation model sample.';

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
    vunit_id character varying(40) COLLATE pg_catalog."default",
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
    CONSTRAINT taxation_vunit_id_fkey FOREIGN KEY (vunit_id)
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
    contract_number character varying(40) COLLATE pg_catalog."default",
    price numeric(20,2) NOT NULL DEFAULT 0,
    unit_price numeric(20,2) NOT NULL DEFAULT 0,    
    certificated_date timestamp(6) without time zone,
    real_estate_agency_name character varying(255) COLLATE pg_catalog."default",    
    real_estate_agency_address_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    transaction_type_code character varying(20) COLLATE pg_catalog."default",
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    CONSTRAINT transaction_price_pkey PRIMARY KEY (id),
    CONSTRAINT transaction_price_real_estate_agency_address_id_fkey FOREIGN KEY (real_estate_agency_address_id)
        REFERENCES address.address (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
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

COMMENT ON COLUMN valuation.transaction_price.certificated_date
    IS 'The date of certification.';

COMMENT ON COLUMN valuation.transaction_price.contract_date
    IS 'The date that contract or declaration implement.';

COMMENT ON COLUMN valuation.transaction_price.price
    IS 'Price of property in transaction.';

COMMENT ON COLUMN valuation.transaction_price.real_estate_agency_name
    IS 'Name of real estate agency.';

COMMENT ON COLUMN valuation.transaction_price.unit_price
    IS 'Price of property in transaction calculated per meter square.';

COMMENT ON COLUMN valuation.transaction_price.real_estate_agency_address_id
    IS 'Identifier for the real estate agency address.';   

-- Table: valuation.valuation_unit_has_transaction_price
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_has_transaction_price
(
    vunit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    transaction_price_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default", 
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT valuation_unit_has_transaction_price_pkey PRIMARY KEY (vunit_id, transaction_price_id),
    CONSTRAINT valuation_unit_has_transaction_price_transaction_id_fkey FOREIGN KEY (transaction_price_id)
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

COMMENT ON COLUMN valuation.valuation_unit_has_transaction_price.transaction_price_id
    IS 'Identifier of the transaction price of property or valuation unit at certain time.';

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

-- Table: valuation.sales_comparison_method
CREATE TABLE IF NOT EXISTS valuation.sales_comparison_method
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    compared_vunit_id character varying(40),
    implemented_date timestamp(6) without time zone,
    time_adjustment numeric(20,2) NOT NULL DEFAULT 0,
    location_adjustment numeric(20,2) NOT NULL DEFAULT 0,
    physical_adjustment numeric(20,2) NOT NULL DEFAULT 0,
    estimate_value numeric(20,2) NOT NULL DEFAULT 0,
    use_formula_id character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT sales_comparison_method_pkey PRIMARY KEY (id),
    CONSTRAINT sales_comparison_method_compared_vunit_id_fkey FOREIGN KEY (compared_vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_comparison_method_use_formula_id_fkey FOREIGN KEY (use_formula_id)
        REFERENCES preparation.valuation_formula (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.sales_comparison_method
    OWNER to postgres;

COMMENT ON TABLE valuation.sales_comparison_method
    IS 'Represents contents of adjustments of time, location and physical ones with estimated value for sales comparision between valuation units.';

COMMENT ON COLUMN valuation.sales_comparison_method.id
    IS 'The sales comparision approach identifier.';

COMMENT ON COLUMN valuation.sales_comparison_method.implemented_date
    IS 'The date that sales comparision approach implemented.';

COMMENT ON COLUMN valuation.sales_comparison_method.estimate_value
    IS 'The value (in currency) estimated from the implementation.';

COMMENT ON COLUMN valuation.sales_comparison_method.location_adjustment
    IS 'Adjustments of location in value to compared valuation unit.';

COMMENT ON COLUMN valuation.sales_comparison_method.physical_adjustment
    IS 'Adjustments of physical ones in value to compared valuation unit.';

COMMENT ON COLUMN valuation.sales_comparison_method.time_adjustment
    IS 'Adjustments of time in value to compared valuation unit.';
    
COMMENT ON COLUMN valuation.sales_comparison_method.use_formula_id
    IS 'Identifier of the formula implementation.';        
    
-- Table: valuation.cost_method
CREATE TABLE IF NOT EXISTS valuation.cost_method
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    implemented_date timestamp(6) without time zone,
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
    use_formula_id character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT cost_method_pkey PRIMARY KEY (id),
    CONSTRAINT cost_method_cost_approach_type_code_fkey FOREIGN KEY (cost_approach_type_code)
        REFERENCES valuation.cost_approach_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT cost_method_use_formula_id_fkey FOREIGN KEY (use_formula_id)
        REFERENCES preparation.valuation_formula (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.cost_method
    OWNER to postgres;

COMMENT ON TABLE valuation.cost_method
    IS 'Represents cost-related characteristics, such as cost type (e.g., replacement or reproduction cost), cost-related attributes, chronological and effective age of building and obsolescence for valuation approach of cost.';

COMMENT ON COLUMN valuation.cost_method.id
    IS 'The cost approach identifier.';

COMMENT ON COLUMN valuation.cost_method.implemented_date
    IS 'The date that cost approach implemented.';

COMMENT ON COLUMN valuation.cost_method.chronological_age
    IS 'The chronological age of property.';

COMMENT ON COLUMN valuation.cost_method.cost_price_per_square_meter
    IS 'The value (in currency) calculated per each square meter.';

COMMENT ON COLUMN valuation.cost_method.effective_age
    IS 'The effective age of property.';

COMMENT ON COLUMN valuation.cost_method.estimate_value
    IS 'The value (in currency) estimated from cost implementation.';

COMMENT ON COLUMN valuation.cost_method.external_obsolescence
    IS 'The value (in currency) calculated for external obsolescence.';

COMMENT ON COLUMN valuation.cost_method.functional_obsolescence
    IS 'The value (in currency) calculated for functional obsolescence.';

COMMENT ON COLUMN valuation.cost_method.physical_obsolescence
    IS 'The value (in currency) calculated for physical obsolescence.';

COMMENT ON COLUMN valuation.cost_method.source_of_cost_price
    IS 'The source of cost price the implementation refered to.';

COMMENT ON COLUMN valuation.cost_method.total_cost
    IS 'The value (in currency) in total cost calculated.';

COMMENT ON COLUMN valuation.cost_method.total_obsolescence
    IS 'The value (in currency) calculated for total obsolescence.';    

COMMENT ON COLUMN valuation.cost_method.use_formula_id
    IS 'Identifier of the formula implementation.';
        
-- Table: valuation.income_method
CREATE TABLE IF NOT EXISTS valuation.income_method
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    implemented_date timestamp(6) without time zone,
    net_income double precision,
    potential_gross_income double precision,
    effective_gross_income double precision,
    gross_income_multiplier double precision,
    operating_expenses double precision,    
    capitalization_rate double precision,
    discount_rate double precision,
    estimate_value numeric(20,2) NOT NULL DEFAULT 0,
	use_formula_id character varying(40) COLLATE pg_catalog."default",        
    CONSTRAINT income_method_pkey PRIMARY KEY (id),
    CONSTRAINT income_method_use_formula_id_fkey FOREIGN KEY (use_formula_id)
        REFERENCES preparation.valuation_formula (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.income_method
    OWNER to postgres;

COMMENT ON TABLE valuation.income_method
    IS 'Represents income information, such as gross, effective and net income and operating expenses and capitalization rates characteristics for valuation approach of income.';

COMMENT ON COLUMN valuation.income_method.id
    IS 'The income approach identifier.';

COMMENT ON COLUMN valuation.income_method.implemented_date
    IS 'The date that income approach implemented.';

COMMENT ON COLUMN valuation.income_method.capitalization_rate
    IS 'The capitalization rate in implementation.';

COMMENT ON COLUMN valuation.income_method.discount_rate
    IS 'The discount rate in implementation.';

COMMENT ON COLUMN valuation.income_method.effective_gross_income
    IS 'The effective gross income value(in currency) in implementation.';

COMMENT ON COLUMN valuation.income_method.estimate_value
    IS 'The value estimated from income implementation.';

COMMENT ON COLUMN valuation.income_method.gross_income_multiplier
    IS 'The gross income multiplier used in calculated.';

COMMENT ON COLUMN valuation.income_method.net_income
    IS 'The net income value(in currency) in implementation.';

COMMENT ON COLUMN valuation.income_method.operating_expenses
    IS 'The operating_expenses (in currency) in implementation.';

COMMENT ON COLUMN valuation.income_method.potential_gross_income
    IS 'The potential gross income value(in currency) in implementation.';
    
COMMENT ON COLUMN valuation.income_method.use_formula_id
    IS 'Identifier of the formula implementation.';       
    
-- Table: valuation.valuation
CREATE TABLE IF NOT EXISTS valuation.valuation
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    transaction_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    assessed_value numeric(20,2) NOT NULL DEFAULT 0,
    valuation_purpose character varying(128) COLLATE pg_catalog."default",
    valuation_date timestamp(6) without time zone,
    appeal_status_code character varying(20) COLLATE pg_catalog."default",
    approach_type_code character varying(20) COLLATE pg_catalog."default",
    value_type_code character varying(20) COLLATE pg_catalog."default",
    vunit_id character varying(40) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,    
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT valuation_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_transaction_id_fkey FOREIGN KEY (transaction_id)
        REFERENCES transaction.transaction (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,    
    CONSTRAINT valuation_appeal_status_code_fkey FOREIGN KEY (appeal_status_code)
        REFERENCES valuation.appeal_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_approach_type_code_fkey FOREIGN KEY (approach_type_code)
        REFERENCES valuation.valuation_approach_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_vunit_id_fkey FOREIGN KEY (vunit_id)
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

COMMENT ON COLUMN valuation.valuation.transaction_id
    IS 'Identifier to a transaction for report purposes.';    

COMMENT ON COLUMN valuation.valuation.vunit_id
    IS 'Identifier to valuation unit of assement activity.';
    
COMMENT ON COLUMN valuation.valuation.assessed_value
    IS 'The final decision value of valuation unit in currency. This is the final decision one selected from all valuation methods.';

COMMENT ON COLUMN valuation.valuation.valuation_purpose
    IS 'Display the purpose of valuation activity.';
    
COMMENT ON COLUMN valuation.valuation.value_type_code
    IS 'Type of value need to be valuated,  i.e., reasearchValue for survey operation, compensationValue for specific purpose, decisionValue for final mass appraisals.';

COMMENT ON COLUMN valuation.valuation.valuation_date
    IS 'The date that value is made for valuation.';

-- Table: valuation.mass_appraisal
CREATE TABLE IF NOT EXISTS valuation.mass_appraisal
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    valuation_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    model_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    sample_size integer NOT NULL,
    estimated_value numeric(20,2) NOT NULL DEFAULT 0,    
    performance_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT mass_appraisal_pkey PRIMARY KEY (id),
    CONSTRAINT mass_appraisal_model_id_fkey FOREIGN KEY (model_id)
        REFERENCES preparation.valuation_model (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,    
    CONSTRAINT mass_appraisal_performance_id_fkey FOREIGN KEY (performance_id)
        REFERENCES valuation.mass_appraisal_performance (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT mass_appraisal_valuation_id_fkey FOREIGN KEY (valuation_id)
        REFERENCES valuation.valuation (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.mass_appraisal
    OWNER to postgres;

COMMENT ON TABLE valuation.mass_appraisal
    IS 'Provides the represent mass appraisal-related information, such as mathematical models, sample sizes and mass appraisal analysis types';

COMMENT ON COLUMN valuation.mass_appraisal.id
    IS 'Mass Appraisal identifier.';

COMMENT ON COLUMN valuation.mass_appraisal.estimated_value
    IS 'The value estimated from the mass appraisal performance.';

COMMENT ON COLUMN valuation.mass_appraisal.model_id
    IS 'Identifier to the mathematical model that is used for the mass appraisal performance.';

COMMENT ON COLUMN valuation.mass_appraisal.sample_size
    IS 'Size of model sample of the mass appraisal performance.';    

COMMENT ON COLUMN valuation.mass_appraisal.performance_id
    IS 'The identifier of the associated mass appraisal performance.';    
    
-- Table: valuation.single_appraisal
CREATE TABLE IF NOT EXISTS valuation.single_appraisal
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    valuation_id character varying(40) COLLATE pg_catalog."default",
    cost_approach_id character varying(40) COLLATE pg_catalog."default",
    income_approach_id character varying(40) COLLATE pg_catalog."default",
    sales_comparison_approach_id character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT single_appraisal_pkey PRIMARY KEY (id),
    CONSTRAINT single_appraisal_valuation_id_fkey FOREIGN KEY (valuation_id)
        REFERENCES valuation.valuation (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,    
    CONSTRAINT single_appraisal_cost_approach_id_fkey FOREIGN KEY (cost_approach_id)
        REFERENCES valuation.cost_method (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT single_appraisal_income_approach_id_fkey FOREIGN KEY (income_approach_id)
        REFERENCES valuation.income_method (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT single_appraisal_sales_comparison_approach_id_fkey FOREIGN KEY (sales_comparison_approach_id)
        REFERENCES valuation.sales_comparison_method (id) MATCH SIMPLE
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
        
-- Table: administrative.rrr
CREATE TABLE IF NOT EXISTS administrative.rrr
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    vunit_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    reference_nr character varying(20) COLLATE pg_catalog."default", 
    type_code character varying(20) COLLATE pg_catalog."default",
    is_primary boolean NOT NULL DEFAULT false,
    registration_date timestamp(6) without time zone,    
    expiration_date timestamp(6) without time zone,                   
    amount numeric(29,2),
    due_date timestamp(6) without time zone,
    mortgage_interest_rate numeric(5,2),
    mortgage_ranking integer NOT NULL,
    mortgage_type_code character varying(20) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),            
    CONSTRAINT rrr_pkey PRIMARY KEY (id),
    CONSTRAINT rrr_mortgage_type_code_fkey FOREIGN KEY (mortgage_type_code)
        REFERENCES administrative.mortgage_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rrr_type_code_fkey FOREIGN KEY (type_code)
        REFERENCES administrative.rrr_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rrr_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.rrr
    OWNER to postgres;

COMMENT ON TABLE administrative.rrr
    IS 'Store the specific rights, restrictions and responsibilities that might be enquire from a valuation unit (called also a property) e.g. freehold ownership, lease, mortgage, caveat, etc. Implementation of the LADM LA_RRR class.';

COMMENT ON COLUMN administrative.rrr.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.rrr.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.rrr.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.rrr.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.rrr.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN administrative.rrr.amount
    IS 'The value of the mortgage.';

COMMENT ON COLUMN administrative.rrr.due_date
    IS 'The date of the next payment for the RRR.';

COMMENT ON COLUMN administrative.rrr.expiration_date
    IS 'The date and time defining when the RRR remains in force to.';

COMMENT ON COLUMN administrative.rrr.is_primary
    IS 'Flag to indicate if the RRR type is a primary RRR from Valuation Unit.';

COMMENT ON COLUMN administrative.rrr.mortgage_interest_rate
    IS 'The interest rate of the mortgage as a percentage.';

COMMENT ON COLUMN administrative.rrr.mortgage_ranking
    IS 'The ranking order if more than one mortgage applies to the right.';

COMMENT ON COLUMN administrative.rrr.reference_nr
    IS 'Number to identify the hitorical RRR. Could be determined by the generate function of business rule. This value is useful to track the different versions of the RRR as it is edited over time.';

COMMENT ON COLUMN administrative.rrr.registration_date
    IS 'The date and time the RRR was formally registered by the Land Administration Agency.';

COMMENT ON COLUMN administrative.rrr.mortgage_type_code
    IS 'The type of mortgage.';

COMMENT ON COLUMN administrative.rrr.type_code
    IS 'The type of RRR. E.g. freehold ownership, lease, mortage, caveat, etc.';

COMMENT ON COLUMN administrative.rrr.vunit_id
    IS 'Identifier for the Valuation Unit the RRR need to query. In terms of Land Registration, this relationship is similar to RRR and BA_Unit from LADM';
    
-- Table: administrative.rrr_share
CREATE TABLE IF NOT EXISTS administrative.rrr_share
(
    rrr_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    nominator integer NOT NULL,
    denominator integer NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),            
    CONSTRAINT rrr_share_pkey PRIMARY KEY (rrr_id, id),
    CONSTRAINT rrr_share_rrr_id_fkey FOREIGN KEY (rrr_id)
        REFERENCES administrative.rrr (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.rrr_share
    OWNER to postgres;

COMMENT ON TABLE administrative.rrr_share
    IS 'Identifies the share a party has in an RRR.';

COMMENT ON COLUMN administrative.rrr_share.id
    IS 'Identifier for the RRR share.';

COMMENT ON COLUMN administrative.rrr_share.rrr_id
    IS 'Identifier of the RRR the share is assocaited with.';

COMMENT ON COLUMN administrative.rrr_share.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.rrr_share.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.rrr_share.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.rrr_share.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.rrr_share.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN administrative.rrr_share.denominator
    IS 'Denominator part of the share (i.e. bottom number of fraction)';

COMMENT ON COLUMN administrative.rrr_share.nominator
    IS 'Nominiator part of the share (i.e. top number of fraction)';
    
-- Table: administrative.source_describes_rrr
CREATE TABLE IF NOT EXISTS administrative.source_describes_rrr
(
    rrr_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    source_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,    
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT source_describes_rrr_pkey PRIMARY KEY (rrr_id, source_id),
    CONSTRAINT source_describes_rrr_rrr_id_fkey FOREIGN KEY (rrr_id)
        REFERENCES administrative.rrr (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT source_describes_rrr_source_id_fkey FOREIGN KEY (source_id)
        REFERENCES source.source (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.source_describes_rrr
    OWNER to postgres;

COMMENT ON TABLE administrative.source_describes_rrr
    IS 'Associates a RRR with one or more source (a.k.a. document) records. Implementation of the LADM LA_RRR to LA_AdministrativeSource relationship.';

COMMENT ON COLUMN administrative.source_describes_rrr.rrr_id
    IS 'The id of the rrr.';

COMMENT ON COLUMN administrative.source_describes_rrr.source_id
    IS 'The id of source.';

COMMENT ON COLUMN administrative.source_describes_rrr.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.source_describes_rrr.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.source_describes_rrr.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.source_describes_rrr.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.source_describes_rrr.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';  
    
-- Table: administrative.party_for_rrr
CREATE TABLE IF NOT EXISTS administrative.party_for_rrr
(
    rrr_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    party_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    share_id character varying(40) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),            
    CONSTRAINT party_for_rrr_pkey PRIMARY KEY (party_id, rrr_id),
    CONSTRAINT party_for_rrr_party_id_fkey FOREIGN KEY (party_id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_for_rrr_rrr_id_fkey FOREIGN KEY (rrr_id)
        REFERENCES administrative.rrr (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT party_for_rrr_rrr_id_share_id_fkey FOREIGN KEY (rrr_id, share_id)
        REFERENCES administrative.rrr_share (rrr_id, id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.party_for_rrr
    OWNER to postgres;

COMMENT ON TABLE administrative.party_for_rrr
    IS 'Identifies the parties involved in each RRR. Also identifies the share each party has in the RRR if the RRR is subject to shared allocation.';

COMMENT ON COLUMN administrative.party_for_rrr.party_id
    IS 'Identifier for the party associated to the RRR.';

COMMENT ON COLUMN administrative.party_for_rrr.rrr_id
    IS 'The id of the rrr.';

COMMENT ON COLUMN administrative.party_for_rrr.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.party_for_rrr.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.party_for_rrr.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.party_for_rrr.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.party_for_rrr.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
    
-- Table: administrative.mortgage_isbased_in_rrr
CREATE TABLE IF NOT EXISTS administrative.mortgage_isbased_in_rrr
(
    mortgage_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rrr_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT mortgage_isbased_in_rrr_pkey PRIMARY KEY (mortgage_id, rrr_id),
    CONSTRAINT mortgage_isbased_in_rrr_mortgage_id_fkey FOREIGN KEY (mortgage_id)
        REFERENCES administrative.rrr (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT mortgage_isbased_in_rrr_rrr_id_fkey FOREIGN KEY (rrr_id)
        REFERENCES administrative.rrr (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.mortgage_isbased_in_rrr
    OWNER to postgres;

COMMENT ON TABLE administrative.mortgage_isbased_in_rrr
    IS 'Identifies RRR that is subject to mortgage. Not used as if the primary right will always be the subject of the mortgage.';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.mortgage_id
    IS 'Identifier for the mortgage.';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.rrr_id
    IS 'Identifier for the RRR associated to the mortgage.';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.mortgage_isbased_in_rrr.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';
    
-- Table: administrative.condition_for_rrr
CREATE TABLE IF NOT EXISTS administrative.condition_for_rrr
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rrr_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    condition_code character varying(20) COLLATE pg_catalog."default",    
    custom_condition_text character varying(500) COLLATE pg_catalog."default",
    condition_quantity integer NOT NULL,
    condition_unit character varying(15) COLLATE pg_catalog."default",
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT condition_for_rrr_pkey PRIMARY KEY (id),
    CONSTRAINT condition_for_rrr_condition_code_fkey FOREIGN KEY (condition_code)
        REFERENCES administrative.condition_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT condition_for_rrr_rrr_id_fkey FOREIGN KEY (rrr_id)
        REFERENCES administrative.rrr (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS administrative.condition_for_rrr
    OWNER to postgres;

COMMENT ON TABLE administrative.condition_for_rrr
    IS 'Captures any statutory or agreed conditions in relation to an RRR. E.g. conditions of lease, etc. An RRR can have multiple conditions associated to it.';

COMMENT ON COLUMN administrative.condition_for_rrr.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN administrative.condition_for_rrr.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN administrative.condition_for_rrr.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN administrative.condition_for_rrr.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN administrative.condition_for_rrr.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN administrative.condition_for_rrr.condition_quantity
    IS 'A quantity value associted to the condition.';

COMMENT ON COLUMN administrative.condition_for_rrr.condition_unit
    IS 'The unit of measure applicable for the condition quantity.';

COMMENT ON COLUMN administrative.condition_for_rrr.custom_condition_text
    IS 'User entered text describing the condition and_or updated or revised text obtained from the template condition text.';

COMMENT ON COLUMN administrative.condition_for_rrr.condition_code
    IS 'The type of condition.';

COMMENT ON COLUMN administrative.condition_for_rrr.rrr_id
    IS 'Identifier of the RRR the condition relates to.';                  

-- Table: valuation.valuation_unit_contains_spatial_unit
CREATE TABLE IF NOT EXISTS valuation.valuation_unit_contains_spatial_unit
(
    spatial_unit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    vunit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),        
    CONSTRAINT valuation_unit_contains_spatial_unit_pkey PRIMARY KEY (spatial_unit_id, vunit_id),
    CONSTRAINT valuation_unit_contains_spatial_unit_parcel_id_fkey FOREIGN KEY (spatial_unit_id)
        REFERENCES preparation.parcel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,    
    CONSTRAINT valuation_unit_contains_spatial_unit_building_id_fkey FOREIGN KEY (spatial_unit_id)
        REFERENCES preparation.building (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_unit_contains_spatial_unit_building_unit_id_fkey FOREIGN KEY (spatial_unit_id)
        REFERENCES preparation.building_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,        
    CONSTRAINT valuation_unit_contains_spatial_unit_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_unit_contains_spatial_unit
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_unit_contains_spatial_unit
    IS 'Associate the valuation unit to the one or many cadastre objects as parcels, buildings valuation process.';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.spatial_unit_id
    IS 'Identifier for the Spatial Unit associated to the Valuation Unit.';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.vunit_id
    IS 'Identifier for the valuation unit to be associated to.';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_unit_contains_spatial_unit.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

-- Table: valuation.valuation_units_parameters_links
CREATE TABLE IF NOT EXISTS valuation.valuation_units_parameters_links
(
    vunit_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
    parameter_code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    value numeric(20,2) NOT NULL DEFAULT 0,
    transaction_id character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT valuation_units_parameters_links_pkey PRIMARY KEY (parameter_code, vunit_id),
    CONSTRAINT valuation_units_parameters_links_parameter_code_fkey FOREIGN KEY (parameter_code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_units_parameters_links_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT valuation_units_parameters_links_transaction_id_fkey FOREIGN KEY (transaction_id)
        REFERENCES transaction.transaction (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION        
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_units_parameters_links
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_units_parameters_links
    IS 'Measurement value of technial parameters for each valuation unit. They could be used as independent variables for regression model and they can be measured again depend on the transaction to get on.';

COMMENT ON COLUMN valuation.valuation_units_parameters_links.parameter_code
    IS 'The code of the technical parameter.';

COMMENT ON COLUMN valuation.valuation_units_parameters_links.vunit_id
    IS 'The id of the valuation unit.';

COMMENT ON COLUMN valuation.valuation_units_parameters_links.value
    IS 'Value of the parameter with corresponding valuation unit. This can be a discrete value or converted, classified from a continuous range.';
    
COMMENT ON COLUMN valuation.valuation_units_parameters_links.transaction_id
    IS 'Identifier to which transaction is on a valuation activity to get parameter values.';    
            
-- Table: application.application_property
CREATE TABLE IF NOT EXISTS application.application_property
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	application_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    vunit_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    verified_exists boolean NOT NULL DEFAULT false,
    verified_location boolean NOT NULL DEFAULT false,
    area numeric(20,2) NOT NULL DEFAULT 0,
    total_value numeric(20,2) NOT NULL DEFAULT 0,
    assignee_id character varying(40) COLLATE pg_catalog."default",    
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,  
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default", 
    change_time timestamp without time zone NOT NULL DEFAULT now(),         
    CONSTRAINT application_property_pkey PRIMARY KEY (id),
    CONSTRAINT application_property_application_id_fkey FOREIGN KEY (application_id)
        REFERENCES application.application (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT application_property_vunit_id_fkey FOREIGN KEY (vunit_id)
        REFERENCES valuation.valuation_unit (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.application_property
    OWNER to postgres;

COMMENT ON TABLE application.application_property
    IS 'Captures details of property associated to an application.';

COMMENT ON COLUMN application.application_property.id
    IS 'Identifier for the application property.';

COMMENT ON COLUMN application.application_property.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN application.application_property.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN application.application_property.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN application.application_property.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN application.application_property.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN application.application_property.verified_exists
    IS 'Flag to indicate if the property details provided for the application match an existing property record in the Valuation Unit table.';

COMMENT ON COLUMN application.application_property.verified_location
    IS 'Flag to indicate if the property details provided for the application reference an existing parcel record in the Cadastre Managemnt tables as Parcel, Buidling, UtilityNetwork.';

COMMENT ON COLUMN application.application_property.application_id
    IS 'Identifier for the application the record is associated to.';

COMMENT ON COLUMN application.application_property.vunit_id
    IS 'Reference to a record in the Valuation Unit table that matches the property details provided for the application for valuation process.'; 
    
COMMENT ON COLUMN application.application_property.area
    IS 'The area of the property for calculating proportionate service fee. This value should be square meters and may be converted into imperial acres, roods and perches values for display.';

COMMENT ON COLUMN application.application_property.assignee_id
    IS 'The identifier of the user assigned to the property for handling. Typically, this is the user in charge from application or assigned from others ';

COMMENT ON COLUMN application.application_property.total_value
    IS 'The property value on which is used for calculating proportionate service fee.';
-- Table: valuation.valuation_appeal
CREATE TABLE IF NOT EXISTS valuation.valuation_appeal
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    valuation_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    appeal_subject character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    appeal_date timestamp(6) without time zone,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),            
    CONSTRAINT valuation_appeal_pkey PRIMARY KEY (id),
    CONSTRAINT valuation_appeal_valuation_id_fkey FOREIGN KEY (valuation_id)
        REFERENCES valuation.valuation (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS valuation.valuation_appeal
    OWNER to postgres;

COMMENT ON TABLE valuation.valuation_appeal
    IS 'To be enable tracking status of possible appeals against to assessed values.';

COMMENT ON COLUMN valuation.valuation_appeal.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN valuation.valuation_appeal.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN valuation.valuation_appeal.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN valuation.valuation_appeal.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN valuation.valuation_appeal.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN valuation.valuation_appeal.appeal_date
    IS 'The date that appeal is submited against the valuation unit.';

COMMENT ON COLUMN valuation.valuation_appeal.appeal_subject
    IS 'The subject of the appeal need to be handle.';

COMMENT ON COLUMN valuation.valuation_appeal.valuation_id
    IS 'Identifier to a valuation activity';
     
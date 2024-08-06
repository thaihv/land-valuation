-- Table: preparation.tech_parameter
CREATE TABLE IF NOT EXISTS preparation.tech_parameter
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    name character varying(500) COLLATE pg_catalog."default" NOT NULL,
    type character varying(64) COLLATE pg_catalog."default",
    description character varying(1000) COLLATE pg_catalog."default",
    is_active boolean NOT NULL DEFAULT true,
    is_mandatory boolean NOT NULL DEFAULT true,
    is_virtual boolean NOT NULL DEFAULT false,
    CONSTRAINT tech_parameter_pkey PRIMARY KEY (code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.tech_parameter
    OWNER to postgres;

COMMENT ON TABLE preparation.tech_parameter
    IS 'List of all technical parameters for valuation process';
    
COMMENT ON COLUMN preparation.tech_parameter.code
    IS 'The code for the technical parameter.';    

COMMENT ON COLUMN preparation.tech_parameter.name
    IS 'Display name of the technical parameter.';

COMMENT ON COLUMN preparation.tech_parameter.type
    IS 'Type of the technical parameter as Numeric, Boolean, Enumerated, String...';
    
COMMENT ON COLUMN preparation.tech_parameter.description
    IS 'Description of the technical parameter.';

COMMENT ON COLUMN preparation.tech_parameter.is_active
    IS 'Status active of the technical parameter as active (true) or inactive (false).';

COMMENT ON COLUMN preparation.tech_parameter.is_mandatory
    IS 'Status mandatory of the technical parameter as mandatory (true) or not (false).';

COMMENT ON COLUMN preparation.tech_parameter.is_virtual
    IS 'Status virtual of the technical parameter as for virtual (true) or not (false).';
  
-- Table: preparation.parameter_setting
CREATE TABLE IF NOT EXISTS preparation.parameter_setting
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    key character varying(40) COLLATE pg_catalog."default" NOT NULL,
    value character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT parameter_setting_pkey PRIMARY KEY (code, key),
    CONSTRAINT parameter_setting_code_fkey FOREIGN KEY (code)
        REFERENCES preparation.tech_parameter (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.parameter_setting
    OWNER to postgres;

COMMENT ON TABLE preparation.parameter_setting
    IS 'List of parameter settings in format Key/Value';
    
COMMENT ON COLUMN preparation.parameter_setting.code
    IS 'The code for the technical parameter.';    

COMMENT ON COLUMN preparation.parameter_setting.key
    IS 'Key name of a parameter setting.';

COMMENT ON COLUMN preparation.parameter_setting.value
    IS 'Value of the parameter setting key.';	
    
-- Table: preparation.area_type
CREATE TABLE IF NOT EXISTS preparation.area_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT area_type_pkey PRIMARY KEY (code),
    CONSTRAINT area_type_display_value UNIQUE (display_value)
);

ALTER TABLE IF EXISTS preparation.area_type
    OWNER to postgres;

COMMENT ON TABLE preparation.area_type
    IS 'Code list of area types. Identifies the types of area (calculated, official, survey defined, etc) that can be recorded for a property.';

COMMENT ON COLUMN preparation.area_type.code
    IS 'Code of the area type.';

COMMENT ON COLUMN preparation.area_type.description
    IS 'Description of the area type.';

COMMENT ON COLUMN preparation.area_type.display_value
    IS 'Displayed value of the area type.';

COMMENT ON COLUMN preparation.area_type.status
    IS 'Status in active of the area type as active (a) or inactive (i).';          
    
-- Table: preparation.volume_type
CREATE TABLE IF NOT EXISTS preparation.volume_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT volume_type_pkey PRIMARY KEY (code),
    CONSTRAINT volume_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.volume_type
    OWNER to postgres;

COMMENT ON TABLE preparation.volume_type
    IS 'Code list of volume types. Identifies the types of volume (calculated, official, survey defined, etc) that can be recorded for a property.';

COMMENT ON COLUMN preparation.volume_type.code
    IS 'Code of the volume type.';

COMMENT ON COLUMN preparation.volume_type.description
    IS 'Description of the volume type.';

COMMENT ON COLUMN preparation.volume_type.display_value
    IS 'Displayed value of the volume type.';

COMMENT ON COLUMN preparation.volume_type.status
    IS 'Status in active of the volume type as active (a) or inactive (i).';
    
-- Table: preparation.land_use_type
CREATE TABLE IF NOT EXISTS preparation.land_use_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT land_use_type_pkey PRIMARY KEY (code),
    CONSTRAINT land_use_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.land_use_type
    OWNER to postgres;

COMMENT ON TABLE preparation.land_use_type
    IS 'Code list of land use types. Identifies the types of land use that can be recorded for a property.';

COMMENT ON COLUMN preparation.land_use_type.code
    IS 'Code of the land use type.';

COMMENT ON COLUMN preparation.land_use_type.description
    IS 'Description of the land use type.';

COMMENT ON COLUMN preparation.land_use_type.display_value
    IS 'Displayed value of the land use type.';

COMMENT ON COLUMN preparation.land_use_type.status
    IS 'Status in active of the land use type as active (a) or inactive (i).'; 
    
-- Table: preparation.facade_material_type
CREATE TABLE IF NOT EXISTS preparation.facade_material_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT facade_material_type_pkey PRIMARY KEY (code),
    CONSTRAINT facade_material_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.facade_material_type
    OWNER to postgres;

COMMENT ON TABLE preparation.facade_material_type
    IS 'Code list of facade material types. Identifies the types of facade material that can be recorded for a building.';

COMMENT ON COLUMN preparation.facade_material_type.code
    IS 'Code of the facade material type.';

COMMENT ON COLUMN preparation.facade_material_type.description
    IS 'Description of the facade material type.';

COMMENT ON COLUMN preparation.facade_material_type.display_value
    IS 'Displayed value of the facade material type.';

COMMENT ON COLUMN preparation.facade_material_type.status
    IS 'Status in active of the facade material type as active (a) or inactive (i).';    
    
-- Table: preparation.construction_material_type
CREATE TABLE IF NOT EXISTS preparation.construction_material_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT construction_material_type_pkey PRIMARY KEY (code),
    CONSTRAINT construction_material_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.construction_material_type
    OWNER to postgres;

COMMENT ON TABLE preparation.construction_material_type
    IS 'Code list of construction material types. Identifies the types of construction material that can be recorded for a building.';

COMMENT ON COLUMN preparation.construction_material_type.code
    IS 'Code of the construction material type.';

COMMENT ON COLUMN preparation.construction_material_type.description
    IS 'Description of the construction material type.';

COMMENT ON COLUMN preparation.construction_material_type.display_value
    IS 'Displayed value of the construction material type.';

COMMENT ON COLUMN preparation.construction_material_type.status
    IS 'Status in active of the construction material type as active (a) or inactive (i).';    
    
-- Table: preparation.heating_system_type
CREATE TABLE IF NOT EXISTS preparation.heating_system_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT heating_system_type_pkey PRIMARY KEY (code),
    CONSTRAINT heating_system_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.heating_system_type
    OWNER to postgres;

COMMENT ON TABLE preparation.heating_system_type
    IS 'Code list of heating system types.';

COMMENT ON COLUMN preparation.heating_system_type.code
    IS 'Code of the heating system type.';

COMMENT ON COLUMN preparation.heating_system_type.description
    IS 'Description of the heating system type.';

COMMENT ON COLUMN preparation.heating_system_type.display_value
    IS 'Displayed value of the heating system type.';

COMMENT ON COLUMN preparation.heating_system_type.status
    IS 'Status in active of the heating system type as active (a) or inactive (i).';

-- Table: preparation.heating_system_source_type
CREATE TABLE IF NOT EXISTS preparation.heating_system_source_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT heating_system_source_type_pkey PRIMARY KEY (code),
    CONSTRAINT heating_system_source_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.heating_system_source_type
    OWNER to postgres;

COMMENT ON TABLE preparation.heating_system_source_type
    IS 'Code list of heating system source types.';

COMMENT ON COLUMN preparation.heating_system_source_type.code
    IS 'Code of the heating system source type.';

COMMENT ON COLUMN preparation.heating_system_source_type.description
    IS 'Description of the heating system source type.';

COMMENT ON COLUMN preparation.heating_system_source_type.display_value
    IS 'Displayed value of the heating system source type.';

COMMENT ON COLUMN preparation.heating_system_source_type.status
    IS 'Status in active of the heating system source type as active (a) or inactive (i).';
    
-- Table: preparation.energy_performance_value
CREATE TABLE IF NOT EXISTS preparation.energy_performance_value
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT energy_performance_value_pkey PRIMARY KEY (code),
    CONSTRAINT energy_performance_value_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.energy_performance_value
    OWNER to postgres;

COMMENT ON TABLE preparation.energy_performance_value
    IS 'Code list of energy performance value types.';

COMMENT ON COLUMN preparation.energy_performance_value.code
    IS 'Code of the energy performance value type.';

COMMENT ON COLUMN preparation.energy_performance_value.description
    IS 'Description of the energy performance value type.';

COMMENT ON COLUMN preparation.energy_performance_value.display_value
    IS 'Displayed value of the energy performance value type.';

COMMENT ON COLUMN preparation.energy_performance_value.status
    IS 'Status in active of the energy performance value type as active (a) or inactive (i).';

-- Table: preparation.accessory_part_type
CREATE TABLE IF NOT EXISTS preparation.accessory_part_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT accessory_part_type_pkey PRIMARY KEY (code),
    CONSTRAINT accessory_part_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS preparation.accessory_part_type
    OWNER to postgres;

COMMENT ON TABLE preparation.accessory_part_type
    IS 'Code list of accessory part types.';

COMMENT ON COLUMN preparation.accessory_part_type.code
    IS 'Code of the accessory part type.';

COMMENT ON COLUMN preparation.accessory_part_type.description
    IS 'Description of the accessory part type.';

COMMENT ON COLUMN preparation.accessory_part_type.display_value
    IS 'Displayed value of the accessory part type.';

COMMENT ON COLUMN preparation.accessory_part_type.status
    IS 'Status in active of the accessory part type as active (a) or inactive (i).';
        
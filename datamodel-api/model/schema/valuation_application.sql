-- Table: application.application_status_type
CREATE TABLE IF NOT EXISTS application.application_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT application_status_type_pkey PRIMARY KEY (code),
    CONSTRAINT application_status_type_display_value_key UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.application_status_type
    OWNER to postgres;

COMMENT ON TABLE application.application_status_type
    IS 'Code list of application status types.';

COMMENT ON COLUMN application.application_status_type.code
    IS 'The code for the application status type.';

COMMENT ON COLUMN application.application_status_type.display_value
    IS 'Displayed value of the application status type.';

COMMENT ON COLUMN application.application_status_type.status
    IS 'Status in active of the application status type as active (a) or inactive (i).';
	
COMMENT ON COLUMN application.application_status_type.description
    IS 'Description of the application status type.';

-- Table: application.application_action_type
CREATE TABLE IF NOT EXISTS application.application_action_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,    
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
	status_to_set character varying(20) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    description character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT application_action_type_pkey PRIMARY KEY (code),
    CONSTRAINT application_action_type_display_value_key UNIQUE (display_value),
    CONSTRAINT application_action_type_status_to_set_fkey FOREIGN KEY (status_to_set)
        REFERENCES application.application_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.application_action_type
    OWNER to postgres;

COMMENT ON TABLE application.application_action_type
    IS 'Code list of action types.';

COMMENT ON COLUMN application.application_action_type.code
    IS 'The code for the application action type.';

COMMENT ON COLUMN application.application_action_type.display_value
    IS 'Displayed value of the application action type.';

COMMENT ON COLUMN application.application_action_type.status_to_set
    IS 'To explain in which of the application status type. Is NULL if not be specific.';
	
COMMENT ON COLUMN application.application_action_type.status
    IS 'Status in active of the application action type as active (a) or inactive (i).';
	
COMMENT ON COLUMN application.application_action_type.description
    IS 'Description of the application action type.';
-- Index: application_action_type_on_status_to_set
CREATE INDEX IF NOT EXISTS application_action_type_on_status_to_set
    ON application.application_action_type USING btree
    (status_to_set COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
	
-- Table: application.application
CREATE TABLE IF NOT EXISTS application.application
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    app_nr character varying(20) COLLATE pg_catalog."default" NOT NULL,
	agent_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
	contact_person_id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
	lodging_datetime timestamp without time zone NOT NULL DEFAULT now(),
	expected_completion_date timestamp without time zone NOT NULL DEFAULT now(),	    
    assignee_id character varying(40) COLLATE pg_catalog."default",
    assigned_datetime timestamp without time zone,
    services_fee numeric(20,2) NOT NULL DEFAULT 0,
    tax numeric(20,2) NOT NULL DEFAULT 0,
	total_fee numeric(20,2) NOT NULL DEFAULT 0,
    total_amount_paid numeric(20,2) NOT NULL DEFAULT 0,
    fee_paid boolean NOT NULL DEFAULT false,
	receipt_reference character varying(100) COLLATE pg_catalog."default",	
    action_code character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'lodge'::character varying,
    status_code character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'lodged'::character varying,
	action_notes character varying(255) COLLATE pg_catalog."default",        
	rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
	change_user character varying(50) COLLATE pg_catalog."default",	
    change_time timestamp without time zone NOT NULL DEFAULT now(),    
    CONSTRAINT application_pkey PRIMARY KEY (id),
    CONSTRAINT application_action_code_fkey FOREIGN KEY (action_code)
        REFERENCES application.application_action_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT application_agent_id_fkey FOREIGN KEY (agent_id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT application_contact_person_id_fkey FOREIGN KEY (contact_person_id)
        REFERENCES administrative.party (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT application_status_code_fkey FOREIGN KEY (status_code)
        REFERENCES application.application_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.application
    OWNER to postgres;

COMMENT ON TABLE application.application
    IS 'Application or Plan, to capture details and manage requests received by the valuation office for a plan.';

COMMENT ON COLUMN application.application.id
    IS 'Identifier for the application.';

COMMENT ON COLUMN application.application.app_nr
    IS 'The application number displayed to end users.';
	
COMMENT ON COLUMN application.application.agent_id
    IS 'Identifier of the party (individual or organization) that is requesting a plan';

COMMENT ON COLUMN application.application.contact_person_id
    IS 'The person to contact in regard to the application of plan';

COMMENT ON COLUMN application.application.lodging_datetime
    IS 'The lodging date and time of the application. This date identifies when the application is officially accepted by the valuation office';

COMMENT ON COLUMN application.application.expected_completion_date
    IS 'The date the application should be completed by. This value is determined from expected completion date associated with the application.';
	
COMMENT ON COLUMN application.application.assignee_id
    IS 'The identifier of the user (it can be an assessor for appraisal services or may be a team leader for survey services who can assign a specific property of a big plan to team members for survey operations) assigned to the application. If this value is null, then the application is unassigned.';

COMMENT ON COLUMN application.application.assigned_datetime
    IS 'The date and time the application was last assigned to a user';

COMMENT ON COLUMN application.application.services_fee
    IS 'The sum of all service fees.';

COMMENT ON COLUMN application.application.tax
    IS 'The tax applicable based on the services fee.';

COMMENT ON COLUMN application.application.total_fee
    IS 'The sum of the services fee and tax.';
	
COMMENT ON COLUMN application.application.total_amount_paid
    IS 'The amount paid by the applicant. Usually will be the full amount (total_fee), but can be a partial payment if the valuation office accepts partial payments.';

COMMENT ON COLUMN application.application.fee_paid
    IS 'Flag to indicate a sufficient amount (or all) of the fee has been paid. Once set, the application can be assigned and worked on.';
	
COMMENT ON COLUMN application.application.receipt_reference
    IS 'The number of the receipt issued as proof of payment. If more than one receipt is issued in the case of part payments, the receipts numbers can be listed in this feild separated by commas.';

COMMENT ON COLUMN application.application.action_code
    IS 'The last action that happended to the application. E.g. lodged, assigned, validated, approved, etc.';

COMMENT ON COLUMN application.application.action_notes
    IS 'Optional description of the action';
	
COMMENT ON COLUMN application.application.status_code
    IS 'The status of the application.';
	
COMMENT ON COLUMN application.application.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN application.application.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';	

COMMENT ON COLUMN application.application.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN application.application.change_user
    IS 'The user id of the last person to modify the row.';	
	
COMMENT ON COLUMN application.application.change_time
    IS 'The date and time the row was last modified.';

-- Table: application.request_category_type
CREATE TABLE IF NOT EXISTS application.request_category_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT request_category_type_pkey PRIMARY KEY (code),
    CONSTRAINT request_category_type_display_value_key UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.request_category_type
    OWNER to postgres;

COMMENT ON TABLE application.request_category_type
    IS 'Code list of request category types. Request category is used to group the different types of provided service request such as appraisal services, survey services, supporting services.';

COMMENT ON COLUMN application.request_category_type.code
    IS 'The code for the request category type.';

COMMENT ON COLUMN application.request_category_type.description
    IS 'Description of the request category type.';

COMMENT ON COLUMN application.request_category_type.display_value
    IS 'Displayed value of the request category type.';

COMMENT ON COLUMN application.request_category_type.status
    IS 'Status in active of the request category type as active (a) or inactive (i).';
    
-- Table: application.request_type
CREATE TABLE IF NOT EXISTS application.request_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    request_category_code character varying(20) COLLATE pg_catalog."default",    
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    nr_days_to_complete integer NOT NULL DEFAULT 0,    
    base_fee numeric(20,2) NOT NULL DEFAULT 0,    
    area_base_fee numeric(20,2) NOT NULL DEFAULT 0,
    value_base_fee numeric(20,2) NOT NULL DEFAULT 0,
    CONSTRAINT request_type_pkey PRIMARY KEY (code),
    CONSTRAINT request_type_display_value_key UNIQUE (display_value),
    CONSTRAINT request_type_request_category_code_fkey FOREIGN KEY (request_category_code)
        REFERENCES application.request_category_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.request_type
    OWNER to postgres;

COMMENT ON TABLE application.request_type
    IS 'Code list of request types. Request types identify the different types of services provided.';

COMMENT ON COLUMN application.request_type.code
    IS 'The code for the request type.';

COMMENT ON COLUMN application.request_type.area_base_fee
    IS 'The fee component charged for each square metre of the property or 0 if no area fee applies.';

COMMENT ON COLUMN application.request_type.base_fee
    IS 'The fixed fee component charged for the service or 0 if there is no fixed fee.';

COMMENT ON COLUMN application.request_type.description
    IS 'Description of the request type.';

COMMENT ON COLUMN application.request_type.display_value
    IS 'Displayed value of the request type.';

COMMENT ON COLUMN application.request_type.nr_days_to_complete
    IS 'The number of days it should take for the service to be completed.';

COMMENT ON COLUMN application.request_type.status
    IS 'Status in active of the request type as active (a) or inactive (i).';

COMMENT ON COLUMN application.request_type.value_base_fee
    IS 'The fee component charged against the value of the property or 0 if no value fee applies.';

COMMENT ON COLUMN application.request_type.request_category_code
    IS 'The code for the request category type.';
    
-- Table: application.service_status_type
CREATE TABLE IF NOT EXISTS application.service_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
    CONSTRAINT service_status_type_pkey PRIMARY KEY (code),
    CONSTRAINT service_status_type_display_value_key UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.service_status_type
    OWNER to postgres;

COMMENT ON TABLE application.service_status_type
    IS 'Code list of service status types.';

COMMENT ON COLUMN application.service_status_type.code
    IS 'The code for the service status type.';

COMMENT ON COLUMN application.service_status_type.description
    IS 'Description of the service status type.';

COMMENT ON COLUMN application.service_status_type.display_value
    IS 'Displayed value of the service status type.';

COMMENT ON COLUMN application.service_status_type.status
    IS 'Status of the service status type as active (a) or inactive (i).';
    
-- Table: application.service_action_type
CREATE TABLE IF NOT EXISTS application.service_action_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    status_to_set character varying(20) COLLATE pg_catalog."default",
    description character varying(1000) COLLATE pg_catalog."default",
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,    
    CONSTRAINT service_action_type_pkey PRIMARY KEY (code),
    CONSTRAINT service_action_type_display_value_key UNIQUE (display_value),
    CONSTRAINT service_action_type_status_to_set_fkey FOREIGN KEY (status_to_set)
        REFERENCES application.service_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.service_action_type
    OWNER to postgres;

COMMENT ON TABLE application.service_action_type
    IS 'Code list of service action types. Service actions identify the actions user can perform against services. E.g. lodge, start, revert, cancel, complete.';

COMMENT ON COLUMN application.service_action_type.code
    IS 'The code for the service action type.';

COMMENT ON COLUMN application.service_action_type.description
    IS 'Description of the service action type.';

COMMENT ON COLUMN application.service_action_type.display_value
    IS 'Displayed value of the service action type.';

COMMENT ON COLUMN application.service_action_type.status
    IS 'Status of the service action type as active (a) or inactive (i).';

COMMENT ON COLUMN application.service_action_type.status_to_set
    IS 'The status to set on the service when the service action is applied.';
    
-- Table: application.service
CREATE TABLE IF NOT EXISTS application.service
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    application_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    request_type_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    service_order integer NOT NULL DEFAULT 0,
    lodging_datetime timestamp without time zone NOT NULL DEFAULT now(),
    nr_days_to_complete integer NOT NULL DEFAULT 10,
    action_code character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'lodge'::character varying,
    status_code character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'lodged'::character varying,    
    action_notes character varying(255) COLLATE pg_catalog."default",
    base_fee numeric(20,2) NOT NULL DEFAULT 0,    
    area_fee numeric(20,2) NOT NULL DEFAULT 0,
    value_fee numeric(20,2) NOT NULL DEFAULT 0,
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,    
    change_user character varying(50) COLLATE pg_catalog."default",
	change_time timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT service_pkey PRIMARY KEY (id),
    CONSTRAINT service_action_code_fkey FOREIGN KEY (action_code)
        REFERENCES application.service_action_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT service_application_id_fkey FOREIGN KEY (application_id)
        REFERENCES application.application (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT service_request_type_code_fkey FOREIGN KEY (request_type_code)
        REFERENCES application.request_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT service_status_code_fkey FOREIGN KEY (status_code)
        REFERENCES application.service_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.service
    OWNER to postgres;

COMMENT ON TABLE application.service
    IS 'Used to control the type of plan application as mass appraisals or single or individual appraisals.';

COMMENT ON COLUMN application.service.id
    IS 'Identifier for the service.';

COMMENT ON COLUMN application.service.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN application.service.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN application.service.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN application.service.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN application.service.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN application.service.action_code
    IS 'Service action code. Indicates the last action to occur on the service. E.g. lodge, start, complete, cancel, etc.';

COMMENT ON COLUMN application.service.action_notes
    IS 'Optional description of the action';

COMMENT ON COLUMN application.service.area_fee
    IS 'The area fee charged for the service. Calculated from the sum of all areas listed for properties on the application multiplied by the request_type.area_base_fee.';

COMMENT ON COLUMN application.service.base_fee
    IS 'The fixed fee charged for the service. Obtained from the base_fee value in request_type.';

COMMENT ON COLUMN application.service.lodging_datetime
    IS 'The date the service was lodged on the application. Typically will match the application lodgement_datetime, but may vary if a service is added after the application is lodged.';

COMMENT ON COLUMN application.service.nr_days_to_complete
    IS 'The number of days it should take for the service to be completed.';

COMMENT ON COLUMN application.service.service_order
    IS 'The relative order of the service within the application. Can be used to imply a workflow sequence for application related tasks.';

COMMENT ON COLUMN application.service.status_code
    IS 'Service status code.';

COMMENT ON COLUMN application.service.value_fee
    IS 'The value fee charged for the service. Calculated from the sum of all values listed for properties on the application multiplied by the request_type.value_base_fee.';

COMMENT ON COLUMN application.service.application_id
    IS 'Identifier for the application the service is associated with.';

COMMENT ON COLUMN application.service.request_type_code
    IS 'The request type identifying the purpose of the service.';

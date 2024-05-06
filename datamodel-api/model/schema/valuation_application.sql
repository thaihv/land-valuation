-- Table: application.application_status_type
CREATE TABLE IF NOT EXISTS application.application_status_type
(
    code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    status character(1) COLLATE pg_catalog."default" DEFAULT 'i'::bpchar,
	description character varying(1000) COLLATE pg_catalog."default",
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
	agent_id character varying(40) COLLATE pg_catalog."default",
	contact_person_id character varying(40) COLLATE pg_catalog."default" NOT NULL,
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
	action_notes character varying(255) COLLATE pg_catalog."default",
    status_code character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'lodge'::character varying,
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
    CONSTRAINT application_status_code_fkey FOREIGN KEY (status_code)
        REFERENCES application.application_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.application
    OWNER to postgres;

COMMENT ON TABLE application.application
    IS 'Capture details and manage requests received by the valuation office for a plan.';

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
    IS 'The identifier of the user (assessor) assigned to the application. If this value is null, then the application is unassigned.';

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
-- Index: application_on_rowidentifier
CREATE INDEX IF NOT EXISTS application_on_rowidentifier
    ON application.application USING btree
    (rowidentifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;	
	
	
-- Table: transaction.transaction_status_type
CREATE TABLE IF NOT EXISTS transaction.transaction_status_type
(
    code character varying(40) COLLATE pg_catalog."default" NOT NULL,
    display_value character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1000) COLLATE pg_catalog."default",    
    status character(1) COLLATE pg_catalog."default" DEFAULT 'a'::bpchar,
    CONSTRAINT transaction_status_type_pkey PRIMARY KEY (code),
    CONSTRAINT transaction_status_type_display_value UNIQUE (display_value)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS transaction.transaction_status_type
    OWNER to postgres;

COMMENT ON TABLE transaction.transaction_status_type
    IS 'Code list of transaction status types. E.g. pending, approved, cancelled, completed.';

COMMENT ON COLUMN transaction.transaction_status_type.code
    IS 'Code of the transaction status type.';

COMMENT ON COLUMN transaction.transaction_status_type.description
    IS 'Description of the transaction status type.';

COMMENT ON COLUMN transaction.transaction_status_type.display_value
    IS 'Displayed value of the transaction status type.';

COMMENT ON COLUMN transaction.transaction_status_type.status
    IS 'Status in active of the transaction status type as active (a) or inactive (i).';
    
-- Table: transaction.transaction
CREATE TABLE IF NOT EXISTS transaction.transaction
(
    id character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    from_service_id character varying(40) COLLATE pg_catalog."default" DEFAULT uuid_generate_v1(),
    status_code character varying(40) COLLATE pg_catalog."default",
    approval_datetime timestamp without time zone,
    is_massive_operation boolean NOT NULL DEFAULT false,    
    change_action character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'i'::bpchar,
    change_user character varying(50) COLLATE pg_catalog."default",
    change_time timestamp without time zone NOT NULL DEFAULT now(),
    rowidentifier character varying(40) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v1(),
    rowversion integer NOT NULL DEFAULT 0,
    CONSTRAINT transaction_pkey PRIMARY KEY (id),
    CONSTRAINT transaction_from_service_id_fkey FOREIGN KEY (from_service_id)
        REFERENCES application.service (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transaction_status_code_fkey FOREIGN KEY (status_code)
        REFERENCES transaction.transaction_status_type (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS transaction.transaction
    OWNER to postgres;

COMMENT ON TABLE transaction.transaction
    IS 'Each service initiates a transaction that is then recorded against any data edits made by the user. When the service is complete and the application approved, the data associated with the transction can be approved and updated as well.If the user chooses to reject their changes prior to approval, the transaction can be used to determine which data edits need to be removed from the system without affecting the currently data.';

COMMENT ON COLUMN transaction.transaction.change_action
    IS 'Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).';

COMMENT ON COLUMN transaction.transaction.change_time
    IS 'The date and time the row was last modified.';

COMMENT ON COLUMN transaction.transaction.change_user
    IS 'The user id of the last person to modify the row.';

COMMENT ON COLUMN transaction.transaction.rowidentifier
    IS 'Identifies the all change records for the row in the table.';

COMMENT ON COLUMN transaction.transaction.rowversion
    IS 'Sequential value indicating the number of times this row has been modified.';

COMMENT ON COLUMN transaction.transaction.approval_datetime
    IS 'The date and time the transaction is approved.';

COMMENT ON COLUMN transaction.transaction.is_massive_operation
    IS 'Flag used to indicate the transaction was created in support of a bulk operation.';

COMMENT ON COLUMN transaction.transaction.from_service_id
    IS 'The identifier of the service that initiated the transaction. NULL if the transaction has been created using other means. E.g. for migration or SETL, or plan of center goverment mass appraisals.';

COMMENT ON COLUMN transaction.transaction.status_code
    IS 'The status of the transaction.';
    
    
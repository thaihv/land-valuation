package com.jdvn.devtech.datamodel.schema.application;

import java.util.Date;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "service", schema = "application", indexes = {
		@Index(name = "service_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "service_request_type_code_fkey_ind", columnList = "request_type_code"),
		@Index(name = "service_action_code_fkey_ind", columnList = "action_code"),
		@Index(name = "service_status_code_fkey_ind", columnList = "status_code")})
@Comment("Used to control the type of plan application as mass appraisals or single or individual appraisals.")
public class Service extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the service.")
	private String id;
	
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "application_id", foreignKey = @ForeignKey(name = "service_application_id_fkey"))
	@Comment("Identifier for the application the service is associated with.")
    private Application application;
    
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "request_type_code", foreignKey = @ForeignKey(name = "service_request_type_code_fkey"), columnDefinition="character varying(20) NOT NULL")
	@Comment("The request type identifying the purpose of the service.")
    private RequestType request_type;
    
    @Column(columnDefinition = "integer NOT NULL DEFAULT 0")
	@Comment("The relative order of the service within the application. Can be used to imply a workflow sequence for application related tasks.")
	private int service_order;
	
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The date the service was lodged on the application. Typically will match the application lodgement_datetime, but may vary if a service is added after the application is lodged.")
	private Date lodging_datetime;
	
	@Column(columnDefinition = "integer NOT NULL DEFAULT 10")
	@Comment("The number of days it should take for the service to be completed.")
	private int nr_days_to_complete;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "action_code", foreignKey = @ForeignKey(name = "service_action_code_fkey"), columnDefinition="character varying(20) NOT NULL DEFAULT 'lodge'::character varying")
	@Comment("Service action code. Indicates the last action to occur on the service. E.g. lodge, start, complete, cancel, etc.")
	private ServiceActionType service_action_type;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "status_code", foreignKey = @ForeignKey(name = "service_status_code_fkey"), columnDefinition="character varying(20) NOT NULL DEFAULT 'lodged'::character varying")
	@Comment("Service status code.")
	private ServiceStatusType service_status_type;
	
    @Column(length = 255)
	@Comment("Optional description of the action")
	private String action_notes;
	
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The fixed fee charged for the service.")
    private Double base_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The area fee charged for the service. Calculated from the sum of all areas listed for properties on the application.")
    private Double area_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The value fee charged for the service. Calculated from the sum of all values listed for properties on the application.")
    private Double value_fee;
    
	@Override
	public String print() {
		return id;
	}
}
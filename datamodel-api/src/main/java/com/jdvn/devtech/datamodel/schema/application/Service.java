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
		@Index(name = "service_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Used to control the type of plan application as mass appraisals or single appraisals.")
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
    

	@Comment("The request type identifying the purpose of the service")
	private String request_type_code;
	
	@Comment("The relative order of the service within the application. Can be used to imply a workflow sequence for application related tasks.")
	private String service_order;
	
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The date the service was lodged on the application. Typically will match the application lodgement_datetime, but may vary if a service is added after the application is lodged.")
	private Date lodging_datetime;
	
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("Date when the service is expected to be completed by. Calculated using the service lodging_datetime and the number_days_to_complete for the service request type.")
	private Date expected_completion_date;
    
	@Comment("Service status code.")
	private String status_code;
	
	@Comment("Service action code. Indicates the last action to occur on the service. E.g. lodge, start, complete, cancel, etc.")
	private String action_code;
	
    @Column(length = 255)
	@Comment("Optional description of the action")
	private String action_notes;
	
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The fixed fee charged for the service. Obtained from the base_fee value in request_type.")
    private Double base_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The area fee charged for the service. Calculated from the sum of all areas listed for properties on the application multiplied by the request_type.area_base_fee.")
    private Double area_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The value fee charged for the service. Calculated from the sum of all values listed for properties on the application multiplied by the request_type.value_base_fee.")
    private Double value_fee;
    
	@Override
	public String print() {
		return id;
	}
}
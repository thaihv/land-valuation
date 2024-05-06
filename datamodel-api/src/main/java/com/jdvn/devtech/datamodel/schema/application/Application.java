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
@Table(name = "application", schema = "application", indexes = {
		@Index(name = "application_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Capture details and manage requests received by the valuation office for a plan.")
public class Application extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the application.")
	private String id;

	@Column(length = 20, nullable = false)
	@Comment("The application number displayed to end users.")
	private String app_nr;

	@Column(length = 40)
	@Comment("Identifier of the party (individual or organization) that is requesting a plan")
	private String agent_id;
	
	@Comment("The person to contact in regard to the application of plan")
	@Column(length = 40, nullable = false)
	private String contact_person_id;
	
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The lodging date and time of the application. This date identifies when the application is officially accepted by the valuation office")
	private Date lodging_datetime;
	
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The date the application should be completed by. This value is determined from expected completion date associated with the application.")
	private Date expected_completion_date;
    
	@Column(length = 40)
	@Comment("The identifier of the user (assessor) assigned to the application. If this value is null, then the application is unassigned.")
	private String assignee_id;
	
	@Column(columnDefinition = "timestamp without time zone")
	@Comment("The date and time the application was last assigned to a user")
	private Date assigned_datetime;
	
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "action_code", foreignKey = @ForeignKey(name = "application_action_code_fkey"))
	@Comment("The last action that happended to the application. E.g. lodged, assigned, validated, approved, etc.")
    private ApplicationActionType application_action_type;
    
    @Column(length = 255)
	@Comment("Optional description of the action")
	private String action_notes;
	
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "status_code", foreignKey = @ForeignKey(name = "application_status_code_fkey"))
	@Comment("The status of the application.")
    private ApplicationStatusType application_status_type;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The sum of all service fees.")
    private Double services_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The tax applicable based on the services fee.")
    private Double tax;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The sum of the services fee and tax.")
    private Double total_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The amount paid by the applicant. Usually will be the full amount (total_fee), but can be a partial payment if the valuation office accepts partial payments.")
    private Double total_amount_paid;
    
    @Column(columnDefinition = "boolean NOT NULL DEFAULT false")
    @Comment("Flag to indicate a sufficient amount (or all) of the fee has been paid. Once set, the application can be assigned and worked on.")
    private Boolean fee_paid;
    
    @Column(length = 100)
    @Comment("The number of the receipt issued as proof of payment. If more than one receipt is issued in the case of part payments, the receipts numbers can be listed in this feild separated by commas.")
    private String receipt_reference;
    
	@Override
	public String print() {
		return id;
	}
}
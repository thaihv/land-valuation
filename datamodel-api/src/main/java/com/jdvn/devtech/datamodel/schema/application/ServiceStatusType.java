package com.jdvn.devtech.datamodel.schema.application;

import java.util.Set;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "service_status_type", schema = "application", uniqueConstraints = { 
		@UniqueConstraint(name = "service_status_type_display_value_key", columnNames = { "display_value" })})
@Comment("Code list of service status types.")
public class ServiceStatusType {
	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the service status type.")
	private String code;

	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the service status type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the service status type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status of the service status type as active (a) or inactive (i).")
	private char status;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "service_status_type")
    @JsonBackReference
    private Set<ServiceActionType> service_action_types;
    
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "service_status_type")
    @JsonBackReference
    private Set<Service> services;
}
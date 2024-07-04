package com.jdvn.devtech.datamodel.schema.application;

import java.util.Set;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
@Table(name = "service_action_type", schema = "application", uniqueConstraints = {
		@UniqueConstraint(name = "service_action_type_display_value_key", columnNames = {
				"display_value" }) }, indexes = {
						@Index(name = "service_action_type_status_to_set_fkey_ind", columnList = "status_to_set") })
@Comment("Code list of service action types. Service actions identify the actions user can perform against services. E.g. lodge, start, revert, cancel, complete.")
public class ServiceActionType {
	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the service action type.")
	private String code;

	@Column(length = 500, nullable = false, unique = true)
	@Comment("Displayed value of the service action type.")
	private String display_value;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonManagedReference
	@JoinColumn(name = "status_to_set", foreignKey = @ForeignKey(name = "service_action_type_status_to_set_fkey"))
	@Comment("The status to set on the service when the service action is applied.")
	private ServiceStatusType service_status_type;

	@Column(length = 1000)
	@Comment("Description of the service action type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status of the service action type as active (a) or inactive (i).")
	private char status;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "service_action_type")
	@JsonBackReference
	private Set<Service> services;

}
package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

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
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "application_action_type", schema = "application", uniqueConstraints = { @UniqueConstraint(name = "application_action_type_display_value_key", columnNames = { "display_value" })}, 
indexes = {@Index(name = "application_action_type_on_status_to_set", columnList = "status_to_set")})
@Comment("Code list of action types.")
public class Application_action_type {
	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the application action type.")
	private String code;

	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the application action type.")
	private String display_value;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "status_to_set", foreignKey = @ForeignKey(name = "application_action_type_status_to_set_fkey"))
	@Comment("To explain in which of the application status type. Is NULL if not be specific.")
    private Application_status_type application_status_type;
			
	@Column(length = 1000)
	@Comment("Description of the application action type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the application action type as active (a) or inactive (i).")
	private char status;
}
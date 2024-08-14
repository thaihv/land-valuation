package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "notify_relationship_type", schema = "application", uniqueConstraints = { @UniqueConstraint(name = "notify_relationship_type_display_value_key", columnNames = { "display_value" }) })
@Comment("Code list identifying the type of relationship a party has affected by a service.")
public class NotifyRelationshipType{

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the relationship type.")
	private String code;
	
	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the relationship type.")
	private String display_value;
	
	@Column(length = 1000)
	@Comment("Description of the relationship type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the relationship type as active (a) or inactive (i).")
	private char status;

}
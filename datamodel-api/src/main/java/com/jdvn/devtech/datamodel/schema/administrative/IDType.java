package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "id_type", schema = "administrative", uniqueConstraints = { @UniqueConstraint(name = "id_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of id types. Used to identify the types of id that can be used to verify the identity of an individual, group or organisation. E.g. nationalId, nationalPassport, driverLicense, etc.")
public class IDType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the id type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the id type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the id type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the id type as active (a) or inactive (i).")
	private char status;
	
	@OneToOne(mappedBy = "id_type")
	private Party party;
}
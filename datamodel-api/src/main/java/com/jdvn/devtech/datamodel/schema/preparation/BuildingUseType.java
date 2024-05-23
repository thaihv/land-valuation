package com.jdvn.devtech.datamodel.schema.preparation;

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
@Table(name = "building_use_type", schema = "preparation", uniqueConstraints = { @UniqueConstraint(name = "building_use_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of types of building use, i.e., residential, office and industrial")
public class BuildingUseType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the building use type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the building use type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the building use type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the building use as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "building_use_type")
	private Building building;
}
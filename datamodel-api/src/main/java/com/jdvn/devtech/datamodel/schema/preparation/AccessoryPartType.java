package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "accessory_part_type", schema = "preparation", uniqueConstraints = { @UniqueConstraint(name = "accessory_part_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of accessory part types.")
public class AccessoryPartType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the accessory part type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the accessory part type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the accessory part type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the accessory part type as active (a) or inactive (i).")
	private char status;

}
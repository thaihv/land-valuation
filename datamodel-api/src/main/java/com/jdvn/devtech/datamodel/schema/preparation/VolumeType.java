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
@Table(name = "volume_type", schema = "preparation", uniqueConstraints = { @UniqueConstraint(name = "volume_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of volume types. Identifies the types of volume (calculated, official, survey defined, etc) that can be recorded for a property.")
public class VolumeType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the volume type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the volume type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the volume type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the volume type as active (a) or inactive (i).")
	private char status;

}
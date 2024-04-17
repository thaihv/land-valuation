package com.jdvn.devtech.datamodel.schema.source;

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
@Table(name = "presentation_form_type", schema = "source", uniqueConstraints = { @UniqueConstraint(name = "presentation_form_type_display_value_key", columnNames = { "display_value" })})
@Comment("Code list indicates the original format of the document when presented to the valuation process (e.g. Hardcopy, digital, image, video, etc)")
public class PresentationFormType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the presentation form type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the presentation form type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the presentation form type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the presentation form type as current (c) or noncurrent (x).")
	private char status;
}
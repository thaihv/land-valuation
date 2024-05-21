package com.jdvn.devtech.datamodel.schema.valuation;

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
@Table(name = "appeal_status_type", schema = "valuation", uniqueConstraints = { @UniqueConstraint(name = "appeal_status_type_display_value", columnNames = { "display_value" })})
@Comment("List of the appeal status types in a valuaton process")
public class AppealStatusType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the appeal status type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the appeal status type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the appeal status type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the appeal status type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "appeal_status")
	private Valuation valuation;
	
}
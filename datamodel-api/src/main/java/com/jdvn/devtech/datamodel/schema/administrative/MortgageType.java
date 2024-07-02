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
@Table(name = "mortgage_type", schema = "administrative", uniqueConstraints = { @UniqueConstraint(name = "mortgage_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of Mortgage types. E.g. levelPayment, linear, etc.")
public class MortgageType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the mortgage type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the mortgage type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the mortgage type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the mortgage type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "mortgage_type")
	private RRR rrr;
}
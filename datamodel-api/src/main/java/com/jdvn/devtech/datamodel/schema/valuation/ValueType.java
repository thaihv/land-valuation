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
@Table(name = "value_type", schema = "valuation", uniqueConstraints = { @UniqueConstraint(name = "value_type_display_value_key", columnNames = { "display_value" })})
@Comment("Code list of value types used for valuation process.")
public class ValueType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the value type.")
	private String code;

	/* Demo for more an unique column beside primary key */	
	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the value type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the value type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the value type as active (a) or inactive (i).")
	private char status;
	
	@OneToOne(mappedBy = "value_type")
	private Valuation valuation;
	
}
package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "value_type", schema = "preparation")
@Comment("Code list of value types for envaluating")
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
}
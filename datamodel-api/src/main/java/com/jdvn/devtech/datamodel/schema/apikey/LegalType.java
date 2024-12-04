package com.jdvn.devtech.datamodel.schema.apikey;
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
@Table(name = "legal_types", schema = "apikey", uniqueConstraints = { @UniqueConstraint(name = "legal_types_display_value_key", columnNames = { "display_value" })})
@Comment("A code list of type legal identity supported")
public class LegalType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the legal_type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the legal_type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the legal_type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the legal_type as current (c) or noncurrent (x).")
	private char status;
	

}
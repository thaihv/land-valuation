package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "request_category_type", schema = "application", uniqueConstraints = {
		@UniqueConstraint(name = "request_category_type_display_value_key", columnNames = { "display_value" }) })
@Comment("Code list of request category types. Request category is used to group the different types of provided service request such as appraisal services, survey services, supporting services.")
public class RequestCategoryType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the request category type.")
	private String code;

	@Column(length = 500, nullable = false, unique = true)
	@Comment("Displayed value of the request category type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the request category type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the request category type as active (a) or inactive (i).")
	private char status;

}
package com.jdvn.devtech.datamodel.schema.regression;

import java.util.Date;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "models", schema = "regression", indexes = {
		@Index(name = "models_index_on_id", columnList = "id") })
@Comment("Used to store information about regresion model. It includes attributes such as name, year, purpose, created date to trace a source of implementation")
public class Model {

	@Id
	@Comment("Identifier of the model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 128, nullable = false)
	@Comment("Display name of the regression model.")
	private String model_name;

	@Column(length = 64, nullable = false)
	@Comment("The dependent variable (the variable being predicted, e.g Price).")
	private String dependent_var;

	@Column(columnDefinition = "character varying(16) DEFAULT 'bidirectional'")
	@Comment("Method used for stepwise regression (e.g., forward, backward, bidirectional).")
	private String stepwise_method;

	@Comment("The year of being in use for model.")
	private int year;

	@Column(columnDefinition = "character varying(64) DEFAULT 'tax'")
	@Comment("Purpose of the regression (e.g. tax, forecast, historical).")
	private String purpose;

	@Comment("The date that model is made for regression.")
	private Date created_at;
}
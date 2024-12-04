package com.jdvn.devtech.datamodel.schema.regression;

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
		@Index(name = "models_index_on_model_id", columnList = "id") })
@Comment("Used to store information about regresion model. It includes attributes such as name, year, purpose, create date to trace a source of implementation")
public class Model {

	@Id
	@Comment("Identifier of the model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 128, nullable = false)
	@Comment("Display name of the regression model.")
	private String model_name;


}
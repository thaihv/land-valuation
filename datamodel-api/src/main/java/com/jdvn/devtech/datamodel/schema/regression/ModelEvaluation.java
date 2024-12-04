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
@Table(name = "model_evaluations", schema = "regression", indexes = {
		@Index(name = "model_evaluations_index_on_id", columnList = "id") })
@Comment("Used to store the evaluation metrics for each model")
public class ModelEvaluation {

	@Id
	@Comment("Identifier of the model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of Coefficient of Determination.")
	private Double r_squared;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of Adjusted Coefficient of Determination.")
	private Double adjusted_r_squared;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of Root Mean Square Error.")
	private Double rmse;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of Mean Absolute Error.")
	private Double mae;
}
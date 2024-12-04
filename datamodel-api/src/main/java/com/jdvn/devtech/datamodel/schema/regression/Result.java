package com.jdvn.devtech.datamodel.schema.regression;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "results", schema = "regression", indexes = {
		@Index(name = "results_index_on_id", columnList = "id") })
@Comment("Used to store the actual values for the dependent variables or predicted variables output of the regression model.")
public class Result {

	@Id
	@Comment("Identifier of the coefficient.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "model_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "results_model_id_fkey"))
	@Comment("Model identifier of the result.")
	private Model model;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "data_point_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "results_data_point_id_fkey"))
	@Comment("Data point identifier of the result.")
	private DataPoint dataPoint;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment(" Predicted value for the data point.")
	private Double predicted_value;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Actual calculated value for the data point.")
	private Double actual_value;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Difference between actual and predicted value.")
	private Double residual;
}
package com.jdvn.devtech.datamodel.schema.regression;

import java.util.Date;

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
@Table(name = "metrics", schema = "regression", indexes = {
		@Index(name = "metrics_index_on_id", columnList = "id") })
@Comment("Used to store the performance metrics (R², Adjusted R², AIC, BIC, etc.) for each feature and its coefficient.")
public class Metric {

	@Id
	@Comment("Identifier of the feature.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "model_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "metrics_model_id_fkey"))
	@Comment("Metric identifier of the model.")
	private Model model;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "feature_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "metrics_feature_id_fkey"))
	@Comment("Metric identifier of the feature.")
	private Feature feature;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "coefficient_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "metrics_coefficient_id_fkey"))
	@Comment("Metric identifier of the coefficient.")
	private Coefficient coefficient;
	
	@Column(length = 16, nullable = false)
	@Comment("Name of the metric (e.g., t-value, p-value, std-error, VIF)")
	private String metric_name;

	@Column(length = 64, nullable = false)
	@Comment("Value of the metric.")
	private String metric_value;

	@Comment("The date that metric is made.")
	private Date created_at;

}
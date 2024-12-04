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
@Table(name = "coefficients", schema = "regression", indexes = {
		@Index(name = "coefficients_index_on_id", columnList = "id") })
@Comment("Used to store the coefficients of features for each model.")
public class Coefficient {

	@Id
	@Comment("Identifier of the coefficient.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "model_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "coefficients_model_id_fkey"))
	@Comment("Model identifier of the coefficient.")
	private Model model;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "feature_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "coefficients_feature_id_fkey"))
	@Comment("Identifier of feature with the coefficient.")
	private Feature feature;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of the coefficient.")
	private Double coefficient;
}
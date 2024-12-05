package com.jdvn.devtech.datamodel.schema.regression;

import java.time.LocalDateTime;

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
@Table(name = "feature_transforms", schema = "regression", indexes = {
		@Index(name = "feature_transforms_on_id", columnList = "id") })
@Comment("Used to store the transformation logic or mapping (e.g., encoding categorical values into dummies) for tracking.")
public class FeatureTransform {

	@Id
	@Comment("Identifier of the feature.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "feature_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "feature_transforms_feature_id_fkey"))
	@Comment("Transform identifier of the feature.")
	private Feature feature;

	@Column(length = 128, nullable = false)
	@Comment("Usage type of feature transformation e.g one-hot encoding, binning,  .")
	private String transformation_method;

	@Column(length = 128, nullable = false)
	@Comment("Example values for bin segment <18, 18-35, >35.")
	private String value_mapping;

	@Comment("The date that transformation is made for regression.")
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	private LocalDateTime created_at = LocalDateTime.now();
}
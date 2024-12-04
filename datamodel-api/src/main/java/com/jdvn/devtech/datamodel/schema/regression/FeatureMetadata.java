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
@Table(name = "feature_metadata", schema = "regression", indexes = {
		@Index(name = "feature_metadata_on_id", columnList = "id") })
@Comment("Used to store the metadata of feature for tracking as type of transformation (log scale, polynomial, etc.)")
public class FeatureMetadata {

	@Id
	@Comment("Identifier of the feature.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "feature_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "feature_metadata_feature_id_fkey"))
	@Comment("Transform identifier of the feature.")
	private Feature feature;

	@Column(length = 64, nullable = false)
	@Comment("Attribute metadata key of the feature.")
	private String metadata_key;

	@Column(length = 64, nullable = false)
	@Comment("Attribute metadata value of the feature.")
	private String metadata_value;

	@Comment("The date that feature is made for regression.")
	private Date created_at;

}
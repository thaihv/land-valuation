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
@Table(name = "features", schema = "regression", indexes = {
		@Index(name = "features_index_on_id", columnList = "id") })
@Comment("Used to store independent variables (including dummy variables) used in models")
public class Feature {

	@Id
	@Comment("Identifier of the feature.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "model_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "features_model_id_fkey"))
	@Comment("Model identifier of the feature.")
	private Model model;

	@Column(length = 128, nullable = false)
	@Comment("The name of the feature (before encoding for categorical and continuous variables).")
	private String feature_name;

	@Column(length = 128, nullable = false)
	@Comment("The specific value if it is a dummy variable e.g. RoadGrade_4.")
	private String encoded_value;

	@Column(columnDefinition = "character varying(16) DEFAULT 'dummy'")
	@Comment("Type of the feature (categorical, dummy, continuous).")
	private String feature_type;

	@Column(columnDefinition = "character varying(16) DEFAULT 'string'")
	@Comment("Data type of the feature e.g string, numeric, etc.")
	private String data_type;
	
	@Comment("Indicates if the feature is a dummy variable (TRUE or FALSE).")
	private boolean is_dummy;
	
	@Column(length = 128)
	@Comment("The name of the original categorical variable (for dummy features).")
	private String original_feature;
}
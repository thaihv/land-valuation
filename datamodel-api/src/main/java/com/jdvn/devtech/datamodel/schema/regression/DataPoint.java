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
@Table(name = "data_points", schema = "regression", indexes = {
		@Index(name = "data_points_index_on_id", columnList = "id") })
@Comment("Used to store the actual values for the independent variables (features) used in the regression model.")
public class DataPoint {

	@Id
	@Comment("Identifier of the data point.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Comment("Indicates if the feature is paved (TRUE or FALSE).")
	private boolean pave;
	
	@Column(length = 16)
	@Comment("The independent variable value for zonning.")
	private String zonning;
	
	@Column(length = 16)
	@Comment("The independent variable value for road grade.")
	private String rd_grade;
	
	@Column(length = 16)
	@Comment("The independent variable value for efficient ratio.")
	private String eff_ratio;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Provided as Y variable of model.")
	private Double price;
}
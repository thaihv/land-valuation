package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "sales_compare_calibration", schema = "valuation")
@Comment("Represents contents of adjustments of time, location and physical ones with estimated value for sales comparision.")
public class SalesComparisonCalibration {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The sales comparision approach identifier.")
	private String id;	
	
	@Comment("The date that sales comparision approach implemented.")
	private Date analysis_date;

	@OneToOne(mappedBy = "sales_comparison_approach")
	private SinglePropertyAppraisal single_property_appraisal;

}
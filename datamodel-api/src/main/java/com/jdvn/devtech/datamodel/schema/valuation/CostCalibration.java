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
@Table(name = "cost_calibration", schema = "valuation")
@Comment("Represents cost-related characteristics, such as cost type (e.g., replacement\r\n"
		+ "or reproduction cost), cost-related attributes, chronological and effective age of building\r\n"
		+ "and obsolescence for valuation approach of cost.")
public class CostCalibration {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The cost approach identifier.")
	private String id;	
	
	@Comment("The date that cost approach implemented.")
	private Date analysis_date;

	@OneToOne(mappedBy = "cost_approach")
	private SinglePropertyAppraisal single_property_appraisal;
}
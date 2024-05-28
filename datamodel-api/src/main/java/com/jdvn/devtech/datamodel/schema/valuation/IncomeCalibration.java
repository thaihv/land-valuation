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
@Table(name = "income_calibration", schema = "valuation")
@Comment("Represents income information, such as gross, effective and net income and operating expenses and capitalization rates characteristics for valuation approach of income.")
public class IncomeCalibration {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The income approach identifier.")
	private String id;	
	
	@Comment("The date that income approach implemented.")
	private Date analysis_date;

	@OneToOne(mappedBy = "income_approach")
	private SinglePropertyAppraisal single_property_appraisal;

}
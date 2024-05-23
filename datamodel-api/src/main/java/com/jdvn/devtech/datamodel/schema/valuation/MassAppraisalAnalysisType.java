package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "mass_appraisal_analysis_type", schema = "valuation", uniqueConstraints = { @UniqueConstraint(name = "mass_appraisal_analysis_type_display_value", columnNames = { "display_value" })})
@Comment("List of the mass appraisal analysis types used for valuaton process, such as multiple regreesion, time serial analysis.")
public class MassAppraisalAnalysisType{
	@Id
	@Column(length = 40, nullable = false)
	@Comment("Code of the mass appraisal analysis type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the mass appraisal analysis type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the mass appraisal analysis type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the mass appraisal analysis type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "analysis_type")
	private MassAppraisalPerformance mass_appraisal_performance;
	
}
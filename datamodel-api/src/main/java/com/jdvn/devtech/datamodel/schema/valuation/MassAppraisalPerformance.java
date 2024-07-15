package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
@Table(name = "mass_appraisal_performance", schema = "valuation")
@Comment("Presents performance indicator characteristics of mass appraisal implementation")
public class MassAppraisalPerformance {

	@Id
	@Comment("Mass appraisal identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column
	@Comment("The analysis date of mass appraisal implementation.")
	private Date analysis_date;
	
	@Comment("Size of mass appraisal model sample.")
	private int simple_size;
	
//	@Column(columnDefinition = "numeric(20,2)")
//	@Comment("The appraisal level for mass appraisal process implementation. The Appraisal level is an indicator that shows the overall or typical\r\n"
//			+ "ratio of the appraised values to the market values and ascertained by central tendency measures such\r\n"
//			+ "as, mean, median, weighted mean")
//	private Double appraisal_level;
//
//	@Column(columnDefinition = "numeric(20,2)")
//	@Comment("The appraisal_uniformity for mass appraisal process implementation. The Appraisal uniformity defines appraisal\r\n"
//			+ "consistency and equity between and within groups of properties. It could be expressed for instance, by\r\n"
//			+ "the coefficient of dispersion, coefficient of variation, or price-related differential measures")
//	private Double appraisal_uniformity;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "analysis_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "mass_appraisal_performance_analysis_type_code_fkey"))
	@Comment("Type of the mass appraisal analysis.")
    private MassAppraisalAnalysisType analysis_type;
	
	@OneToOne(mappedBy = "mass_appraisal_performance")
	private MassAppraisal mass_appraisal;
	
}
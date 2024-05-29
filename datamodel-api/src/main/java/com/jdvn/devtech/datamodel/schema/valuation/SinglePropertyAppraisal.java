package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
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
@Table(name = "single_appraisal", schema = "valuation")
@Comment("Provides information on single property appraisal for valuation unit")
public class SinglePropertyAppraisal {

	@Id
	@Comment("Single Appraisal identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@OneToOne
	@Comment("The identifier of cost approach, if any.")
    @JoinColumn(name = "cost_approach_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_cost_approach_id_fkey"))
    private CostCalibration cost_approach;
	
	@OneToOne
	@Comment("The identifier of income approach, if any.")
    @JoinColumn(name = "income_approach_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_income_approach_id_fkey"))
    private IncomeCalibration income_approach;
	
	@OneToOne
	@Comment("The identifier of sales comparison approach, if any.")
    @JoinColumn(name = "sales_comparison_approach_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_sales_comparison_approach_id_fkey"))
    private SalesComparisonCalibration sales_comparison_approach;
		
	@OneToOne
	@MapsId
	@JoinColumn(name = "id", foreignKey = @ForeignKey(name = "single_appraisal_id_fkey"))
	private Valuation valuation;
	
	

}
package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.transaction.Transaction;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "valuation_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_valuation_id_fkey"))
	private Valuation valuation;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@Comment("The identifier of cost approach, if any.")
	@JoinColumn(name = "cost_approach_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_cost_approach_id_fkey"))
	private CostMethod cost_approach;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@Comment("The identifier of income approach, if any.")
	@JoinColumn(name = "income_approach_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_income_approach_id_fkey"))
	private IncomeMethod income_approach;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@Comment("The identifier of sales comparison approach, if any.")
	@JoinColumn(name = "sales_comparison_approach_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_sales_comparison_approach_id_fkey"))
	private SalesComparisonMethod sales_comparison_approach;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "transaction_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "single_appraisal_transaction_id_fkey"))
	@Comment("Identifier to a transaction for assessment.")
    private Transaction transaction;

}
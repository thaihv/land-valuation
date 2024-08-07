package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.preparation.ValuationFormula;

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
@Table(name = "income_method", schema = "valuation")
@Comment("Represents income information, such as gross, effective and net income and operating expenses and capitalization rates characteristics for valuation approach of income.")
public class IncomeMethod {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The income approach identifier.")
	private String id;	
	
	@Comment("The date that income approach implemented.")
	private Date implemented_date;
	
	@Comment("The net income value(in currency) in implementation.")
	private Double netIncome;

	@Comment("The potential gross income value(in currency) in implementation.")
	private Double potential_gross_income;
	
	@Comment("The effective gross income value(in currency) in implementation.")
	private Double effective_gross_income;
	
	@Comment("The operating_expenses (in currency) in implementation.")
	private Double operating_expenses;
	
	@Comment("The capitalization rate in implementation.")
	private Double capitalization_rate;
	
	@Comment("The gross income multiplier used in calculated.")
	private Double gross_income_multiplier;
	
	@Comment("The discount rate in implementation.")
	private Double discount_rate;
						
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value estimated from income implementation.")
	private Double estimate_value;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "use_formula_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "income_method_use_formula_id_fkey"))
	@Comment("Identifier of the formula implementation.")
	private ValuationFormula valuation_formula;

}
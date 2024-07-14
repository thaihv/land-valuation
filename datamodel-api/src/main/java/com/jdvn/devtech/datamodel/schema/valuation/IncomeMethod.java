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
	
	@OneToOne(mappedBy = "income_approach")
	private SinglePropertyAppraisal single_property_appraisal;

}
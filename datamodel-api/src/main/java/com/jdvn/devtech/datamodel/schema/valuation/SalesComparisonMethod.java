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
@Table(name = "sales_comparison_method", schema = "valuation")
@Comment("Represents contents of adjustments of time, location and physical ones with estimated value for sales comparision between valuation units.")
public class SalesComparisonMethod {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The sales comparision approach identifier.")
	private String id;	
	
	@Comment("The date that sales comparision approach implemented.")
	private Date implemented_date;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "compared_vunit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "sales_comparison_method_compared_vunit_id_fkey"))
    private ValuationUnit valuation_unit;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value (in currency) estimated from the implementation.")
	private Double estimate_value;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Adjustments of time in currency value to compared valuation unit.")
	private Double time_adjustment;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Adjustments of location in currency value to compared valuation unit.")
	private Double location_adjustment;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Adjustments of physical ones in currency value to compared valuation unit.")
	private Double physical_adjustment;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "formula_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "sales_comparison_method_formula_id_fkey"))
	@Comment("Identifier of the formula implementation.")
	private ValuationFormula valuation_formula;

}
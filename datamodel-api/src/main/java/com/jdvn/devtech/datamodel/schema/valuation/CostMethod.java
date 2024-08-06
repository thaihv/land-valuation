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
@Table(name = "cost_method", schema = "valuation")
@Comment("Represents cost-related characteristics, such as cost type (e.g., replacement or reproduction cost), cost-related attributes, chronological and effective age of building and obsolescence for valuation approach of cost.")
public class CostMethod {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The cost approach identifier.")
	private String id;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "cost_approach_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "cost_method_cost_approach_type_code_fkey"))
    private CostApproachType cost_approach_type;
	
	@Comment("The date that cost approach implemented.")
	private Date implemented_date;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value (in currency) calculated per each square meter.")
	private Double cost_price_per_square_meter;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value (in currency) in total cost calculated.")
	private Double total_cost;
	
	@Comment("The source of cost price the implementation refered to.")
	private String source_of_cost_price;
	
	@Comment("The chronological age of property.")
	private int chronological_age;
	
	@Comment("The effective age of property.")
	private int effective_age;

	@Comment("The value (in currency) calculated for physical obsolescence.")
	private Double physical_obsolescence;
	
	@Comment("The value (in currency) calculated for functional obsolescence.")
	private Double functional_obsolescence;
	
	@Comment("The value (in currency) calculated for external obsolescence.")
	private Double external_obsolescence;
	
	@Comment("The value (in currency) calculated for total obsolescence.")
	private Double total_obsolescence;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value (in currency) estimated from cost implementation.")
	private Double estimate_value;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "formula_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "cost_method_formula_id_fkey"))
	@Comment("Identifier of the formula implementation.")
	private ValuationFormula valuation_formula;
}
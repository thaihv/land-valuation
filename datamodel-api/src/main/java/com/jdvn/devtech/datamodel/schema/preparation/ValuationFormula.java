package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.Set;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "valuation_formula", schema = "preparation")
@Comment("Used to store information about functions that implementated for valuation activities. Valuation functions are used to define the actual calculation procedures by linking together\r\n"
		+ "coefficient, technical parameters (e.g., object area) and other valuation functions.")
public class ValuationFormula {

	@Id
	@Comment("Identifier of the formula.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 60, nullable = false)
	@Comment("Display name of the formula.")
	private String name;

	@Column(nullable = false)
	@Comment("Sequence of the formula in relationship with its root formula.")
	private Integer sequence;
	
	@Column(length = 60, nullable = false)
	@Comment("Name of operation for formula for example sum, subtraction, product, division, min, max, lower, greater, etc.")
	private String operation;
	
	@Column(length = 60, nullable = false)
	@Comment("Name of special operation for formula for example logical operations as is null, not, OR, AND, equals, or user defined.")
	private String special_operation;
			
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "valuation_formulas_coefficients_links", schema = "preparation", joinColumns = @JoinColumn(name = "formula_id"), inverseJoinColumns = @JoinColumn(name = "coefficient_id"), foreignKey = @ForeignKey(name = "valuation_formulas_coefficients_links_formula_id_fkey"), inverseForeignKey = @ForeignKey(name = "valuation_formulas_coefficients_links_coefficient_id_fkey"))
	private Set<ModelHasCoefficient> coefficients;
		
	@OneToOne(optional = true)
	@JoinColumn(name = "use_basevalue_id", foreignKey = @ForeignKey(name = "valuation_formula_use_basevalue_id_fkey"))
	@Comment("Identifier to the base value in calculation.")
	private ModelHasBaseValue basevalue;
	
	@Comment("Floor value of the formula.")
	private Double floor;
	
	@Comment("Ceil value of the formula.")
	private Double ceil;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "parent_formula_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_formula_parent_formula_id_fkey"))
	@Comment("Identifier of the formula where is its immediate parent, it could be NULL as no specific parent.")
	private ValuationFormula parent_formula;
	

}
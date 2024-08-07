package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
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
				
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "left_coefficient_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_formula_left_coefficient_id_fkey"))
	@Comment("Identifier of the left coefficient in the formula.")
	private ModelHasCoefficient left_coefficient;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "left_parameter_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_formula_left_parameter_code_fkey"))
	@Comment("Identifier of the left parameter in the formula.")
	private TechnicalParameter left_parameter;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "right_coefficient_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_formula_right_coefficient_id_fkey"))
	@Comment("Identifier of the right coefficient in the formula.")
	private ModelHasCoefficient right_coefficient;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "right_parameter_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_formula_right_parameter_code_fkey"))
	@Comment("Identifier of the right parameter in the formula.")
	private TechnicalParameter right_parameter;
	
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
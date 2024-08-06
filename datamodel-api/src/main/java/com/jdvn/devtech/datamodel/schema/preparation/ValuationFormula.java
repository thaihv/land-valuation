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
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "valuation_formula", schema = "preparation")
@Comment("Used to store information about functions that implementated for valuation activities")
public class ValuationFormula {

	@Id
	@Comment("Identifier of the formula.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 60, nullable = false)
	@Comment("Display name of the formula.")
	private String name;

	@Column(nullable = false)
	@Comment("Sequence of the formula in relationship with its parent formula.")
	private Integer sequence;
	
	@Column(length = 60, nullable = false)
	@Comment("Name of operation for formula for example sum, subtraction, product, division, min, max, lower, greater, etc.")
	private String operation;
	
	@Comment("Floor value of the formula.")
	private Double floor;
	
	@Comment("Ceil value of the formula.")
	private Double ceil;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "base_formula_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_formula_base_formula_id_fkey"))
	@Comment("Base formula where belong to this formula, it could be NULL as no specific children.")
	private ValuationFormula baseFormula;
	

}
package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "valuation_approach_type", schema = "valuation", uniqueConstraints = { @UniqueConstraint(name = "valuation_approach_type_display_value", columnNames = { "display_value" })})
@Comment("Code list that deals with three primary types of valuation methods, namely, sales comparison, income and cost methods dominant in practice.")
public class ValuationApproachType{
	
	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the approach type.")
	private String code;

	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the approach type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the approach type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the approach type as active (a) or inactive (i).")
	private char status;
	
	@OneToOne(mappedBy = "valuation_approach_type")
	private Valuation valuation;

}
package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "valuation_unit_group_type", schema = "valuation")
@Comment("Code list that deals with three group types of valuation model as zone or locality.")
public class ValuationUnitGroupType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the valuation unit group.")
	private String code;

	/* Demo for more an unique column beside primary key */	
	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the valuation unit group.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the valuation unit group.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the valuation unit group as active (a) or inactive (i).")
	private char status;
	
	@OneToOne(mappedBy = "vu_group_type")
	private ValuationUnitGroup vu_group;
}
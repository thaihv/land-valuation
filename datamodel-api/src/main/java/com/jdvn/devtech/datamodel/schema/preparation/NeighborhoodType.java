package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "neighborhood_type", schema = "preparation", uniqueConstraints = { @UniqueConstraint(name = "neighborhood_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of neighborhood types. E.g., urban, rural, etc")
public class NeighborhoodType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the neighborhood type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the neighborhood type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the neighborhood type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the neighborhood type as active (a) or inactive (i).")
	private char status;
	
	@OneToOne(mappedBy = "neighborhood_type")
	private ValuationUnit valuation_unit;
}
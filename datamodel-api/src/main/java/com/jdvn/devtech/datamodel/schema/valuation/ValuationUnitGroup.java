package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
@Table(name = "valuation_unit_group", schema = "valuation")
@Comment("For grouping or zoning valuation units, such as administrative, economic and market zones that indicate similar characteristics or functions\r\n"
		+ "of valuation units (e.g., commercial, residential and agricultural).")
public class ValuationUnitGroup extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation unit type.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the valuation unit type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the valuation unit type as active (a) or inactive (i).")
	private char status;

	@Override
	public String print() {
		return id;
	}
	

}
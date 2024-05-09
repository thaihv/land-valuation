package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
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
@Table(name = "valuation", schema = "valuation", indexes = {
		@Index(name = "valuation_on_rowidentifier", columnList = "rowidentifier") })
@Comment("An improved form of the ExtValuation external class of LADM and specifies output data yielded during a valuation process.")
public class Valuation extends DomainObject<String> {
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
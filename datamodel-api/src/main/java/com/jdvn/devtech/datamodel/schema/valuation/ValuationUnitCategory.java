package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Set;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.OneToMany;
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
@Table(name = "valuation_unit_category", schema = "valuation", indexes = {
		@Index(name = "valuation_unit_category_on_rowidentifier", columnList = "rowidentifier") })
@Comment("List of the valuation unit categories.")
public class ValuationUnitCategory extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation unit category.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the valuation unit category.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the valuation unit category as active (a) or inactive (i).")
	private char status;

    @OneToMany(cascade=CascadeType.ALL, mappedBy = "valuation_unit_category")
    @JsonBackReference
    private Set<ValuationUnitType> valuationUnitTypes;

	@Override
	public String getId() {
		return code;
	}

	@Override
	public String print() {
		return code;
	}
    

}
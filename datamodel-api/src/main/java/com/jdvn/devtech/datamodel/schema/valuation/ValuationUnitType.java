package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.preparation.TechnicalParameter;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
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
@Table(name = "valuation_unit_type", schema = "valuation", indexes = {@Index(name = "valuation_unit_type_on_rowidentifier", columnList = "rowidentifier")})
@Comment("List of the valuation unit types as items belonged to categories.")
@SuppressWarnings({ "serial" })
public class ValuationUnitType extends DomainObject<String> {
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Code of the valuation unit type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the type.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the type as active (a) or inactive (i).")
	private char status;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "vunit_category_code", foreignKey = @ForeignKey(name = "valuation_unit_type_vunit_category_code_fkey"))
    @Comment("Refer to identifying of a valuation unit category.")
    private ValuationUnitCategory valuation_unit_category;

    /* Control many-to-many relationship between category and parameter, 
     * vunit_categoties is a variable in TechnicalParameter  */
    @ManyToMany(mappedBy = "vunit_types")
    private List<TechnicalParameter> valuation_parameters = new ArrayList<>();
    
	@OneToOne(mappedBy = "vu_type")
	private ValuationUnit valuation_unit;

	@Override
	public String getId() {
		return code;
	}
	@Override
	public String print() {
		return code;
	}
	
}
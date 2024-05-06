package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "valuation_unit_category", schema = "preparation", indexes = {@Index(name = "valuation_unit_category_on_rowidentifier", columnList = "rowidentifier")})
@Comment("List of the valuation unit categories")
@SuppressWarnings({ "serial" })
public class ValuationUnitCategory extends DomainObject<Long> {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the category.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the category.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the category as active (a) or inactive (i).")
	private char status;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "vunit_type_id", foreignKey = @ForeignKey(name = "valuation_unit_category_vunit_type_id_fkey"))
    @Comment("Refer to identifying of a valuation unit type.")
    private ValuationUnitType valuation_unit_type;

    /* Control many-to-many relationship between category and parameter, 
     * vunit_categoties is a variable in ValuationParameter  */
    @ManyToMany(mappedBy = "vunit_categoties")
    private List<ValuationParameter> valuation_parameters = new ArrayList<>();
    
	@Override
	public Long getId() {
		return id;
	}

	@Override
	public String print() {
		return name;
	}
}
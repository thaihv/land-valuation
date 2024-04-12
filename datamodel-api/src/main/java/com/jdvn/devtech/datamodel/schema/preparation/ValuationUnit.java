package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.Set;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.OneToMany;
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
@Table(name = "valuation_unit", schema = "preparation", uniqueConstraints = { @UniqueConstraint(name = "valuation_unit_name_key", columnNames = { "name" }) }, indexes = {
		@Index(name = "valuation_unit_on_rowidentifier", columnList = "rowidentifier") })
@Comment("List of the valuation units.")
public class ValuationUnit extends DomainObject<Long> {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation unit.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the valuation unit.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the valuation unit as active (a) or inactive (i).")
	private char status;

    @OneToMany(cascade=CascadeType.ALL, mappedBy = "valuation_unit")
    @JsonBackReference
    private Set<ValuationUnitCategory> valuationUnitCategories;
    
	@Override
	public String print() {
		return name;
	}
	

}
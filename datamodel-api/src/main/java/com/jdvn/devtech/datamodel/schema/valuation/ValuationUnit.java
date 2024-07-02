package com.jdvn.devtech.datamodel.schema.valuation;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.address.Address;
import com.jdvn.devtech.datamodel.schema.administrative.RRR;
import com.jdvn.devtech.datamodel.schema.preparation.NeighborhoodType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
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
@Table(name = "valuation_unit", schema = "valuation")
@Comment("Provides information about objects of valuation unit for fundamental recording of land and improvements (buildings), which can only be land, building\r\n"
		+ "or land and improvements together as land or condominium property.")
public class ValuationUnit extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "vu_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_unit_vu_type_code_fkey"))
    private ValuationUnitType vu_type;
    
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "address_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_unit_address_id_fkey"))
    private Address address;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@Comment("Neighborhood code as urban or rural, for example")
    @JoinColumn(name = "neighborhood_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_unit_neighborhood_code_fkey"))
    private NeighborhoodType neighborhood_type;
        
	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation unit type.")
	private String name;

	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The datetime the valuation unit is formally recognised by the land value assessment agency (i.e. registered or issued).")
	private LocalDateTime creation_date = LocalDateTime.now();
	
	@Column
	@Comment("The datetime the valuation unit was superseded and became historic.")
	private Date expiration_date;
		
	/* Control many-to-many relationship between valuation unit and valuation unit group */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "valuation_units_groups_links", schema = "valuation", joinColumns = @JoinColumn(name = "vunit_id"), inverseJoinColumns = @JoinColumn(name = "vunit_group_id"), foreignKey = @ForeignKey(name = "valuation_units_groups_links_vunit_id_fkey"), inverseForeignKey = @ForeignKey(name = "valuation_units_groups_links_vunit_group_id_fkey"))
	private Set<ValuationUnitGroup> vu_groups;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "valuation_unit")
    @JsonBackReference
    private Set<UnitHasParameterValue> unit_parameters;

	@OneToOne(mappedBy = "valuation_unit")
	private Valuation valuation;

	@OneToOne(mappedBy = "valuation_unit")
	private Taxation taxation;

	@OneToOne(mappedBy = "valuation_unit")
	private RRR rrr;
	
	@OneToOne(mappedBy = "valuation_unit")
	private SalesComparisonCalibration sales_comparison;
	
	@Override
	public String print() {
		return id;
	}
	

}
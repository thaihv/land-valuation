package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.address.Address;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
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

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vu_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_unit_vu_type_id_fkey"))
    private ValuationUnitType vu_type;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_unit_address_id_fkey"))
    private Address address;
        
	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation unit type.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the valuation unit type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the valuation unit type as active (a) or inactive (i).")
	private char status;

	/* Control many-to-many relationship between category and parameter */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "valuation_units_groups_links", schema = "valuation", joinColumns = @JoinColumn(name = "vunit_id"), inverseJoinColumns = @JoinColumn(name = "vunit_group_id"), foreignKey = @ForeignKey(name = "valuation_units_groups_links_vunit_id_fkey"), inverseForeignKey = @ForeignKey(name = "valuation_units_groups_links_vunit_group_id_fkey"))
	private List<ValuationUnitGroup> vu_groups = new ArrayList<>();
	
	@Override
	public String print() {
		return id;
	}
	

}
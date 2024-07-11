package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.Set;

import org.hibernate.annotations.Comment;
import org.locationtech.jts.geom.MultiPolygon;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

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
@Table(name = "building_unit", schema = "preparation")
@Comment("Provides detailed information about valuation unit as building unit or also called condominium unit.")
public class BuildingUnit extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "use_type", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_unit_use_type_fkey"))
	@Comment("Use type of the building unit or condominium unit .")
	private BuildingUseType use_type;
	
	@Comment("Floor number or locate identifier of the bulding unit.")
	private String located_number;
	
	@Column(nullable = true)
	@Comment("Number of rooms in the bulding unit.")
	private int number_rooms;

	@Column(nullable = true)
	@Comment("Number of bath rooms in the bulding unit.")
	private int number_bathrooms;
	
	@Column(nullable = true)
	@Comment("Number of bed rooms in the bulding unit.")
	private int number_bedrooms;
	
	@Comment("Whether has existence of accessory part or not.")
	private Boolean existed_accessory_part;
	
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "building_units_accessory_part_types_links", schema = "preparation", joinColumns = @JoinColumn(name = "building_unit_id"), inverseJoinColumns = @JoinColumn(name = "code"), foreignKey = @ForeignKey(name = "building_units_accessory_part_types_links_building_unit_id_fkey"), inverseForeignKey = @ForeignKey(name = "building_units_accessory_part_types_links_code_fkey"))
	@Comment("The list of accessory parts, if it exists.")
	private Set<AccessoryPartType> accessory_part_types;
	
	@Comment("Ratio of share of using facilities.")
	private Double shareInJointFacilities;
	
	@Column(columnDefinition = "geometry NOT NULL")
	@Comment("Geometry of building for spatial displaying.")
	private MultiPolygon geom;
	
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "belongto_building_id", foreignKey = @ForeignKey(name = "building_unit_belongto_building_id_fkey"))
    @Comment("Refer to identifying of a building.")
    private Building building;
        
	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
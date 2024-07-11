package com.jdvn.devtech.datamodel.schema.preparation;

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
@Comment("Provides detailed information about valuation unit as building unit.")
public class BuildingUnit extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Comment("Use type of the building unit.")
	private String use_type;
	
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
	
	@Comment("Whether space use as accessory or not.")
	private Boolean accessory_part;
	
	@Comment("Accessory part type of the building unit.")
	private String accessory_part_type;
	
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
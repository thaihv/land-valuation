package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.hibernate.annotations.Comment;
import org.locationtech.jts.geom.MultiPolygon;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.MapsId;
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
@Table(name = "building", schema = "preparation")
@Comment("Provides detailed information about valuation unit as building.")
public class Building extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Comment("Total area value that recorded in legality.")
	private Double area;

	@Comment("Total volume value of the building.")
	private Double volume;
	
	@Comment("Use type of the building.")
	private String use_type;

	@Comment("Type of the building if have a classification.")
	private String building_type;

	@Comment("Quality of the building if have a quality manegement.")
	private String quality;

	@Comment("Status of the building if have a status manegement.")
	private String status;
	
	@Column(nullable = true)
	@Comment("Number of elevators of the building.")
	private int elevator;

	@Column(nullable = true)
	@Comment("Number of air condition in the building.")
	private int airconditioning;
	
	@Comment("The date of construction.")
	private Date date_construction;

	@Column(nullable = true)
	@Comment("Number of floors of the building.")
	private int number_floors;
	
	@Column(nullable = true)
	@Comment("Number of dwellings of the building.")
	private int number_dwellings;

	@Comment("Material type of the building facade.")
	private String facade_material;
	
	@Comment("Material type used for constructing of building.")
	private String construct_material;
	
	@Comment("Heating system type of the bulding.")
	private String heating_system;
	
	@Comment("Heating source type of the bulding.")
	private String heating_source;
	
	@Comment("Energy performance value of the bulding.")
	private String energy_performance;
	
	@Column(name = "s_price")
	@Comment("Building price following the investigate in average per square meter.")
	private Double reasearchPrice;

	@Column(name = "f_price")
	@Comment("Building price in average per square meter in fact.")
	private Double decisionPrice;

	@Column(columnDefinition = "geometry NOT NULL")
	@Comment("Geometry of building for spatial displaying.")
	private MultiPolygon geom;

	@OneToOne
	@MapsId
	@JoinColumn(name = "id", foreignKey = @ForeignKey(name = "building_id_fkey"))
	private ValuationUnit valuation_unit;
	   

    @OneToMany(cascade=CascadeType.ALL, mappedBy = "building")
    @JsonBackReference
    private Set<BuildingUnit> building_units;
    
    @ManyToMany(mappedBy = "buildings")
    private List<Parcel> parcels = new ArrayList<>();
    
	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
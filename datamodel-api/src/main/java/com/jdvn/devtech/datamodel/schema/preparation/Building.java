package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.hibernate.annotations.Comment;
import org.locationtech.jts.geom.MultiPolygon;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
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
@Table(name = "building", schema = "preparation")
@Comment("Provides detailed information about valuation unit as building.")
public class Building extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Comment("Type of the building if have a classification.")
	private String building_type;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "type_use_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_type_use_code_fkey"))
	@Comment("Use type of the building.")
	private BuildingUseType building_use_type;

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

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "facade_material_type", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_facade_material_type_fkey"))
	@Comment("Material type of the building facade.")
	private FacadeMaterialType facade_material;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "construct_material_type", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_construct_material_type_fkey"))
	@Comment("Material type used for constructing of building.")
	private ConstructionMaterialType construct_material;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "heating_system_type", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_heating_system_type_fkey"))
	@Comment("Heating system type of the bulding.")
	private HeatingSystemType heating_system;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "heating_system_source_type", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_heating_system_source_type_fkey"))
	@Comment("Heating system type of the bulding.")
	private HeatingSystemSourceType heating_source;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "energy_performance_value", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_energy_performance_value_fkey"))
	@Comment("Energy performance value of the bulding.")
	private EnergyPerformanceValue energy_performance;
	
	@Column(columnDefinition = "geometry NOT NULL")
	@Comment("Geometry of building for spatial displaying.")
	private MultiPolygon geom;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "building")
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
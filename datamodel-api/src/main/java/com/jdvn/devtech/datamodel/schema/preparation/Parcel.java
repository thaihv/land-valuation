package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.Set;

import org.hibernate.annotations.Comment;
import org.locationtech.jts.geom.MultiPolygon;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
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
@Table(name = "parcel", schema = "preparation")
@Comment("Provides detailed information about valuation unit as parcel.")
public class Parcel extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(name = "area")
	@Comment("Legal area value that recorded in cadastre.")
	private Double area;

	@Comment("Code of land use.")
	private String curent_land_use;

	@Comment("Code of planed land use.")
	private String planed_land_use;

	@Column(columnDefinition = "geometry NOT NULL")
	@Comment("Geometry of parcel for spatial displaying.")
	private MultiPolygon geom;

	/*
	 * Control many-to-many relationship between parcel and building as a parcel may
	 * contains many buildings and a building may located at few parcels
	 */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "parcels_buildings_links", schema = "preparation", joinColumns = @JoinColumn(name = "parcel_id"), inverseJoinColumns = @JoinColumn(name = "building_id"), foreignKey = @ForeignKey(name = "parcels_buildings_links_parcel_id_fkey"), inverseForeignKey = @ForeignKey(name = "parcels_buildings_links_building_id_fkey"))
	private Set<Building> buildings;

	/*
	 * Control many-to-many relationship between parcel and utility as a parcel may
	 * contains many utilities and a utility may located at few parcels
	 */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "parcels_utility_networks_links", schema = "preparation", joinColumns = @JoinColumn(name = "parcel_id"), inverseJoinColumns = @JoinColumn(name = "utility_network_id"), foreignKey = @ForeignKey(name = "parcels_utility_networks_links_parcel_id_fkey"), inverseForeignKey = @ForeignKey(name = "parcels_utility_networks_links_utility_network_id_fkey"))
	private Set<UtilityNetwork> utility_networks;

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
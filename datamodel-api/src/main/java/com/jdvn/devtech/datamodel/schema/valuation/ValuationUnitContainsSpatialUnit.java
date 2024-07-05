package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.preparation.Parcel;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "valuation_unit_contains_spatial_unit", schema = "valuation", indexes = {
		@Index(name = "valuation_unit_contains_spatial_unit_vunit_id_fkey_ind", columnList = "vunit_id"), 
		@Index(name = "valuation_unit_contains_spatial_unit_parcel_id_fkey_ind", columnList = "spatial_unit_id"),
		@Index(name = "valuation_unit_contains_spatial_unit_index_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Associate the valuation unit to the one or many cadastre objects as parcels, buildings valuation process.")
@IdClass(VUnitSpatialUnitId.class)
public class ValuationUnitContainsSpatialUnit extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the valuation unit to be associated to.")
	private String vunit_id;
	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the Spatial Unit associated to the Valuation Unit.")
	private String spatial_unit_id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "valuation_unit_contains_spatial_unit_vunit_id_fkey"))
    @Comment("Reference to a valuation unit.")
    private ValuationUnit valuation_unit;
    
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "spatial_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_unit_contains_spatial_unit_parcel_id_fkey"))
    @Comment("Reference to a parcel need to envaluate.")
    private Parcel parcel;
    
//	@ManyToOne
//    @JoinColumn(name = "spatial_unit_id", referencedColumnName = "id", insertable=false, updatable=false, foreignKey = @ForeignKey(name = "valuation_unit_contains_spatial_unit_building_id_fkey"))
//    @Comment("Reference to a building need to envaluate.")
//    private Building building;
    
//    @ManyToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "spatial_unit_id", insertable=false, updatable=false, foreignKey = @ForeignKey(name = "valuation_unit_contains_spatial_unit_spatial_unit_id_fkey03"))
//    @Comment("Reference to a building unit as apartment, condominium need to envaluate.")
//    private BuildingUnit building_unit;
    
    
	@Override
	public String getId() {
		return vunit_id + "_" + spatial_unit_id;
	}	
	@Override
	public String print() {
		return vunit_id + "_" + spatial_unit_id;
	}
}
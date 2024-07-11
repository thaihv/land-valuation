package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;

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
@Table(name = "building_unit_volume", schema = "preparation")
@Comment("Identifies the overall volume of the building unit.")
public class BuildingUnitVolume {
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "building_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "building_unit_volume_building_unit_id_fkey"))
	@Comment("Identifier for the parcel this area value is associated to.")
	private BuildingUnit building_unit;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_unit_volume_type_code_fkey"))
	@Comment("The type of volume. E.g. officialVolume, calculatedVolume, etc.")
	private VolumeType type_code;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value of the volume. Must be in metres cubic and can be converted for display if requried.")
	private Double size;

}
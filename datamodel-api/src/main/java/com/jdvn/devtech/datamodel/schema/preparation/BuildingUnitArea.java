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
@Table(name = "building_unit_area", schema = "preparation")
@Comment("Identifies the overall area of the building unit.")
public class BuildingUnitArea {

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "building_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "building_unit_area_building_unit_id_fkey"))
	@Comment("Identifier for the building unit this area value is associated to.")
	private BuildingUnit building_unit;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "building_unit_area_type_code_fkey"))
	@Comment("The type of area. E.g. officialArea, calculatedArea, etc.")
	private AreaType type_code;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value of the area. Must be in metres squared and can be converted for display if requried.")
	private Double size;

}
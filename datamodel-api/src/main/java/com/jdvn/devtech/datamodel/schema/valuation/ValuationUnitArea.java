package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.preparation.AreaType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
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
@Table(name = "valuation_unit_area", schema = "valuation", indexes = {
		@Index(name = "valuation_unit_area_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "valuation_unit_area_vunit_id_fkey_ind", columnList = "vunit_id"),
		@Index(name = "valuation_unit_area_type_code_fkey_ind", columnList = "type_code")})
@Comment("Identifies the overall area of the Valuation Unit. This should be the sum of all parcel areas that are part of the Valuation Unit.")
public class ValuationUnitArea extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "vunit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_unit_area_vunit_id_fkey"))
	@Comment("Identifier for the Valuation Unit this area value is associated to.")
	private ValuationUnit valuation_unit;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_unit_area_type_code_fkey"))
	@Comment("The type of area. E.g. officialArea, calculatedArea, etc.")
	private AreaType type_code;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value of the area. Must be in metres squared and can be converted for display if requried.")
	private Double size;

	@Override
	public String print() {
		return id;
	}

}
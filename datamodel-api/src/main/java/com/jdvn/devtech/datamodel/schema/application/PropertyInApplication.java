package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

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
@Table(name = "application_property", schema = "application", indexes = {
		@Index(name = "application_property_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "application_property_application_id_fkey_ind", columnList = "application_id"),
		@Index(name = "application_property_valuation_unit_id_fkey_ind", columnList = "valuation_unit_id")})
@Comment("Captures details of property associated to an application.")
public class PropertyInApplication extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the application property.")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "application_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "application_property_application_id_fkey"))
	@Comment("Identifier for the application the record is associated to.")
    private Application application;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "valuation_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "application_property_valuation_unit_id_fkey"))
	@Comment("Reference to a record in the Valuation Unit table that matches the property details provided for the application for valuation process.")
    private ValuationUnit valuation_unit;
	
	@Column(name = "area")
	@Comment("The area of the property. This value should be square meters and converted if required for display to the user. e.g. Converted on display into and imperial acres, roods and perches value.")
	private Double area;
	
	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Flag to indicate if the property details provided for the application match an existing property record in the Valuation Unit table.")
	private boolean verified_exists;
	
	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Flag to indicate if the property details provided for the application reference an existing parcel record in the Cadastre Managemnt tables as Parcel, Buidling, UtilityNetwork.")
	private boolean verified_location;
	
	@Override
	public String print() {
		return id;
	}
}
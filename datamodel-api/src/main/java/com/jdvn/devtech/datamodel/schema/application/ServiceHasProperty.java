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
@Table(name = "service_property", schema = "application", indexes = {
		@Index(name = "service_property_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "service_property_service_id_fkey_ind", columnList = "service_id"),
		@Index(name = "service_property_vunit_id_fkey_ind", columnList = "vunit_id")})
@Comment("Captures details of property associated to a service.")
public class ServiceHasProperty extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the application property.")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "service_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "service_property_service_id_fkey"))
	@Comment("Identifier for the service the record is associated to.")
    private Service service;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "vunit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "service_property_vunit_id_fkey"))
	@Comment("Reference to a record in the Valuation Unit table that matches the property details provided for the service for valuation process.")
    private ValuationUnit valuation_unit;
	
	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Flag to indicate if the property details provided for the application match an existing property record in the Valuation Unit table.")
	private boolean verified_exists;
	
	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Flag to indicate if the property details provided for the application reference an existing parcel record in the Cadastre Managemnt tables as Parcel, Buidling, UtilityNetwork.")
	private boolean verified_location;

    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The area of the property for calculating proportionate service fee. This value should be square meters and may be converted into imperial acres, roods and perches values for display.")
    private Double area;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The property value on which is used for calculating proportionate service fee.")
    private Double total_value;
    
	@Column(length = 40)
	@Comment("The identifier of the user assigned to the property for handling. Typically, this is the user in charge from application or assigned from others ")
	private String assignee_id;
	
	@Override
	public String print() {
		return id;
	}
}
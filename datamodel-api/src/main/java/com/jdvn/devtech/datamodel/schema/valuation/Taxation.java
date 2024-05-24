package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

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
@Table(name = "taxation", schema = "valuation", indexes = {
		@Index(name = "taxation_on_rowidentifier", columnList = "rowidentifier") })
@Comment("An improved form of the ExtTaxation external class of LADM to support links to taxation system.")
public class Taxation extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Money amount calculated for this valuation unit.")
	private Double amount;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "tax_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "taxation_tax_type_code_fkey"))
    private TaxType tax_type;
	
	@Comment("The date that tax is calculated and effective.")
	private Date tax_date;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The ratio of tax to assessment value.")
	private Double assement_ratio;
	
	@Comment("The fiscal year the tax is effective.")
	private Date fiscal_year;	
	
	@Column(length = 500)
	@Comment("The rate of currency for calculating at the date.")
	private String rate;	
	
	@Column(length = 500)
	@Comment("Type of currency for taxation.")
	private String type;	
	
	@Column(length = 500)
	@Comment("Properties is exempted from tax calculation.")
	private String exemption_property;	
	
	@Column(length = 500)
	@Comment("Type of tax exemption.")
	private String exemption_type;	
	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "valuation_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "taxation_valuation_unit_id_fkey"))
    private ValuationUnit valuation_unit;
	    
	@Override
	public String print() {
		return id;
	}
	

}
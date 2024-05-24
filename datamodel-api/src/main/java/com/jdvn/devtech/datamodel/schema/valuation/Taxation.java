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
	@Comment("Money amount on tax calculated.")
	private Double assessment_tax;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "tax_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "taxation_tax_type_code_fkey"))
    private TaxType tax_type;
	
	@Comment("The date that tax is calculated and effective.")
	private Date payment_date;

	@Comment("The due date that tax has payment.")
	private Date due_date;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 1")
	@Comment("The ratio of assessment to property as 1 for whole property")
	private Double assement_ratio;
	
	@Comment("The fiscal year the tax is effective.")
	private Date fiscal_year;	
	
	@Column(length = 500)
	@Comment("The tax rate calculated at the date.")
	private String tax_rate;	
	
	@Column(length = 500)
	@Comment("Type of rate of taxation.")
	private String rate_type;	
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Any portion of property taxes that remain unpaid after the date on which they are due and includes late payment charges or other charges.")
	private Double tax_arrear_amount;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Amount is exempted from tax calculation.")
	private Double exemption_amount;	
	
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
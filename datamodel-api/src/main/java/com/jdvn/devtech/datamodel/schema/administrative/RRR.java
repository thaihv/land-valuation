package com.jdvn.devtech.datamodel.schema.administrative;

import java.util.Date;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

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
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "rrr", schema = "administrative", indexes = {
		@Index(name = "rrr_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "rrr_valuation_unit_id_fkey_ind", columnList = "valuation_unit_id"),
		@Index(name = "rrr_type_code_fkey_ind", columnList = "type_code"),
		@Index(name = "rrr_mortgage_type_code_ind", columnList = "mortgage_type_code")})
@Comment("Store the specific rights, restrictions and responsibilities that might be enquire from a valuation unit (called also a property) e.g. freehold ownership, lease, mortgage, caveat, etc. Implementation of the LADM LA_RRR class.")
public class RRR extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "valuation_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "rrr_valuation_unit_id_fkey"))
	@Comment("Identifier for the Valuation Unit the RRR need to query. In terms of Land Registration, this relationship is similar to RRR and BA_Unit from LADM")
	private ValuationUnit valuation_unit;

	@Column(length = 20)
	@Comment("Number to identify the hitorical RRR. Could be determined by the generate function of business rule. This value is useful to track the different versions of the RRR as it is edited over time.")
	private String reference_nr;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "rrr_type_code_fkey"))
	@Comment("The type of RRR. E.g. freehold ownership, lease, mortage, caveat, etc.")
	private RRRType rrr_type;

	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Flag to indicate if the RRR type is a primary RRR from Valuation Unit.")
	private boolean is_primary;

	@Comment("The date and time the RRR was formally registered by the Land Administration Agency.")
	private Date registration_date;

	@Comment("The date and time defining when the RRR remains in force to.")
	private Date expiration_date;

	@Column(columnDefinition = "numeric(29,2)")
	@Comment("The value of the mortgage.")
	private Double amount;

	@Comment("The date of the next payment for the RRR.")
	private Date due_date;

	@Column(columnDefinition = "numeric(5,2)")
	@Comment("The interest rate of the mortgage as a percentage.")
	private Double mortgage_interest_rate;

	@Comment("The ranking order if more than one mortgage applies to the right.")
	private int mortgage_ranking;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "mortgage_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "rrr_mortgage_type_code_fkey"))
	@Comment("The type of mortgage.")
	private MortgageType mortgage_type;

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
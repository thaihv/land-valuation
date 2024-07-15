package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.transaction.Transaction;

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
@Table(name = "valuation", schema = "valuation", indexes = {
		@Index(name = "valuation_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "valuation_transaction_id_fkey_ind", columnList = "transaction_id"),
		@Index(name = "valuation_value_type_code_fkey_ind", columnList = "value_type_code"),
		@Index(name = "valuation_approach_type_code_fkey_ind", columnList = "approach_type_code"),
		@Index(name = "valuation_appeal_status_code_fkey_ind", columnList = "appeal_status_code")})
@Comment("An improved form of the ExtValuation external class of LADM and specifies output data yielded during a valuation process.")
public class Valuation extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "transaction_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_transaction_id_fkey"))
	@Comment("Identifier to a transaction for report purposes.")
    private Transaction transaction;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The final decision value of valuation unit in currency. This is the final decision one selected from all valuation methods")
	private Double assessed_value;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "value_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_value_type_code_fkey"))
	@Comment("Type of value need to be valuated,  i.e., reasearchValue for survey operation, compensationValue for specific purpose, decisionValue for final mass appraisals.")
    private ValueType value_type;
	
	@Comment("The date that value is made for valuation.")
	private Date valuation_date;
	
	@Column(length = 128)
	@Comment("Display purpose of the valuation, for example ValuePerSquareMeter.") // ValuePerSquareMeter for example
	private String display_purpose;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "approach_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_approach_type_code_fkey"))
    private ValuationApproachType valuation_approach_type;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "appeal_status_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_appeal_status_code_fkey"))
    private AppealStatusType appeal_status;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "vunit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_vunit_id_fkey"))
	@Comment("Identifier to valuation unit of assement activity.")
    private ValuationUnit valuation_unit;
	    
	@Override
	public String print() {
		return id;
	}
	

}
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
@Table(name = "valuation", schema = "valuation", indexes = {
		@Index(name = "valuation_on_rowidentifier", columnList = "rowidentifier") })
@Comment("An improved form of the ExtValuation external class of LADM and specifies output data yielded during a valuation process.")
public class Valuation extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of object valuation in numeric.")
	private Double assessed_value;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "value_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_value_type_code_fkey"))
    private ValueType value_type;
	
	@Comment("The date that value is made for valuation.")
	private Date valuation_date;
	
	@Column(length = 500)
	@Comment("Display purpose of the valuation.")
	private String purpose_valuation;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "approach_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_approach_type_code_fkey"))
    private ValuationApproachType valuation_approach_type;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "appeal_status_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_appeal_status_code_fkey"))
    private AppealStatusType appeal_status;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "valuation_unit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_valuation_unit_id_fkey"))
    private ValuationUnit valuation_unit;
	    
	@Override
	public String print() {
		return id;
	}
	

}
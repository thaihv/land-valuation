package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.preparation.TechnicalParameter;
import com.jdvn.devtech.datamodel.schema.transaction.Transaction;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
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
@Table(name = "valuation_units_parameters_links", schema = "valuation")
@Comment("Used to store values of parameters as independent variable collected by automation systems or mannual for each valuation unit of regression model.")
@IdClass(ValuationUnitParameterId.class)
public class ValuationUnitHasParameter {  
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the valuation unit.")
	private String vunit_id;
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier to a transaction as the parameter value of a valuation unit might changes by time depends on valuation activity times.")
	private String transaction_id;	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("The code of the technical parameter.")
	private String parameter_code;

	@Comment("Value of the parameter with corresponding valuation unit. This can be a discrete value or converted, classified from a continuous range.")
	private Double value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_vunit_id_fkey"))
    private ValuationUnit valuation_unit;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "transaction_id", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_transaction_id_fkey"))
    private Transaction transaction;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "parameter_code", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_parameter_code_fkey"))
    private TechnicalParameter technical_parameter;
    
}
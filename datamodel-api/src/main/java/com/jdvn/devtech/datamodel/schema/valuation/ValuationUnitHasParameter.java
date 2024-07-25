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
@Comment("Measurement value of technial parameters for each valuation unit. They could be used as independent variables for regression model and they can be measured again depend on the transaction to get on.")
@IdClass(ValuationUnitParameterId.class)
public class ValuationUnitHasParameter {  
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the valuation unit.")
	private String vunit_id;
    @Id
	@Column(length = 40, nullable = false)
	@Comment("The code of the technical parameter.")
	private String parameter_code;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of the parameter with corresponding valuation unit. This can be a discrete value or converted, classified from a continuous range.")
	private Double value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_vunit_id_fkey"))
    @Comment("Reference to a valuation unit.")
    private ValuationUnit valuation_unit;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "parameter_code", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_parameter_code_fkey"))
    @Comment("Reference to a technical parameter.")
    private TechnicalParameter technical_parameter;
    
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "transaction_id", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_transaction_id_fkey"))
	@Comment("Identifier to which transaction is on a valuation activity to get parameter values.")
	private Transaction transaction;    
}
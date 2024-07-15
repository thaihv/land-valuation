package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.transaction.Transaction;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "model_parameters", schema = "preparation", uniqueConstraints = {
		@UniqueConstraint(name = "model_parameters_vunit_transaction_version_parameter", columnNames = { "vunit_id", "transaction_id", "version", "parameter_code"}) })
@Comment("Used to store values of parameters as independent variable collected by automation systems or mannual for each valuation unit of regression model.")
public class ModelHasParameter {  

	@Id
	@Comment("Identifier of the parameter for model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Comment("Version number of the model as system can support many versions in each transaction.")
	private Integer version;    

	@Column(nullable = false)
	@Comment("Value of the parameter with corresponding valuation unit. This can be a discrete value or converted, classified from a continuous range.")
	private Double value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "model_parameters_vunit_id_fkey"))
	@Comment("The id of the valuation unit.")
    private ValuationUnit valuation_unit;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "transaction_id", foreignKey = @ForeignKey(name = "model_parameters_transaction_id_fkey"))
	@Comment("Identifier to a transaction as the parameter value of a valuation unit might changes by time depends on valuation activity times.")
    private Transaction transaction;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "parameter_code", foreignKey = @ForeignKey(name = "model_parameters_parameter_code_fkey"))
	@Comment("The code of the technical parameter.")
    private TechnicalParameter technical_parameter;
    
}
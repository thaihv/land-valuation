package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.preparation.TechnicalParameter;

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
@Comment("Value of parameters as independent variable for each unit for regression model.")
@IdClass(UnitParameterId.class)
public class UnitHasParameterValue {  
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the valuation unit.")
	private String unit_id;
    @Id
	@Column(length = 40, nullable = false)
	@Comment("The code of the technical parameter.")
	private String parameter_code;

	@Column(length = 1000)
	@Comment("Value of the parameter with corresponding valuation unit.")
	private String value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "unit_id", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_unit_id_fkey"))
    @Comment("Reference to a valuation unit.")
    private ValuationUnit valuation_unit;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "parameter_code", foreignKey = @ForeignKey(name = "valuation_units_parameters_links_parameter_code_fkey"))
    @Comment("Reference to a technical parameter.")
    private TechnicalParameter technical_parameter;
    
}
package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
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
@Table(name = "model_coefficients", schema = "preparation")
@Comment("Used to store the calculated coefficients and constants of regression model.")
public class ModelHasCoefficient {  

	@Id
	@Comment("Identifier of the parameter for model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "model_id", foreignKey = @ForeignKey(name = "model_coefficients_model_id_fkey"))
	@Comment("The id of the model associated.")
    private ValuationModel model;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "parameter_code", foreignKey = @ForeignKey(name = "model_coefficients_code_fkey"))
	@Comment("The code of the technical parameter.")
    private TechnicalParameter technical_parameter;
        
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of the coefficient corresponding with parameter code.")
	private Double value;
    
    
}
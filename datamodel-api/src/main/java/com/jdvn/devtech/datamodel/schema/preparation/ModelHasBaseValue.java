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
@Table(name = "model_basevalue", schema = "preparation")
@Comment("Used to store the calculated base values or contants of regression model.")
public class ModelHasBaseValue {  

	@Id
	@Comment("Identifier of the base value or constant for model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "model_id", foreignKey = @ForeignKey(name = "model_basevalue_model_id_fkey"))
	@Comment("The id of the model associated.")
    private ValuationModel model;
    
	@Column(length = 40, nullable = false)
	@Comment("The name of model constant or base value.")
	private String constant_name;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Value of the constant name or base value.")
	private Double value;
    
}
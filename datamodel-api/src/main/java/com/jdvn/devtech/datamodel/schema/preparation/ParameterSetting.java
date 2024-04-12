package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

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
@Table(name = "parameter_setting", schema = "preparation")
@Comment("List of parameter settings in format Key/Value")
/* Foe demo composed key using IdClass */
@IdClass(SetingId.class)
public class ParameterSetting {  
	@Id
	private Long id;
    @Id
	@Column(length = 100, nullable = false)
	@Comment("Key name of a parameter setting.")
	private String key;

	@Column(length = 1000)
	@Comment("Value of the parameter setting key.")
	private String value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id", foreignKey = @ForeignKey(name = "parameter_setting_id_fkey"))
    @Comment("Reference to a valuation parameter.")
    private ValuationParameter valuation_parameter;
}
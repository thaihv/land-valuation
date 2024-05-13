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
/* For demo composed key using IdClass */
@IdClass(SetingId.class)
public class ParameterSetting {  
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The code for the technical parameter.")
	private String code;
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Key name of a parameter setting.")
	private String key;

	@Column(length = 1000)
	@Comment("Value of the parameter setting key.")
	private String value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "code", foreignKey = @ForeignKey(name = "parameter_setting_code_fkey"))
    @Comment("Reference to a valuation parameter.")
    private TechnicalParameter technical_parameter;
}
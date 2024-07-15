package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
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
@Table(name = "mass_appraisal", schema = "valuation")
@Comment("Provides the represent mass appraisal-related information, such as mathematical models, sample sizes and mass appraisal analysis types.")
public class MassAppraisal {

	@Id
	@Comment("Mass Appraisal identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "valuation_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "mass_appraisal_valuation_id_fkey"))
	private Valuation valuation;

	@Comment("The mathematical model is used for the mass appraisal performance.")
	private String mathematical_model;

	@Comment("Size of model sample of the mass appraisal performance.")
	private int simple_size;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value estimated from the mass appraisal performance.")
	private Double estimated_value;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "performance_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "mass_appraisal_performance_id_fkey"))
	private MassAppraisalPerformance mass_appraisal_performance;

}
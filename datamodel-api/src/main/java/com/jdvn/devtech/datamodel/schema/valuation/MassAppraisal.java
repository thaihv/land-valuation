package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
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
@Comment("Provides information represents mass appraisal-related information, such as mathematical models, sample sizes and mass appraisal analysis types")
public class MassAppraisal {

	@Id
	@Comment("Mass Appraisal identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Comment("The mathematical model is used for mass appraisal valuation.")
	private String mathematical_model;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("The value estimated from mass appraisal process.")
	private Double estimated_value;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "performance_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "mass_appraisal_performance_id_fkey"))
    private MassAppraisalPerformance mass_appraisal_performance;
		
	@OneToOne
	@MapsId
	@JoinColumn(name = "id", foreignKey = @ForeignKey(name = "mass_appraisal_id_fkey"))
	private Valuation valuation;
	
	

}
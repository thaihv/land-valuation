package com.jdvn.devtech.datamodel.schema.valuation;

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
@Table(name = "measure_performances_uniformities_links", schema = "valuation")
@Comment("Value of measurement of appraisal uniformities.")
@IdClass(PerformanceAppraisalUniformityId.class)
public class MeasureAppraisalUniformity {  
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the mass appraisal performance.")
	private String performance_id;
    @Id
	@Column(length = 40, nullable = false)
	@Comment("The code of mass appraisal uniformities.")
	private String uniformity_code;

    @Column(columnDefinition = "numeric(20,2)")
	@Comment("Value of the uniformity measurement.")
	private Double measured_value;
	
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "performance_id", foreignKey = @ForeignKey(name = "measure_performances_levels_links_performance_id_fkey"))
    @Comment("Reference to a Mass Appraisal Performance.")
    private MassAppraisalPerformance mass_appraisal_performance;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "uniformity_code", foreignKey = @ForeignKey(name = "measure_performances_uniformities_links_uniformity_code_fkey"))
    @Comment("Reference to a Appraisal Uniformity Type.")
    private AppraisalUniformityType appraisal_uniformity_type;
    
}
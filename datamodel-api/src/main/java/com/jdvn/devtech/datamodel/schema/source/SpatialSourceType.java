package com.jdvn.devtech.datamodel.schema.source;
import java.util.Set;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "spatial_source_type", schema = "source", uniqueConstraints = { @UniqueConstraint(name = "spatial_source_type_display_value_key", columnNames = { "display_value" }) })
@Comment("Code list of spatial source types included in valuation process")
public class SpatialSourceType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the spatial source type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the spatial source type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the spatial source type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status of the spatial source type as current (c) or noncurrent (x).")
	private char status;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "spatial_source_type")
    @JsonBackReference
    private Set<SpatialSource> spatial_sources;
}
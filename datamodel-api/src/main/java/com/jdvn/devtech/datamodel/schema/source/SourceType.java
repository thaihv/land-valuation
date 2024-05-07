package com.jdvn.devtech.datamodel.schema.source;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.application.RequestType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
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
@Table(name = "source_type", schema = "source", uniqueConstraints = { @UniqueConstraint(name = "source_type_display_value_key", columnNames = { "display_value" }) })
@Comment("Code list of source types included in valuation process")
public class SourceType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the source type.")
	private String code;

	@Column(length = 1000, nullable = false)
	@Comment("Displayed value of the source type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the source type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the source type as current (c) or noncurrent (x).")
	private char status;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "source_type")
    @JsonBackReference
    private Set<Source> sources;
    
    /* Control many-to-many relationship between source and request_type, 
     * source_types is a variable in RequestType  */
    @ManyToMany(mappedBy = "source_types")
    private List<RequestType> request_types = new ArrayList<>();
}
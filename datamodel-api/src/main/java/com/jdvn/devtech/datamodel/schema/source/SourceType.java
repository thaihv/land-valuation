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
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "source_type", schema = "source")
@Comment("Code list of source types include in valuation process")
public class SourceType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the source type.")
	private String code;

	@Column(length = 1000, nullable = false, unique=true)
	@Comment("Displayed value of the source type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the source type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the source type as active (a) or inactive (i).")
	private char status;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "source_type")
    @JsonBackReference
    private Set<Source> sources;
}
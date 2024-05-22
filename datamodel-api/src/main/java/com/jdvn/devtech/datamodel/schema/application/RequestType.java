package com.jdvn.devtech.datamodel.schema.application;

import java.util.Set;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.source.SourceType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "request_type", schema = "application", uniqueConstraints = { @UniqueConstraint(name = "request_type_display_value_key", columnNames = { "display_value" }) })
@Comment("Code list of request types. Request types identify the different types of services provided.")
public class RequestType{

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the request type.")
	private String code;

	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the application action type.")
	private String display_value;
	
	@Column(length = 1000)
	@Comment("Description of the application action type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the application action type as active (a) or inactive (i).")
	private char status;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "request_type")
    @JsonBackReference
    private Set<Service> services;
    
	/* Control many-to-many relationship between request_type and source */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "request_type_requires_source_type", schema = "application", joinColumns = @JoinColumn(name = "request_type_code"), inverseJoinColumns = @JoinColumn(name = "source_type_code"), foreignKey = @ForeignKey(name = "request_type_requires_source_type_request_type_code_fkey"), inverseForeignKey = @ForeignKey(name = "request_type_requires_source_type_source_type_code_fkey"))
	private Set<SourceType> source_types;
	
}
package com.jdvn.devtech.datamodel.schema.application;

import java.util.Set;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.jdvn.devtech.datamodel.schema.source.SourceType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
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
	
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "request_category_code", foreignKey = @ForeignKey(name = "request_type_request_category_code_fkey"))
	@Comment("The code for the request category type.")
    private RequestCategoryType request_category_type;
    
	@Column(length = 500, nullable = false, unique=true)
	@Comment("Displayed value of the request type.")
	private String display_value;
	
	@Column(length = 1000)
	@Comment("Description of the request type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the request type as active (a) or inactive (i).")
	private char status;
	
    @Column(columnDefinition = "integer NOT NULL DEFAULT 0")
	@Comment("The number of days it should take for the service to be completed.")
	private int nr_days_to_complete;
	
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The fixed fee component charged for the service or 0 if there is no fixed fee.")
    private Double base_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The fee component charged for each square metre of the property or 0 if no area fee applies.")
    private Double area_base_fee;
    
    @Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
    @Comment("The fee component charged against the value of the property or 0 if no value fee applies.")
    private Double value_base_fee;

	@Column(length = 1000)
	@Comment("Template text to use when completing the details of valuation records created by the service.")
	private String notation_template;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "request_type")
    @JsonBackReference
    private Set<Service> services;
    
	/* Control many-to-many relationship between request_type and source */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "request_type_requires_source_type", schema = "application", joinColumns = @JoinColumn(name = "request_type_code"), inverseJoinColumns = @JoinColumn(name = "source_type_code"), foreignKey = @ForeignKey(name = "request_type_requires_source_type_request_type_code_fkey"), inverseForeignKey = @ForeignKey(name = "request_type_requires_source_type_source_type_code_fkey"))
	@Comment("Points out which types of source will be associated with request type of service.")
	private Set<SourceType> source_types;
	
}
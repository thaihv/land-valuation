package com.jdvn.devtech.datamodel.schema.preparation;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "tech_parameter", schema = "preparation")
@Comment("List of all technical properties for valuation process")
public class TechnicalParameter {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the technical parameter.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the technical parameter.")
	private String description;
   
	@Column(length = 64)
	@Comment("Type of the technical parameter as Numeric, Boolean, Enumerated, String...")
	private String type;
    
	@Column(columnDefinition = "boolean NOT NULL DEFAULT true")
	@Comment("Status mandatory of the technical parameter as mandatory (true) or not (false).")
	private boolean is_mandatory;

	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Status virtual of the technical parameter as for virtual (true) or not (false).")
	private boolean is_virtual;
	
	@Column(columnDefinition = "boolean NOT NULL DEFAULT true")
	@Comment("Status active of the technical parameter as active (true) or inactive (false).")
	private boolean is_active;
	
	/* Control many-to-many relationship between category and parameter */
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "types_parameters_links", schema = "preparation", joinColumns = @JoinColumn(name = "parameter_id"), inverseJoinColumns = @JoinColumn(name = "type_id"), foreignKey = @ForeignKey(name = "types_parameters_links_parameter_id_fkey"), inverseForeignKey = @ForeignKey(name = "types_parameters_links_type_id_fkey"))
	private List<ValuationUnitType> vunit_types = new ArrayList<>();
}
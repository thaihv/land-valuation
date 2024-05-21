package com.jdvn.devtech.datamodel.schema.source;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
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
@Table(name = "source", schema = "source", indexes = {
		@Index(name = "source_on_rowidentifier", columnList = "rowidentifier") })
@Comment("List of the sources in valuation process.")
public class Source extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 20, nullable = false)
	@Comment("Reference number or identifier assigned to the document by the land valuation assessor.")
	private String assess_nr;

	@Column(length = 255)
	@Comment("Reference number or identifier assigned to the document by an external agency.")
	private String reference_nr;

	@Column(length = 4000)
	@Comment("Content of the source.")
	private String content;

	@Column
	@Comment("Archive identifier for the source.")
	private String archive_id;

	@Column
	@Comment("Identifier of the source to a digital document in document table.")
	private String document_id;

	@Column(length = 64)
	@Comment("Identifier of the source in an external document management system, if any.")
	private String ext_archive_id;

	@Column(length = 255)
	@Comment("The name of the party that created the document.")
	private String owner_name;

	@Column(length = 40)
	@Comment("The document version.")
	private String version;

	@Column
	@Comment("The date the document was signed by all parties.")
	private Date signing_date;

	@Column
	@Comment("The acceptance date of source.")
	private Date acceptance;

	@Column
	@Comment("The recordation date of source.")
	private Date recordation;

	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The submission date of source.")
	private LocalDateTime submission = LocalDateTime.now();

	@Column
	@Comment("The expiration date of source.")
	private Date expiration;

	@Column(length = 255)
	@Comment("Description of the source.")
	private String description;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonManagedReference
	@JoinColumn(name = "type_code", foreignKey = @ForeignKey(name = "source_type_fkey"))
	@Comment("Refer to identifying of a source type.")
	private SourceType source_type;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonManagedReference
	@JoinColumn(name = "present_format", foreignKey = @ForeignKey(name = "source_presentation_form_format_fkey"))
	@Comment("The type of the representation of the content of the source.")
	private PresentationFormType presentationFormType;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonManagedReference
	@JoinColumn(name = "availability_status_code", foreignKey = @ForeignKey(name = "availability_status_type_fkey"))
	@Comment("The code describing the availability status of the document.")
	private AvailabilityStatusType availability_status_type;
	
    /* Control many-to-many relationship between source and valuation unit, 
     * sources is a variable in ValuationUnit  */
    @ManyToMany(mappedBy = "sources")
    private List<ValuationUnit> valuation_units = new ArrayList<>();
        
    @OneToOne(mappedBy = "source", cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
    private SpatialSource spatial_source;
    
    @OneToOne(mappedBy = "source", cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
    private PowerAttorney power_attorney;
    
	@Override
	public String print() {
		return id;
	}
}
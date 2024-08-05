package com.jdvn.devtech.datamodel.schema.source;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
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
@Table(name = "spatial_source", schema = "source", indexes = {
		@Index(name = "spatial_source_index_on_rowidentifier", columnList = "rowidentifier") })
@Comment("A spatial source may be the final (sometimes formal) documents, or all documents related to a survey in valuation process.")
public class SpatialSource extends DomainObject<String>{

	private static final long serialVersionUID = 1L;
	@Id
	@Comment("Spatial source identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 255)
	@Comment("Procedures, steps or method adopted.")
	private String procedure;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JsonManagedReference
	@JoinColumn(name = "type_code", foreignKey = @ForeignKey(name = "spatial_source_type_fkey"))
	@Comment("Refer to identifying of a source type.")
	private SpatialSourceType spatial_source_type;
	
	@OneToOne
	@MapsId
	@JoinColumn(name = "id", foreignKey = @ForeignKey(name = "spatial_source_id_fkey"))
	private Source source;
	
	@Override
	public String print() {
		return "Source ID" + id;
	}
}
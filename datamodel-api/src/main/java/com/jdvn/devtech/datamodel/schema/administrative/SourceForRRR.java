package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.source.Source;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
@Table(name = "source_describes_rrr", schema = "administrative")
@Comment("Associates a RRR with one or more source (a.k.a. document) records. Implementation of the LADM LA_RRR to LA_AdministrativeSource relationship.")
@IdClass(SourceRRRId.class)
public class SourceForRRR extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the rrr.")
	private String rrr_id;
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of source.")
	private String source_id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "rrr_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "source_describes_rrr_rrr_id_fkey"))
	@Comment("Reference to a RRR to identify.")
	private RRR rrr;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "source_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "source_describes_rrr_source_id_fkey"))
	@Comment("Reference to the source to verify a party.")
	private Source source;

	@Override
	public String getId() {
		return rrr_id + "_" + source_id;
	}

	@Override
	public String print() {
		return rrr_id + "_" + source_id;
	}

}
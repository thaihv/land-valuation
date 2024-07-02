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
@Table(name = "source_describes_party", schema = "administrative")
@Comment("Implements the many-to-many relationship identifying administrative source instances with party instances.")
@IdClass(SourcePartyId.class)
public class SourceForParty extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the party.")
	private String party_id;
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of source.")
	private String source_id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "party_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "source_describes_party_party_id_fkey"))
	@Comment("Reference to a party need to idetify.")
	private Party party;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "source_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "source_describes_party_source_id_fkey"))
	@Comment("Reference to the source to verify a party.")
	private Source source;

	@Override
	public String getId() {
		return party_id + "_" + source_id;
	}

	@Override
	public String print() {
		return party_id + "_" + source_id;
	}

}
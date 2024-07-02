package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Index;
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
@Table(name = "rrr_share", schema = "administrative", indexes = {
		@Index(name = "rrr_share_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Identifies the share a party has in an RRR.")
@IdClass(RRRShareId.class)
public class RRRShare extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier of the RRR the share is assocaited with.")
	private String rrr_id;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the RRR share.")
	private String id;

	@Comment("Nominiator part of the share (i.e. top number of fraction)")
	private int nominator;

	@Comment("Denominator part of the share (i.e. bottom number of fraction)")
	private int denominator;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "rrr_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "rrr_share_rrr_id_fkey"))
	@Comment("Reference to a RRR to identify.")
	private RRR rrr;

//	@OneToMany(fetch = FetchType.LAZY)
//	@JoinColumn(name = "id", referencedColumnName = "share_id", foreignKey = @ForeignKey(name = "rrr_share_id_fkey"))
//	@Comment("Reference to a Party for RRR.")
//	private PartyForRRR party_rrr;
	
	@Override
	public String getId() {
		return rrr_id + "_" + id;
	}

	@Override
	public String print() {
		return rrr_id + "_" + id;
	}

}
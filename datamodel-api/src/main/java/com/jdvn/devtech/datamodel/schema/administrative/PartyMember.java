package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@Table(name = "party_member", schema = "administrative")
@Comment("Identifies the parties belonging to a group party. Implementation of the LADM LA_PartyMember class.")
@IdClass(PartyGroupId.class)
public class PartyMember extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the party.")
	private String party_id;
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of group party.")
	private String group_id;

	@Column(columnDefinition = "numeric(17,7)")
	@Comment("The share of a RRR held by a party member expressed as a fraction with a numerator and a denominator.")
	private Double share;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "party_id", foreignKey = @ForeignKey(name = "party_member_party_id_fkey"))
	@Comment("Reference to a party.")
	private Party party;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "group_id", foreignKey = @ForeignKey(name = "party_member_group_id_fkey"))
	@Comment("Reference to a group party.")
	private GroupParty group_party;

	@Override
	public String getId() {
		return party_id + "_" + group_id;
	}

	@Override
	public String print() {
		return party_id + "_" + group_id;
	}

}
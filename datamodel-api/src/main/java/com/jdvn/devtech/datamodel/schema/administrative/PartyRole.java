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
@Table(name = "party_role", schema = "administrative", indexes = {
		@Index(name = "party_role_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Identifies the roles a party has in relation to the land office transactions and data.")
@IdClass(PartyRoleId.class)
public class PartyRole extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the party.")
	private String party_id;
	@Id
	@Column(length = 40, nullable = false)
	@Comment("The code of role.")
	private String type_code;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "party_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "party_role_party_id_fkey"))
	@Comment("Reference to a party holds.")
	private Party party;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "party_role_type_code_fkey"))
	@Comment("The type of role the party holds.")
	private PartyRoleType party_role_type;

	@Override
	public String getId() {
		return party_id + "_" + type_code;
	}

	@Override
	public String print() {
		return party_id + "_" + type_code;
	}

}
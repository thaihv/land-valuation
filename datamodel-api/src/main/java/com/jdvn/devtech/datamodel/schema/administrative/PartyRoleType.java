package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "party_role_type", schema = "administrative", uniqueConstraints = {
		@UniqueConstraint(name = "party_role_type_display_value", columnNames = { "display_value" }) })
@Comment("Code list of party role types. Used to identify the types of role a party can have in relation to land office transactions and data. E.g. applicant, bank, lodgingAgent, notary, etc.")
public class PartyRoleType {
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the party role type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the party role type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the party role type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the party role type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "party_role_type")
	private PartyRole party_role;
}
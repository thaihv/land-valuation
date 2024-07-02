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
@Table(name = "group_party_type", schema = "administrative", uniqueConstraints = {
		@UniqueConstraint(name = "group_party_type_display_value", columnNames = { "display_value" }) })
@Comment("Code list of group party types. Implementation of the LADM LA_GroupPartyType class. Not used by Land Valuation.")
public class GroupPartyType {
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the group party type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the group party type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the group party type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the group party type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "group_party_type")
	private GroupParty group_party;
}
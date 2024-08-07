package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "rrr_type", schema = "administrative", uniqueConstraints = {
		@UniqueConstraint(name = "rrr_type_display_value", columnNames = { "display_value" }) })
@Comment("Code list of RRR types. E.g. freehold owernship, lease, mortgage, caveat, etc.")
public class RRRType {
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the RRR type.")
	private String code;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "rrr_group_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "rrr_type_rrr_group_type_code_fkey"))
	@Comment("Identifies if the RRR type is a right, restriction or a responsibility.")
	private RRRGroupType rrr_group_type;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the RRR type.")
	private String display_value;

	@Column(columnDefinition = "boolean NOT NULL DEFAULT false")
	@Comment("Flag to indicate if the RRR type is a primary RRR.")
	private boolean is_primary;

	@Comment("Flag to indicate the that the sum of all shares for this RRR must be checked to ensure it equals 1.")
	private boolean share_check;

	@Comment("Flag to indicate at least one party must be associated with this RRR.")
	private boolean party_required;

	@Column(length = 1000)
	@Comment("Description of the RRR type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the RRR type as active (a) or inactive (i).")
	private char status;

}
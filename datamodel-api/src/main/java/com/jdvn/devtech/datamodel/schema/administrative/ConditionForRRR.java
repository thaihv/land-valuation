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
@Table(name = "condition_for_rrr", schema = "administrative", indexes = {
		@Index(name = "condition_for_rrr_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "condition_for_rrr_condition_code_fkey_ind", columnList = "condition_code"),
		@Index(name = "condition_for_rrr_rrr_id_fkey_ind", columnList = "rrr_id")})
@Comment("Captures any statutory or agreed conditions in relation to an RRR. E.g. conditions of lease, etc. An RRR can have multiple conditions associated to it.")
public class ConditionForRRR extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "rrr_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "condition_for_rrr_rrr_id_fkey"))
	@Comment("Identifier of the RRR the condition relates to.")
	private RRR rrr;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "condition_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "condition_for_rrr_condition_code_fkey"))
	@Comment("The type of condition.")
	private ConditionType condition_type;
	
	@Column(length = 500)
	@Comment("User entered text describing the condition and_or updated or revised text obtained from the template condition text.")
	private String custom_condition_text;

	@Comment("A quantity value associted to the condition.")
	private int condition_quantity;

	@Column(length = 15)
	@Comment("The unit of measure applicable for the condition quantity.")
	private String condition_unit;
	
	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
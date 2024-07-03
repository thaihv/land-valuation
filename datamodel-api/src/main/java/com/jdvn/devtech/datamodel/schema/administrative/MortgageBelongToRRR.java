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
@Table(name = "mortgage_isbased_in_rrr", schema = "administrative", indexes = {
		@Index(name = "mortgage_isbased_in_rrr_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "mortgage_isbased_in_rrr_mortgage_id_fkey_ind", columnList = "mortgage_id"),
		@Index(name = "mortgage_isbased_in_rrr_rrr_id_fkey_ind", columnList = "rrr_id")})
@Comment("Identifies RRR that is subject to mortgage. Not used as if the primary right will always be the subject of the mortgage.")
@IdClass(MortgageRRRId.class)
public class MortgageBelongToRRR extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the mortgage.")
	private String mortgage_id;
	
	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the RRR associated to the mortgage.")
	private String rrr_id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "mortgage_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "mortgage_isbased_in_rrr_mortgage_id_fkey"))
	@Comment("Reference to a RRR to identify the Mortgage.")
	private RRR rrr_1;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "rrr_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "mortgage_isbased_in_rrr_rrr_id_fkey"))
	@Comment("Reference to a RRR to identify right belong the Mortgage.")
	private RRR rrr_2;
	
	@Override
	public String getId() {
		return rrr_id + "_" + mortgage_id;
	}

	@Override
	public String print() {
		return rrr_id + "_" + mortgage_id;
	}

}
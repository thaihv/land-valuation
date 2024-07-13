package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

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
@Table(name = "valuation_appeal", schema = "valuation", indexes = {
		@Index(name = "valuation_appeal_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "valuation_appeal_valuation_id_fkey_ind", columnList = "valuation_id")})
@Comment("To be enable tracking status of possible appeals against to assessed values.")
public class ValuationAppeal extends DomainObject<String>{
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "valuation_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_appeal_valuation_id_fkey"))
	@Comment("Identifier to a valuation activity")
    private Valuation valuation;
	
	@Column(length = 1000, nullable = false)
	@Comment("The subject of the appeal need to be handle.")
	private String appeal_subject;

	@Comment("The date that appeal is submited against the valuation unit.")
	private Date appeal_date;
	
	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}
	
}
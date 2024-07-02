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
@Table(name = "party", schema = "administrative")
@Comment("An individual, group or organisation that is associated in some way with land office services. Implementation of the LADM LA_Party class.")
public class Party extends DomainObject<String>{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column(length = 255)
	@Comment("An identifier for the party from some external system such as a customer relationship management (CRM) system.")
	private String ext_id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "party_type_code_fkey"))
	@Comment("The type of the party. E.g. naturalPerson, nonNaturalPerson, etc.")
    private PartyType party_type;

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
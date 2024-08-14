package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.administrative.Party;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "notify", schema = "application", indexes = {
		@Index(name = "notify_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "notify_party_id_fkey_ind", columnList = "party_id"),
		@Index(name = "notify_service_id_fkey_ind", columnList = "service_id")})
@Comment("Identifies parties to be notified in a service as well as the relationship the party has affected")
public class Notify extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the notification.")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "party_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "notify_party_id_fkey"))
	@Comment("Identifier of the party (individual or organization) that is requesting a plan.")
    private Party party;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "service_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "notify_service_id_fkey"))
	@Comment("Identifier for the service.")
    private Service service;	
		
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "relationship_type_code", foreignKey = @ForeignKey(name = "notify_relationship_type_code_fkey"), columnDefinition="character varying(20) NOT NULL DEFAULT 'contactor'::character varying")
	@Comment("The type of relationship between the party and the land affected by the valuation services.")
    private NotifyRelationshipType relation_type;
    	
	@Column(length = 1000)
	@Comment("The description of the party to notify.")
	private String description;
    
	@Comment("The content of notify to the party.")
	private String notify_content;
	
	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status of the notify as active (a) or inactive (i).")
	private char status;
	
	@Override
	public String print() {
		return id;
	}
}
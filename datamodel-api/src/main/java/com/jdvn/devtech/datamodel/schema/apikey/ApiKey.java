package com.jdvn.devtech.datamodel.schema.apikey;

import java.util.Date;
import java.util.Set;

import org.hibernate.annotations.Comment;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
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
@Table(name = "api_keys", schema = "apikey")
@Comment("Presents basic information on key which registered.")
public class ApiKey {

	@Id
	@Comment("Key performance identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column(length = 256, nullable = false)
	@Comment("The key generated and used by system.")
	private String api_key;
	
	@Column(length = 64, nullable = false)
	@Comment("A summary of key from register as title.")
	private String summary;
	
	@Column(length = 64)
	@Comment("Details of key from register as content.")
	private String description;
	
	@Column(columnDefinition = "character varying(16) DEFAULT 'individual'")
	@Comment("Use type of registered key as individual or organization .")
	private String use_type;
	
	@Column(length = 64, nullable = false)
	@Comment("The legal identity of user who register the key.")
	private String identity;
	
	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name = "legal_code", foreignKey = @ForeignKey(name = "api_keys_legal_code_fkey"))
	@Comment("Type of legal indentity as ID number or business license.")
	private LegalType legal_code;
		
	@Column(length = 64, nullable = false)
	@Comment("Status of registered key as applying, revoked or in use.")
	private String status;
	
	@Comment("The date that key is made.")
	private Date created_at;
	
	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "api_keys_data_scopes", schema = "apikey", joinColumns = @JoinColumn(name = "api_key_id"), inverseJoinColumns = @JoinColumn(name = "scope_id"), foreignKey = @ForeignKey(name = "api_keys_data_scopes_api_key_id_fkey"), inverseForeignKey = @ForeignKey(name = "api_keys_data_scopes_scope_id_fkey"))
	private Set<DataScope> data_scopes;
	
}
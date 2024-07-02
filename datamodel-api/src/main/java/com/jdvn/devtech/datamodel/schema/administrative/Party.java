package com.jdvn.devtech.datamodel.schema.administrative;

import java.util.Date;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.address.Address;

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
@Table(name = "party", schema = "administrative", indexes = {
		@Index(name = "party_on_rowidentifier", columnList = "rowidentifier") })
@Comment("An individual, group or organisation that is associated in some way with land office services. Implementation of the LADM LA_Party class.")
public class Party extends DomainObject<String> {

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

	@Column(length = 255)
	@Comment("The first name(s) for the party or the group or organisation name.")
	private String name;

	@Column(length = 50)
	@Comment("The last name for the party or blank for groups and organisations.")
	private String last_name;

	@Column(length = 50)
	@Comment("Any alias for the party. A party can have more than one alias. If so, the aliases should be separated by a comma.")
	private String alias;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "gender_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "party_gender_code_fkey"))
	@Comment("Identifies the gender for the party. If the party is of type naturalPerson then a gender code must be specified.")
	private GenderType gender_type;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "address_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "party_address_id_fkey"))
	@Comment("Identifier for the contact address of the party.")
	private Address address;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "id_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "party_id_type_code_fkey"))
	@Comment("Used to indicate the type of id used to verify the identity of the party.")
	private IDType id_type;

	@Column(length = 20)
	@Comment("The number from the id used to verify the identity of the party.")
	private String id_number;

	@Column(length = 50)
	@Comment("The contact email address of the party.")
	private String email;

	@Column(length = 15)
	@Comment("The contact mobile phone number of the party.")
	private String mobile;

	@Column(length = 15)
	@Comment("The main contact phone number of the party. I.e. landline.")
	private String phone;

	@Column(length = 15)
	@Comment(" The fax number of the party.")
	private String fax;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "preferred_communication_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "party_id_preferred_communication_code_fkey"))
	@Comment("Used to indicate the preferred means of communication the party will use with the land administration agency.")
	private CommunicationType communication_type;

	@Comment("Date of birth of naturalPerson party, if any.")
	private Date birth_date;

	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
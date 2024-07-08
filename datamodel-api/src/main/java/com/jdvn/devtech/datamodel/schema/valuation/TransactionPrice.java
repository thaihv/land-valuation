package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

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
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "transaction_price", schema = "valuation", indexes = {
		@Index(name = "transaction_price_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "transaction_price_contract_number_ind", columnList = "contract_number"),
		@Index(name = "transaction_price_contract_date_ind", columnList = "contract_date"),
		@Index(name = "transaction_price_certificated_date_ind", columnList = "certificated_date"),
		@Index(name = "transaction_price_transaction_type_code_fkey_ind", columnList = "transaction_type_code"),
		@Index(name = "transaction_price_real_estate_agency_name_ind", columnList = "real_estate_agency_name"),
		@Index(name = "transaction_price_real_estate_agency_address_id_fkey_ind", columnList = "real_estate_agency_address_id") })
@Comment("Represents the information related to property transactions.")
public class TransactionPrice extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The contract or declaration identifier.")
	private String id;

	@Comment("The date that contract or declaration.")
	private Date contract_date;

	@Column(length = 40)
	@Comment("The number of the contract or declaration.")
	private String contract_number;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Price of property in transaction.")
	private Double price;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Price of property in transaction calculated per meter square.")
	private Double unit_price;

	@Comment("Name of real estate agency.")
	@Column(length = 255)
	private String real_estate_agency_name;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "real_estate_agency_address_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "transaction_price_real_estate_agency_address_id_fkey"))
	@Comment("Identifier for the real estate agency address.")
	private Address agency_address;

	@Comment("The date of certification.")
	private Date certificated_date;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "transaction_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "transaction_price_transaction_type_code_fkey"))
	private PropertyTransactionType transaction_type;

	@Override
	public String print() {
		return id;
	}

}
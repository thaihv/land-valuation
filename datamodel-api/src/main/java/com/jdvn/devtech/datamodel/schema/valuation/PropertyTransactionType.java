package com.jdvn.devtech.datamodel.schema.valuation;

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
@Table(name = "property_transaction_type", schema = "valuation", uniqueConstraints = { @UniqueConstraint(name = "property_transaction_type_display_value", columnNames = { "display_value" })})
@Comment("List of the property transaction types in a collection")
public class PropertyTransactionType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the property transaction type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the property transaction type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the property transaction type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the property transaction type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "transaction_type")
	private TransactionPrice transaction_price;
	
}
package com.jdvn.devtech.datamodel.schema.transaction;

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
@Table(name = "transaction_status_type", schema = "transaction", uniqueConstraints = { 
		@UniqueConstraint(name = "transaction_status_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of transaction status types. E.g. pending, approved, cancelled, completed.")
public class TransactionStatusType{
	@Id
	@Column(length = 40, nullable = false)
	@Comment("Code of the transaction status type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the transaction status type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the transaction status type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the transaction status type as active (a) or inactive (i).")
	private char status;
	
	@OneToOne(mappedBy = "transaction_status_type")
	private Transaction transaction;
	
}
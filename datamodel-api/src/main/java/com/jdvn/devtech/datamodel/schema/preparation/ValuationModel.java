package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.transaction.Transaction;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "valuation_model", schema = "preparation", uniqueConstraints = {
		@UniqueConstraint(name = "valuation_model_name_version", columnNames = { "name", "version"  }) })
@Comment("Used to store information about valuation model. it includes attributes such as transaction, version to trace inputs and outputs of model implementation")
public class ValuationModel {

	@Id
	@Comment("Identifier of the model.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation model.")
	private String name;

	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "transaction_id", foreignKey = @ForeignKey(name = "valuation_model_transaction_id_fkey"))
	@Comment("Identifier to which transaction is on valuation activities.")
	private Transaction transaction;

	@Comment("Version number of the model as system can support many versions in each transaction.")
	private Integer version;

}
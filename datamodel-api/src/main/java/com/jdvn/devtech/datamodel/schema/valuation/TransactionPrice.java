package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

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
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "transaction_price", schema = "valuation", indexes = {@Index(name = "transaction_price_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Represents the information related to property transactions.")
public class TransactionPrice extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The contract or declaration identifier.")
	private String id;	
	
	@Comment("The date that contract or declaration implement.")
	private Date contract_date;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Price of property in transaction implementation.")
	private Double transaction_price;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "transaction_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "transaction_price_transaction_type_code_fkey"))
    private PropertyTransactionType transaction_type;
	    
	@Override
	public String print() {
		return id;
	}
	

}
package com.jdvn.devtech.datamodel.schema.transaction;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

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
@Table(name = "bulk_operation_valuation", schema = "transaction", indexes = {
		@Index(name = "bulk_operation_valuation_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "bulk_operation_valuation_transaction_id_fkey_ind", columnList = "transaction_id"),
		@Index(name = "bulk_operation_valuation_vunit_id_fkey_ind", columnList = "vunit_id")})
@Comment("Used as a staging area when process valuation unit objects with the bulk operations functionality. "
		+ "Data in this table is validated prior to update into the Valuation table.")
public class BulkOperationValuation extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The identifier of the record for valuation unit.")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "transaction_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "bulk_operation_valuation_transaction_id_fkey"))
	@Comment("The identifier of the transation associated to the bulk operation.")
    private Transaction transaction;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "vunit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "bulk_operation_valuation_vunit_id_fkey"))
    private ValuationUnit valuation_unit;

    @Column(columnDefinition = "boolean NOT NULL DEFAULT false")
    @Comment("Flag used to indicate the value of this valuation unit is used to run model.")
    private Boolean used_in_model_sample;

	@Column(columnDefinition = "numeric(20,2)")
	@Comment("Value of valuation unit in investigation or survey in numeric.")
	private Double surveyed_value;
	
	@Column(columnDefinition = "numeric(20,2)")
	@Comment("Value of valuation unit assessed by operation process in numeric.")
	private Double assessed_value;
	    
	@Override
	public String print() {
		return id;
	}
	

}
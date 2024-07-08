package com.jdvn.devtech.datamodel.schema.valuation;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "valuation_unit_has_transaction_price", schema = "valuation", indexes = {
		@Index(name = "valuation_unit_has_transaction_price_vunit_id_fkey_ind", columnList = "vunit_id"), 
		@Index(name = "valuation_unit_has_transaction_price_transaction_id_fkey_ind", columnList = "transaction_id"),
		@Index(name = "valuation_unit_has_transaction_price_index_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Links the valuation unit to the its recorded transaction price.")
@IdClass(TransactionUnitId.class)
public class ValuationUnitHasTransactionPrice extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the valuation unit the record is associated to.")
	private String vunit_id;
	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier of the contract or declaration of property transaction price.")
	private String transaction_id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "valuation_unit_has_transaction_price_vunit_id_fkey"))
    @Comment("Reference to a valuation unit.")
    private ValuationUnit valuation_unit;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "transaction_id", foreignKey = @ForeignKey(name = "valuation_unit_has_transaction_price_transaction_id_fkey"))
    @Comment("Reference to a property transaction price.")
    private TransactionPrice transaction_price;
    
	@Override
	public String getId() {
		return vunit_id + "_" + transaction_id;
	}	
	@Override
	public String print() {
		return vunit_id + "_" + transaction_id;
	}
}
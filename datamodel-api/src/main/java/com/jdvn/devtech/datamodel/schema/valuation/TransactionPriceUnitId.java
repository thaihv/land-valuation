package com.jdvn.devtech.datamodel.schema.valuation;

import java.io.Serializable;

public class TransactionPriceUnitId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String vunit_id;
	private String transaction_price_id;

	public TransactionPriceUnitId() {

	}

	public TransactionPriceUnitId(String vunit_id, String transaction_id) {
		this.vunit_id = vunit_id;
		this.transaction_price_id = transaction_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((vunit_id == null) ? 0 : vunit_id.hashCode());
		result = prime * result + ((transaction_price_id == null) ? 0 : transaction_price_id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TransactionPriceUnitId other = (TransactionPriceUnitId) obj;
		if (vunit_id == null) {
			if (other.vunit_id != null)
				return false;
		} else if (!vunit_id.equals(other.vunit_id))
			return false;
		if (transaction_price_id == null) {
			if (other.transaction_price_id != null)
				return false;
		} else if (!transaction_price_id.equals(other.transaction_price_id))
			return false;
		return true;
	}

}
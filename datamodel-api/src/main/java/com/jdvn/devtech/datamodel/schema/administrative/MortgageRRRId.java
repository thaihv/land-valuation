package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class MortgageRRRId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String mortgage_id;
	private String rrr_id;

	public MortgageRRRId() {

	}

	public MortgageRRRId(String rrr_id, String mortgage_id) {
		this.rrr_id = rrr_id;
		this.mortgage_id = mortgage_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rrr_id == null) ? 0 : rrr_id.hashCode());
		result = prime * result + ((mortgage_id == null) ? 0 : mortgage_id.hashCode());
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
		MortgageRRRId other = (MortgageRRRId) obj;
		if (rrr_id == null) {
			if (other.rrr_id != null)
				return false;
		} else if (!rrr_id.equals(other.rrr_id))
			return false;
		if (mortgage_id == null) {
			if (other.mortgage_id != null)
				return false;
		} else if (!mortgage_id.equals(other.mortgage_id))
			return false;
		return true;
	}

}
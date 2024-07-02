package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class PartyRRRId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String rrr_id;
	private String party_id;

	public PartyRRRId() {

	}

	public PartyRRRId(String rrr_id, String party_id) {
		this.rrr_id = rrr_id;
		this.party_id = party_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rrr_id == null) ? 0 : rrr_id.hashCode());
		result = prime * result + ((party_id == null) ? 0 : party_id.hashCode());
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
		PartyRRRId other = (PartyRRRId) obj;
		if (rrr_id == null) {
			if (other.rrr_id != null)
				return false;
		} else if (!rrr_id.equals(other.rrr_id))
			return false;
		if (party_id == null) {
			if (other.party_id != null)
				return false;
		} else if (!party_id.equals(other.party_id))
			return false;
		return true;
	}

}
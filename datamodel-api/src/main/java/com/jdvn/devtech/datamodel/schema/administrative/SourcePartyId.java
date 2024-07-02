package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class SourcePartyId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String party_id;
	private String source_id;

	public SourcePartyId() {

	}

	public SourcePartyId(String party_id, String source_id) {
		this.party_id = party_id;
		this.source_id = source_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((party_id == null) ? 0 : party_id.hashCode());
		result = prime * result + ((source_id == null) ? 0 : source_id.hashCode());
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
		SourcePartyId other = (SourcePartyId) obj;
		if (party_id == null) {
			if (other.party_id != null)
				return false;
		} else if (!party_id.equals(other.party_id))
			return false;
		if (source_id == null) {
			if (other.source_id != null)
				return false;
		} else if (!source_id.equals(other.source_id))
			return false;
		return true;
	}

}
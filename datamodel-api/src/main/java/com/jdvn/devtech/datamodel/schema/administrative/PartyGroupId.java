package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class PartyGroupId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String party_id;
	private String group_id;

	public PartyGroupId() {

	}

	public PartyGroupId(String party_id, String group_id) {
		this.party_id = party_id;
		this.group_id = group_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((party_id == null) ? 0 : party_id.hashCode());
		result = prime * result + ((group_id == null) ? 0 : group_id.hashCode());
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
		PartyGroupId other = (PartyGroupId) obj;
		if (party_id == null) {
			if (other.party_id != null)
				return false;
		} else if (!party_id.equals(other.party_id))
			return false;
		if (group_id == null) {
			if (other.group_id != null)
				return false;
		} else if (!group_id.equals(other.group_id))
			return false;
		return true;
	}

}
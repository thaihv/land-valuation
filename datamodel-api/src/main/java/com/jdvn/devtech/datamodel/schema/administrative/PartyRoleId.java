package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class PartyRoleId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String party_id;
	private String type_code;

	public PartyRoleId() {

	}

	public PartyRoleId(String party_id, String type_code) {
		this.party_id = party_id;
		this.type_code = type_code;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((party_id == null) ? 0 : party_id.hashCode());
		result = prime * result + ((type_code == null) ? 0 : type_code.hashCode());
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
		PartyRoleId other = (PartyRoleId) obj;
		if (party_id == null) {
			if (other.party_id != null)
				return false;
		} else if (!party_id.equals(other.party_id))
			return false;
		if (type_code == null) {
			if (other.type_code != null)
				return false;
		} else if (!type_code.equals(other.type_code))
			return false;
		return true;
	}

}
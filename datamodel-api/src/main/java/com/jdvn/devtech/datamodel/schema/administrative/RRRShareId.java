package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class RRRShareId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String rrr_id;
	private String id;

	public RRRShareId() {

	}

	public RRRShareId(String rrr_id, String id) {
		this.rrr_id = rrr_id;
		this.id = id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rrr_id == null) ? 0 : rrr_id.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		RRRShareId other = (RRRShareId) obj;
		if (rrr_id == null) {
			if (other.rrr_id != null)
				return false;
		} else if (!rrr_id.equals(other.rrr_id))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
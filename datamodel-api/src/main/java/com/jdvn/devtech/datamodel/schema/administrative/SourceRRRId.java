package com.jdvn.devtech.datamodel.schema.administrative;

import java.io.Serializable;

public class SourceRRRId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String rrr_id;
	private String source_id;

	public SourceRRRId() {

	}

	public SourceRRRId(String rrr_id, String source_id) {
		this.rrr_id = rrr_id;
		this.source_id = source_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rrr_id == null) ? 0 : rrr_id.hashCode());
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
		SourceRRRId other = (SourceRRRId) obj;
		if (rrr_id == null) {
			if (other.rrr_id != null)
				return false;
		} else if (!rrr_id.equals(other.rrr_id))
			return false;
		if (source_id == null) {
			if (other.source_id != null)
				return false;
		} else if (!source_id.equals(other.source_id))
			return false;
		return true;
	}

}
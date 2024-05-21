package com.jdvn.devtech.datamodel.schema.valuation;

import java.io.Serializable;

public class SourceUnitId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String vunit_id;
	private String source_id;

	public SourceUnitId() {

	}

	public SourceUnitId(String vunit_id, String source_id) {
		this.vunit_id = vunit_id;
		this.source_id = source_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((vunit_id == null) ? 0 : vunit_id.hashCode());
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
		SourceUnitId other = (SourceUnitId) obj;
		if (vunit_id == null) {
			if (other.vunit_id != null)
				return false;
		} else if (!vunit_id.equals(other.vunit_id))
			return false;
		if (source_id == null) {
			if (other.source_id != null)
				return false;
		} else if (!source_id.equals(other.source_id))
			return false;
		return true;
	}

}
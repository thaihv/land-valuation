package com.jdvn.devtech.datamodel.schema.preparation;

import java.io.Serializable;

public class SetingId implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;
	private String key;

	public SetingId() {

	}

	public SetingId(Long id, String key) {
		this.id = id;
		this.key = key;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((key == null) ? 0 : key.hashCode());
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
		SetingId other = (SetingId) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (key == null) {
			if (other.key != null)
				return false;
		} else if (!key.equals(other.key))
			return false;
		return true;
	}

}
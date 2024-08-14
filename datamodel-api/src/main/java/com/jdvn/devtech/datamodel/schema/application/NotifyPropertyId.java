package com.jdvn.devtech.datamodel.schema.application;

import java.io.Serializable;

public class NotifyPropertyId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String notify_id;
	private String vunit_id;

	public NotifyPropertyId() {

	}

	public NotifyPropertyId(String notify_id, String vunit_id) {
		this.notify_id = notify_id;
		this.vunit_id = vunit_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((notify_id == null) ? 0 : notify_id.hashCode());
		result = prime * result + ((vunit_id == null) ? 0 : vunit_id.hashCode());
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
		NotifyPropertyId other = (NotifyPropertyId) obj;
		if (notify_id == null) {
			if (other.notify_id != null)
				return false;
		} else if (!notify_id.equals(other.notify_id))
			return false;
		if (vunit_id == null) {
			if (other.vunit_id != null)
				return false;
		} else if (!vunit_id.equals(other.vunit_id))
			return false;
		return true;
	}

}
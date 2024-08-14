package com.jdvn.devtech.datamodel.schema.application;

import java.io.Serializable;

public class NotifySourceId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String notify_id;
	private String source_id;

	public NotifySourceId() {

	}

	public NotifySourceId(String notify_id, String source_id) {
		this.notify_id = notify_id;
		this.source_id = source_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((notify_id == null) ? 0 : notify_id.hashCode());
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
		NotifySourceId other = (NotifySourceId) obj;
		if (notify_id == null) {
			if (other.notify_id != null)
				return false;
		} else if (!notify_id.equals(other.notify_id))
			return false;
		if (source_id == null) {
			if (other.source_id != null)
				return false;
		} else if (!source_id.equals(other.source_id))
			return false;
		return true;
	}

}
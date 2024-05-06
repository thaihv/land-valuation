package com.jdvn.devtech.datamodel.schema.application;

import java.io.Serializable;

public class ApplicationSourceId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String application_id;
	private String source_id;

	public ApplicationSourceId() {

	}

	public ApplicationSourceId(String application_id, String source_id) {
		this.application_id = application_id;
		this.source_id = source_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((application_id == null) ? 0 : application_id.hashCode());
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
		ApplicationSourceId other = (ApplicationSourceId) obj;
		if (application_id == null) {
			if (other.application_id != null)
				return false;
		} else if (!application_id.equals(other.application_id))
			return false;
		if (source_id == null) {
			if (other.source_id != null)
				return false;
		} else if (!source_id.equals(other.source_id))
			return false;
		return true;
	}

}
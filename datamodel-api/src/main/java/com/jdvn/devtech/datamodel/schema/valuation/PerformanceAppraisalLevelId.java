package com.jdvn.devtech.datamodel.schema.valuation;

import java.io.Serializable;

public class PerformanceAppraisalLevelId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String performance_id;
	private String level_code;

	public PerformanceAppraisalLevelId() {

	}

	public PerformanceAppraisalLevelId(String performance_id, String level_code) {
		this.performance_id = performance_id;
		this.level_code = level_code;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((performance_id == null) ? 0 : performance_id.hashCode());
		result = prime * result + ((level_code == null) ? 0 : level_code.hashCode());
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
		PerformanceAppraisalLevelId other = (PerformanceAppraisalLevelId) obj;
		if (performance_id == null) {
			if (other.performance_id != null)
				return false;
		} else if (!performance_id.equals(other.performance_id))
			return false;
		if (level_code == null) {
			if (other.level_code != null)
				return false;
		} else if (!level_code.equals(other.level_code))
			return false;
		return true;
	}

}
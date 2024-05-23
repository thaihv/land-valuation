package com.jdvn.devtech.datamodel.schema.valuation;

import java.io.Serializable;

public class PerformanceAppraisalUniformityId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String performance_id;
	private String uniformity_code;

	public PerformanceAppraisalUniformityId() {

	}

	public PerformanceAppraisalUniformityId(String performance_id, String uniformity_code) {
		this.performance_id = performance_id;
		this.uniformity_code = uniformity_code;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((performance_id == null) ? 0 : performance_id.hashCode());
		result = prime * result + ((uniformity_code == null) ? 0 : uniformity_code.hashCode());
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
		PerformanceAppraisalUniformityId other = (PerformanceAppraisalUniformityId) obj;
		if (performance_id == null) {
			if (other.performance_id != null)
				return false;
		} else if (!performance_id.equals(other.performance_id))
			return false;
		if (uniformity_code == null) {
			if (other.uniformity_code != null)
				return false;
		} else if (!uniformity_code.equals(other.uniformity_code))
			return false;
		return true;
	}

}
package com.jdvn.devtech.datamodel.schema.valuation;

import java.io.Serializable;

public class UnitParameterId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String unit_id;
	private String parameter_code;

	public UnitParameterId() {

	}

	public UnitParameterId(String unit_id, String parameter_id) {
		this.unit_id = unit_id;
		this.parameter_code = parameter_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((unit_id == null) ? 0 : unit_id.hashCode());
		result = prime * result + ((parameter_code == null) ? 0 : parameter_code.hashCode());
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
		UnitParameterId other = (UnitParameterId) obj;
		if (unit_id == null) {
			if (other.unit_id != null)
				return false;
		} else if (!unit_id.equals(other.unit_id))
			return false;
		if (parameter_code == null) {
			if (other.parameter_code != null)
				return false;
		} else if (!parameter_code.equals(other.parameter_code))
			return false;
		return true;
	}

}
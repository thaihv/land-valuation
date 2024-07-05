package com.jdvn.devtech.datamodel.schema.valuation;

import java.io.Serializable;

public class VUnitSpatialUnitId implements Serializable {

	private static final long serialVersionUID = 1L;

	private String vunit_id;
	private String spatial_unit_id;

	public VUnitSpatialUnitId() {

	}

	public VUnitSpatialUnitId(String vunit_id, String spatial_unit_id) {
		this.vunit_id = vunit_id;
		this.spatial_unit_id = spatial_unit_id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((vunit_id == null) ? 0 : vunit_id.hashCode());
		result = prime * result + ((spatial_unit_id == null) ? 0 : spatial_unit_id.hashCode());
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
		VUnitSpatialUnitId other = (VUnitSpatialUnitId) obj;
		if (vunit_id == null) {
			if (other.vunit_id != null)
				return false;
		} else if (!vunit_id.equals(other.vunit_id))
			return false;
		if (spatial_unit_id == null) {
			if (other.spatial_unit_id != null)
				return false;
		} else if (!spatial_unit_id.equals(other.spatial_unit_id))
			return false;
		return true;
	}

}
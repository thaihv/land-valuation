package com.jdvn.devtech.util.performance.regression;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class RegressionEntityGroup {
	private String fName;
	private List<RegressionVariableEntity> fEntities;
	
	public RegressionEntityGroup() {
		this("");
	}

	public RegressionEntityGroup(String name) {
		this(name, new ArrayList<RegressionVariableEntity>());
	}

	public RegressionEntityGroup(String name,
			List<RegressionVariableEntity> entities) {
		fName = name;
		fEntities = entities;
	}

	public void addValue(String entityName, double val) {
		RegressionVariableEntity rve = new RegressionVariableEntity(entityName);
		addEntity(rve);
		getEntity(entityName).addValue(val);
	}

	private void addEntity(RegressionVariableEntity e) {
		for (RegressionVariableEntity rve : fEntities) {
			if (rve.getName().equals(e.getName())) {
				return;
			}
		}
		fEntities.add(e);

	}

	public RegressionVariableEntity getEntity(String entityName) {
		for (RegressionVariableEntity rve : fEntities) {
			if (rve.getName().equals(entityName)) {
				return rve;
			}
		}
		return null;
	}

	public void fix() {
		fix(RegressionVariable.REFERENCE_TYPE_FIRST);
	}

	public void fix(int referenceType) {
		for (int i = fEntities.size() - 1; i >= 0; i--) {
			RegressionVariableEntity rve = fEntities.get(i);
			rve.doValidate();
			rve.setUse(true);
		}

		if (fEntities.size() == 1) {
			return;
		}

		if (referenceType == RegressionVariable.REFERENCE_TYPE_FIRST) {
			for (int i = 0; i < fEntities.size() ; i++) {
				RegressionVariableEntity rve = fEntities.get(i);
				if (rve.getValidateValue() != Double.MIN_VALUE) {
					continue;
				} else {
					rve.setValidateValue(0);
					rve.setUse(false);
					rve.setReference(true);
					break;
				}
			}
		} else {
			for (int i = fEntities.size() - 1; i >= 0; i--) {
				RegressionVariableEntity rve = fEntities.get(i);
				if (rve.getValidateValue() != Double.MIN_VALUE) {
					continue;
				} else {
					rve.setValidateValue(0);
					rve.setUse(false);
					rve.setReference(true);
					break;
				}
			}
		}
		sort();
	}

	public String getName() {
		return fName;
	}

	public void setName(String name) {
		fName = name;
	}

	public List<RegressionVariableEntity> getAvailableEntities() {
		List<RegressionVariableEntity> entities = new ArrayList<>();
		for (RegressionVariableEntity rve : fEntities) {
			if (rve.isAvailable()) {
				entities.add(rve);
			}
		}
		return entities;
	}

	public List<RegressionVariableEntity> getEntities() {
		List<RegressionVariableEntity> retFEntities = null;
		if (this.fEntities != null) {
			retFEntities = new ArrayList<RegressionVariableEntity>(this.fEntities.size());
			retFEntities.addAll(this.fEntities);
		}
		return retFEntities;
	}

	public void setEntities(List<RegressionVariableEntity> entities) {
		fEntities = entities;
	}

	public void setItem(String item) {
		setItem(item, item);
	}
	
	public void setItem(String title, String item) {
		RegressionVariableEntity rve = new RegressionVariableEntity(title, item);
		rve.setParent(this);
		addEntity(rve);
	}

	public void addItemValue(String itemVal) {
		for (RegressionVariableEntity rve : getEntities()) {
			if (rve.getName().equals(itemVal)) {
				rve.addValue(1);
			} else {
				rve.addValue(0);
			}
		}

	}
	
	public int getMatchedCount(String itemVal) {
		int cnt = 0;
		for (RegressionVariableEntity rve : getEntities()) {
			if (rve.getName().equals(itemVal)) {
				for(Double d : rve.getValues()) {
					if(d.intValue() == 1) {
						cnt ++;
					}
				}
				return cnt;
			}
		}
		return cnt;
	}
	
	public void sort() {
		sort(RegressionVariable.SORT_DESCENDING);
	}
	
	public void sort(int sortType) {
		Collections.sort(fEntities, new RegressionVariableEntity());
		if(sortType == RegressionVariable.SORT_DESCENDING) {
			Collections.reverse(fEntities);
		}
	}

	public List<RegressionVariableEntity> getItems() {
		return fEntities;
	}
}

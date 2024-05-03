package com.jdvn.devtech.util.regression;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RegressionVariableEntity implements Comparator<RegressionVariableEntity> {
	private String fName = "";
	private RegressionEntityGroup fParent;

	private List<Double> fValues = new ArrayList<Double>();

	private boolean isUse = false;
	private double fValidateValue = Double.MIN_VALUE;
	private Map<String, Object> fUserData = new HashMap<String, Object>();

	private double SF;

	private double BETA;

	private double SE;

	private double T;

	private double ST;

	private double VIF;

	private boolean isReference = false;

	private String fTitle;

	public RegressionVariableEntity() {
		this("");
	}

	public RegressionVariableEntity(String name) {
		this(name, name, new ArrayList<Double>());
	}

	public RegressionVariableEntity(String title, String name) {
		this(title, name, new ArrayList<Double>());
	}

	public RegressionVariableEntity(String name, List<Double> values) {
		this(name, name, values);
	}

	public RegressionVariableEntity(String title, String name, List<Double> values) {
		fTitle = title;
		fName = name;
		fValues = values;
	}

	public void addValue(double val) {
		fValues.add(val);
	}

	public boolean isAvailable() {
		if (isUse && fValidateValue == Double.MIN_VALUE) {
			return true;
		}

		return false;
	}

	public void doValidate() {
		validate();
	}

	private void validate() {
		double oldVal = Double.MIN_VALUE;
		for (int i = 0; i < fValues.size(); i++) {
			if (i == 0) {
				oldVal = fValues.get(i);
			} else {
				if (oldVal != fValues.get(i)) {
					return;
				}
			}
		}

		fValidateValue = oldVal;
	}

	public void putUserData(String string, Object rSq) {
		fUserData.put(string, rSq);

	}

	public Object getUserData(String string) {
		return fUserData.get(string);

	}

	public String getName() {
		return fName;
	}

	public String getTitle() {
		return fTitle;
	}

	public void setTitle(String fTitle) {
		this.fTitle = fTitle;
	}

	public void setName(String name) {
		fName = name;
	}

	public List<Double> getValues() {
		return fValues;
	}

	public void setValues(List<Double> values) {
		fValues = values;
	}

	public int getMatchedCount() {
		int cnt = 0;
		for (double d : fValues) {
			if (d == 1) {
				cnt++;
			}
		}
		return cnt;
	}

	public boolean isUse() {
		return isUse;
	}

	public void setUse(boolean isUse) {
		this.isUse = isUse;
	}

	public double getValidateValue() {
		return fValidateValue;
	}

	public void setValidateValue(double validateValue) {
		fValidateValue = validateValue;
	}

	public double getSF() {
		return SF;
	}

	public void setSF(double sF) {
		SF = sF;
	}

	public double getBETA() {
		return BETA;
	}

	public double getPowBETA() {
		return Math.pow(Math.E, BETA);
	}

	public void setBETA(double bETA) {
		BETA = bETA;
	}

	public double getSE() {
		return SE;
	}

	public void setSE(double sE) {
		SE = sE;
	}

	public double getT() {
		return T;
	}

	public void setT(double t) {
		T = t;
	}

	public double getST() {
		return ST;
	}

	public void setST(double sT) {
		ST = sT;
	}

	public double getVIF() {
		return VIF;
	}

	public void setVIF(double vIF) {
		VIF = vIF;
	}

	public boolean isReference() {
		return isReference;
	}

	public void setReference(boolean isReference) {
		this.isReference = isReference;
	}

	public RegressionEntityGroup getParent() {
		return fParent;
	}

	public void setParent(RegressionEntityGroup fParent) {
		this.fParent = fParent;
	}

	@Override
	public int compare(RegressionVariableEntity o1, RegressionVariableEntity o2) {
		if (o1.getMatchedCount() > o2.getMatchedCount()) {
			return 1;
		} else if (o1.getMatchedCount() == o2.getMatchedCount()) {
			return 0;
		}
		return -1;
	}
}

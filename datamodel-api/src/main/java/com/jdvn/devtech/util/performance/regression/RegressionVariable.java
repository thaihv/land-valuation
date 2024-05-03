package com.jdvn.devtech.util.performance.regression;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import cern.colt.matrix.impl.DenseDoubleMatrix2D;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RegressionVariable implements Comparator<RegressionVariable> {

	public static int REFERENCE_TYPE_FIRST = 1;

	public static int REFERENCE_TYPE_LAST = 2;

	public int fReferenceType = REFERENCE_TYPE_LAST;

	private String fName = "";

	private RegressionVariableEntity fDependentVariable;

	private List<RegressionEntityGroup> fIndependentGroups = new ArrayList<RegressionEntityGroup>();

	private double SSE;

	private double MSE;

	private double SSR;

	private double MSR;

	private double SST;

	private double F;

	private double RSQ;

	private double MDRSQ;

	private double R;

	private int DFR;

	private int DFE;

	private int DF;

	private double SF;

	public static int SORT_DESCENDING = 1;
	public static int SORT_ASCENDING = 2;

	public RegressionVariable() {
		this("");
	}

	public RegressionVariable(String name) {
		fName = name;
	}

	public void addIndepedentGroup(RegressionEntityGroup group) {
		for (RegressionEntityGroup reg : fIndependentGroups) {
			if (group.getName().equals(reg.getName())) {
				return;
			}
		}
		fIndependentGroups.add(group);
	}

	public void addIndepedentValue(String groupName, String variableName, double value) {
		addIndepedentGroup(groupName);
		for (RegressionEntityGroup reg : fIndependentGroups) {
			if (groupName.equals(reg.getName())) {
				reg.addValue(variableName, value);
				return;
			}
		}
	}

	public void fix() {
		fix(REFERENCE_TYPE_LAST);
	}

	public void sort() {
		sort(SORT_DESCENDING);
	}

	public void sort(int sortType) {
		for (RegressionEntityGroup reg : fIndependentGroups) {
			reg.sort(sortType);
		}
	}

	public void fix(int referenceType) {
		for (RegressionEntityGroup reg : fIndependentGroups) {
			reg.fix(referenceType);
		}
	}

	public void removeGroup(int idx) {
		RegressionEntityGroup reg = fIndependentGroups.get(fIndependentGroups.size() - idx);
		for (RegressionVariableEntity rve : reg.getAvailableEntities()) {
			rve.setUse(false);
		}
	}

	public void addDepedentValue(double value) {
		fDependentVariable.addValue(value);
	}

	public List<RegressionVariableEntity> getAvailableIndependentEntities() {
		List<RegressionVariableEntity> entities = new ArrayList<>();
		for (RegressionEntityGroup reg : fIndependentGroups) {
			entities.addAll(reg.getAvailableEntities());
		}

		return entities;
	}

	public int getAvailableIndependentSize() {
		return getAvailableIndependentEntities().size();
	}

	public List<RegressionVariableEntity> getIndependentEntities() {
		List<RegressionVariableEntity> entities = new ArrayList<>();
		for (RegressionEntityGroup reg : fIndependentGroups) {
			entities.addAll(reg.getEntities());
		}

		return entities;
	}

	public RegressionEntityGroup getEntityGroup(String name) {
		for (RegressionEntityGroup reg : fIndependentGroups) {
			if (name.equals(reg.getName())) {
				return reg;
			}
		}
		return null;
	}

	public RegressionVariableEntity getAvailableEntity(int idx) {
		int i = 0;
		for (RegressionEntityGroup reg : fIndependentGroups) {
			for (RegressionVariableEntity rve : reg.getAvailableEntities()) {
				if (i == idx) {
					return rve;
				}
				i++;
			}
		}

		return null;
	}

	/**
	 * 
	 * @return DenseDoubleMatrix2D[]
	 */
	public DenseDoubleMatrix2D[] assignVariable() throws Exception {
		Double[] y = new Double[getDependentVariable().getValues().size()];
		y = getDependentVariable().getValues().toArray(y);

		double[] x = new double[y.length * getAvailableIndependentSize()];

		int idx = 0;
		for (int i = 0; i < y.length; i++) {
			for (int j = 0; j < getAvailableIndependentSize(); j++, idx++) {
				List<RegressionVariableEntity> entities = getAvailableIndependentEntities();
				x[idx] = entities.get(j).getValues().get(i);
			}
		}

		int n = y.length; // 자료의 개수
		int n_iv = x.length / y.length; // 독립변수의 개수
		DenseDoubleMatrix2D X = new DenseDoubleMatrix2D(n, n_iv + 1); // 행렬X
		DenseDoubleMatrix2D Y = new DenseDoubleMatrix2D(n, 1); // 행렬Y
		try {
			if (x.length % n == 0) {
				for (int i = 0; i < n; i++)
					Y.setQuick(i, 0, y[i]); // 행렬Y
				int k = 0;
				X.assign(1);
				for (int i = 0; i < n; i++)
					for (int j = 1; j < n_iv + 1; j++, k++)
						X.setQuick(i, j, x[k]); // 행렬X
			} else {
				Exception e = new Exception("입력된 자료가 올바른지 확인하십시오.");
				throw e; // 예외를 발생시킴
			}
		} catch (Exception e) {
			log.error("에러가 발생하여 결과값을 얻을 수 없습니다." + e.getMessage());
			// e.printStackTrace(); // 에러메시지 출력
			throw e;
		}

		DenseDoubleMatrix2D[] D = new DenseDoubleMatrix2D[2];
		D[0] = X;
		D[1] = Y;
		return D;
	}

	public DenseDoubleMatrix2D[] assignVariableForVIF(int index) throws Exception {
		Double[] y = new Double[getAvailableEntity(index).getValues().size()];
		y = getAvailableEntity(index).getValues().toArray(y);

		List<RegressionVariableEntity> indeps = getVIFIndependentEntities(index);
		double[] x = new double[y.length * (indeps.size())];

		int idx = 0;
		for (int i = 0; i < y.length; i++) {
			for (int j = 0; j < indeps.size(); j++, idx++) {
				x[idx] = indeps.get(j).getValues().get(i);
			}
		}

		int n = y.length; // 자료의 개수
		int n_iv = x.length / y.length; // 독립변수의 개수
		DenseDoubleMatrix2D X = new DenseDoubleMatrix2D(n, n_iv + 1); // 행렬X
		DenseDoubleMatrix2D Y = new DenseDoubleMatrix2D(n, 1); // 행렬Y
		try {
			if (x.length % n == 0) {
				for (int i = 0; i < n; i++)
					Y.setQuick(i, 0, y[i]); // 행렬Y
				int k = 0;
				X.assign(1);
				for (int i = 0; i < n; i++)
					for (int j = 1; j < n_iv + 1; j++, k++)
						X.setQuick(i, j, x[k]); // 행렬X
			} else {
				Exception e = new Exception("입력된 자료가 올바른지 확인하십시오.");
				throw e; // 예외를 발생시킴
			}
		} catch (Exception e) {
			log.error("에러가 발생하여 결과값을 얻을 수 없습니다." + e.getMessage());
			// e.printStackTrace(); // 에러메시지 출력
			throw e;
		}

		DenseDoubleMatrix2D[] D = new DenseDoubleMatrix2D[2];
		D[0] = X;
		D[1] = Y;
		return D;
	}

	private List<RegressionVariableEntity> getVIFIndependentEntities(int index) {
		List<RegressionVariableEntity> entities = new ArrayList<>();
		for (int i = 0; i < getAvailableIndependentSize(); i++) {
			if (i == index) {
				continue;
			} else {
				entities.add(getAvailableEntity(i));
			}
		}

		return entities;
	}

	public String getName() {
		return fName;
	}

	public void setName(String name) {
		fName = name;
	}

	public RegressionVariableEntity getDependentVariable() {
		return fDependentVariable;
	}

	public void setDependentVariable(RegressionVariableEntity dependentVariable) {
		fDependentVariable = dependentVariable;
	}

	public void addDepedentVariable(String string) {
		fDependentVariable = new RegressionVariableEntity(string);

	}

	public void addIndepedentGroup(String groupName) {
		RegressionEntityGroup entity = new RegressionEntityGroup(groupName);
		addIndepedentGroup(entity);
	}

	public List<RegressionEntityGroup> getIndependentGroups() {
		return fIndependentGroups;
	}

	public RegressionEntityGroup getIndependentGroupByName(String name) {
		for (RegressionEntityGroup reg : fIndependentGroups) {
			if (reg.getName().equalsIgnoreCase(name)) {
				return reg;
			}
		}
		return null;
	}

	public void setIndependentGroups(List<RegressionEntityGroup> independentGroups) {
		fIndependentGroups = independentGroups;
	}

	public double getSSE() {
		return SSE;
	}

	public void setSSE(double sSE) {
		SSE = sSE;
	}

	public double getMSE() {
		return MSE;
	}

	public void setMSE(double mSE) {
		MSE = mSE;
	}

	public double getSSR() {
		return SSR;
	}

	public void setSSR(double sSR) {
		SSR = sSR;
	}

	public double getMSR() {
		return MSR;
	}

	public void setMSR(double mSR) {
		MSR = mSR;
	}

	public double getSST() {
		return SST;
	}

	public void setSST(double sST) {
		SST = sST;
	}

	public double getF() {
		return F;
	}

	public void setF(double f) {
		F = f;
	}

	public double getRSQ() {
		return RSQ;
	}

	public void setRSQ(double rSq) {
		RSQ = rSq;
	}

	public double getMDRSQ() {
		return MDRSQ;
	}

	public void setMDRSQ(double mdRSq) {
		MDRSQ = mdRSq;
	}

	public double getR() {
		return R;
	}

	public void setR(double r) {
		R = r;
	}

	public int getDFR() {
		return DFR;
	}

	public void setDFR(int dFR) {
		DFR = dFR;
	}

	public int getDFE() {
		return DFE;
	}

	public void setDFE(int dFE) {
		DFE = dFE;
	}

	public int getDF() {
		return DF;
	}

	public void setDF(int dF) {
		DF = dF;
	}

	public double getSF() {
		return SF;
	}

	public void setSF(double sF) {
		SF = sF;
	}

	public void print() {
		DecimalFormat df = new DecimalFormat(",###.###");
		log.debug(fName);
		log.debug("R : " + df.format(getR()));
		log.debug("\t\tRSQ : " + df.format(getRSQ()));
		log.debug("\t\tMDRSQ : " + df.format(getMDRSQ()));
		log.debug("SSR : " + df.format(getSSR()));
		log.debug("\t\tDFR : " + df.format(getDFR()));
		log.debug("\t\tMSR : " + df.format(getMSR()));
		log.debug("\t\tF : " + df.format(getF()));
		log.debug("\t\tSF : " + df.format(getSF()));
		log.debug("SSE : " + df.format(getSSE()));
		log.debug("\t\tDFE : " + df.format(getDFE()));
		log.debug("\t\tMSE : " + df.format(getMSE()));
		log.debug("SST : " + df.format(getSST()));
		log.debug("\t\tDF : " + df.format(getDF()));
		log.debug("GROUP");
		log.debug("\t\t");
		log.debug("TITLE");
		log.debug("\t\t");
		log.debug("ITEM");
		log.debug("\t\tBETA  \t: " + df.format(fDependentVariable.getBETA()));
		log.debug("\t\t\tSE : " + df.format(fDependentVariable.getSE()));
		log.debug("\t\tT : " + df.format(fDependentVariable.getT()));
		log.debug("\t\tST : " + df.format(fDependentVariable.getST()));

		for (RegressionVariableEntity rve : getIndependentEntities()) {
			// if(rve.isAvailable()) {
			log.debug(rve.getParent().getName());
			log.debug("\t\t");

			log.debug(rve.getTitle());
			log.debug("\t\t");

			log.debug(rve.getName());
			log.debug("\t\tB");
			if (rve.isReference()) {
				log.debug("(R)");
			}
			log.debug("\t : " + df.format(rve.getBETA()) + "/" + df.format(rve.getPowBETA()));
			log.debug("\t\tSE : " + df.format(rve.getSE()));
			log.debug("\t\tT : " + df.format(rve.getT()));
			log.debug("\t\tST : " + df.format(rve.getST()));
			log.debug("\t\tVIF : " + df.format(rve.getVIF()));
		}
	}

	public void setItems(String group, List<String> items) {
		RegressionEntityGroup reg = getEntityGroup(group);
		for (String c : items) {
			reg.setItem(c);
		}
	}

	public void setItem(String group, String item, boolean isAddGroup) {
		if (isAddGroup) {
			RegressionEntityGroup reg = getEntityGroup(group);
			if (reg == null) {
				addIndepedentGroup(group);
				reg = getEntityGroup(group);
			}

			List<RegressionVariableEntity> vItems = reg.getItems();
			for (RegressionVariableEntity e : vItems) {
				if (e.getName().equals(item)) {
					return;
				}
			}
			reg.setItem(item);
		}
	}

	public void addItemValue(String group, String itemVal) {
		RegressionEntityGroup reg = getEntityGroup(group);
		reg.addItemValue(itemVal);
	}

	public void addNumericValue(String group, double numVal) {
		RegressionEntityGroup reg = getEntityGroup(group);
		reg.addValue(group, numVal);
	}

	public int getReferenceType() {
		return fReferenceType;
	}

	public void setReferenceType(int referenceType) {
		fReferenceType = referenceType;
	}

	public void setResult(RegressionProcess regression) {
		setR(regression.getR());
		setRSQ(regression.getRSQ());
		setMDRSQ(regression.getMDRSQ());
		setSSR(regression.getSSR());
		setDFR(regression.getDFR());
		setMSR(regression.getMSR());
		setF(regression.getF());
		setSF(regression.getSF());
		setSSE(regression.getSSE());
		setDFE(regression.getDFE());
		setMSE(regression.getMSE());
		setSST(regression.getSST());
		setDF(regression.getDF());

		getDependentVariable().setBETA(regression.getBETA().getQuick(0, 0));
		getDependentVariable().setSE(regression.getSE().get(0));
		getDependentVariable().setT(regression.getT().get(0));
		getDependentVariable().setST(regression.getST().get(0));

		int idx = 1;
		for (int i = 0; i < getIndependentEntities().size(); i++) {
			RegressionVariableEntity rve = getIndependentEntities().get(i);
			if (rve.isAvailable()) {
				rve.setBETA(regression.getBETA().getQuick(idx, 0));
				rve.setSE(regression.getSE().get(idx));
				rve.setT(regression.getT().get(idx));
				rve.setST(regression.getST().get(idx));

				idx++;
			} else {
				if (!rve.isUse()) {
					rve.setBETA(0);
				} else {
//					rve.setBETA(rve.getValidateValue());
					rve.setBETA(0);
				}
			}
		}
	}

	@Override
	public int compare(RegressionVariable o1, RegressionVariable o2) {
		return o1.getName().compareTo(o2.getName());
	}
}

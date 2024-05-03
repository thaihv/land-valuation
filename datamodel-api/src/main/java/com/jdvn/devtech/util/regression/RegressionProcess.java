package com.jdvn.devtech.util.regression;

import java.util.ArrayList;
import java.util.List;

import cern.colt.list.DoubleArrayList;
import cern.colt.matrix.impl.DenseDoubleMatrix2D;
import cern.colt.matrix.linalg.Algebra;
import cern.jet.stat.Gamma;
import cern.jet.stat.Probability;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RegressionProcess {

	DenseDoubleMatrix2D X;

	DenseDoubleMatrix2D Y;

	private DoubleArrayList SE;

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

	private DenseDoubleMatrix2D BETA;

	private DoubleArrayList T;

	private DoubleArrayList ST;

	/**
	 * 
	 * @param independantVariable ��������
	 * @param dependantVariable   ���Ӻ���
	 */
	public RegressionProcess(DenseDoubleMatrix2D independantVariable, DenseDoubleMatrix2D dependantVariable) {
		X = independantVariable;
		Y = dependantVariable;
	}

	public void process() {

		int n = Y.rows();
		int k = X.columns() - 1;

		log.debug("=============REGRESSION==================");
		log.debug("Y:" + Y);
		log.debug("X:" + X);
		log.debug("=============REGRESSION==================");

		Algebra al = new Algebra();

		DenseDoubleMatrix2D Xtr = (DenseDoubleMatrix2D) al.transpose(X);
		DenseDoubleMatrix2D XtrX = (DenseDoubleMatrix2D) al.mult(Xtr, X);
		DenseDoubleMatrix2D invXtrX = (DenseDoubleMatrix2D) al.inverse(XtrX);
		DenseDoubleMatrix2D XtrY = (DenseDoubleMatrix2D) al.mult(Xtr, Y);

		BETA = (DenseDoubleMatrix2D) al.mult(invXtrX, XtrY);

		DenseDoubleMatrix2D Ytr = (DenseDoubleMatrix2D) al.transpose(Y);
		DenseDoubleMatrix2D YtrY = (DenseDoubleMatrix2D) al.mult(Ytr, Y);
		DenseDoubleMatrix2D BETAtr = (DenseDoubleMatrix2D) al.transpose(BETA);
		DenseDoubleMatrix2D BETAtrXtrXBETA = (DenseDoubleMatrix2D) al.mult(al.mult(BETAtr, Xtr), al.mult(X, BETA));
		DenseDoubleMatrix2D EtrE = new DenseDoubleMatrix2D(YtrY.columns(), YtrY.rows());

		for (int i = 0; i < YtrY.columns(); i++) {
			for (int j = 0; j < YtrY.rows(); j++) {
				EtrE.setQuick(i, j, YtrY.getQuick(i, j) - BETAtrXtrXBETA.getQuick(i, j));
			}
		}

		DFR = k;
		DFE = n - k - 1;
		DF = DFR + DFE;

		SSE = EtrE.getQuick(0, 0);
		MSE = EtrE.getQuick(0, 0) / DFE;

		double Ybar = Y.zSum() / Y.size();

		SSR = BETAtrXtrXBETA.getQuick(0, 0) - Y.size() * Ybar * Ybar;
		MSR = SSR / DFR;

		SST = SSR + SSE;

		RSQ = (BETAtrXtrXBETA.getQuick(0, 0) - n * Ybar * Ybar) / (YtrY.getQuick(0, 0) - Y.size() * Ybar * Ybar);

		R = Math.sqrt(RSQ);

		MDRSQ = 1 - (n - k + 2) * MSE / SST;

		F = MSR / MSE;
		;
		SF = Gamma.incompleteBeta(DFE / 2.0, DFR / 2.0, DFE / (DFE + DFR * F));

		SE = new DoubleArrayList();
		for (int i = 0; i < k + 1; i++) {
			double SESq = invXtrX.getQuick(i, i) * MSE;
			SE.add(Math.sqrt(SESq));
		}

		T = new DoubleArrayList();
		for (int i = 0; i < k + 1; i++) {
			double t = BETA.getQuick(i, 0) / SE.get(i);
			T.add(t);
		}

		ST = new DoubleArrayList();
		for (int i = 0; i < k + 1; i++) {
			ST.add(2 * (1 - Probability.studentT((n - 1), Math.abs(T.get(i)))));
		}
	}

	public DoubleArrayList getSE() {
		return SE;
	}

	public void setSE(DoubleArrayList _SE) {
		SE = _SE;
	}

	public double getSSE() {
		return SSE;
	}

	public void setSSE(double _SSE) {
		SSE = _SSE;
	}

	public double getMSE() {
		return MSE;
	}

	public void setMSE(double _MSE) {
		MSE = _MSE;
	}

	public double getSSR() {
		return SSR;
	}

	public void setSSR(double _SSR) {
		SSR = _SSR;
	}

	public double getMSR() {
		return MSR;
	}

	public void setMSR(double _MSR) {
		MSR = _MSR;
	}

	public double getSST() {
		return SST;
	}

	public void setSST(double _SST) {
		SST = _SST;
	}

	public double getF() {
		return F;
	}

	public void setF(double _F) {
		F = _F;
	}

	public double getRSQ() {
		return RSQ;
	}

	public void setRSQ(double _RSQ) {
		RSQ = _RSQ;
	}

	public double getMDRSQ() {
		return MDRSQ;
	}

	public void setMDRSQ(double _MDRSQ) {
		MDRSQ = _MDRSQ;
	}

	public double getR() {
		return R;
	}

	public void setR(double _R) {
		R = _R;
	}

	public int getDFR() {
		return DFR;
	}

	public void setDFR(int _DFR) {
		DFR = _DFR;
	}

	public int getDFE() {
		return DFE;
	}

	public void setDFE(int _DFE) {
		DFE = _DFE;
	}

	public int getDF() {
		return DF;
	}

	public void setDF(int _DF) {
		DF = _DF;
	}

	public double getSF() {
		return SF;
	}

	public void setSF(double _SF) {
		SF = _SF;
	}

	public DenseDoubleMatrix2D getBETA() {
		return BETA;
	}

	public void setBETA(DenseDoubleMatrix2D _BETA) {
		BETA = _BETA;
	}

	public DoubleArrayList getT() {
		return T;
	}

	public void setT(DoubleArrayList _T) {
		T = _T;
	}

	public DoubleArrayList getST() {
		return ST;
	}

	public void setST(DoubleArrayList _ST) {
		ST = _ST;
	}

	public void calulateVIF(RegressionVariable rv) {
		List<RegressionVariableEntity> independentEntities = rv.getAvailableIndependentEntities();
		for (int i = 0; i < independentEntities.size(); i++) {
			try {
				List<RegressionVariableEntity> subs = new ArrayList<>();
				RegressionVariableEntity sy = null;
				for (int j = 0; j < independentEntities.size(); j++) {
					if (i == j) {
						sy = independentEntities.get(j);
					} else {
						subs.add(independentEntities.get(j));
					}
				}

				DenseDoubleMatrix2D[] d1 = rv.assignVariableForVIF(i);
				RegressionProcess subRt = new RegressionProcess(d1[0], d1[1]);
				subRt.process();
				double vif = 0.00;

				if (subRt.getRSQ() == 1) {
					vif = 99.99;
				} else {
					vif = (1 / (1 - subRt.getRSQ()));
				}

				sy.setVIF(vif);
				log.debug(sy.getName() + ":" + vif);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}

}
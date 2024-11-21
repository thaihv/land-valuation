package com.jdvn.devtech.util.performance.regression;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.Resource;

import com.jdvn.devtech.datamodel.DatamodelApplication;

import cern.colt.matrix.DoubleMatrix2D;
import cern.colt.matrix.impl.DenseDoubleMatrix2D;
import cern.colt.matrix.linalg.Algebra;

@SpringBootTest(classes=DatamodelApplication.class)
public class OLSRegressionTest {
	
    @Value("classpath:ols/dataset.csv")
    private Resource resource;
    // DataResult class to return both X and Y matrices      
    public void runOLSbyCommonsMath(DenseDoubleMatrix2D X, DenseDoubleMatrix2D Y) {
        // Convert the DenseDoubleMatrix2D to 2D arrays for Commons Math
        double[][] XData = new double[X.rows()][X.columns()];
        double[] YData = new double[Y.rows()];

        // Fill XData and YData
        for (int i = 0; i < X.rows(); i++) {
            for (int j = 0; j < X.columns(); j++) {
                XData[i][j] = X.get(i, j);
            }
            YData[i] = Y.get(i, 0);  // Assuming Y is a single column
        }

        // Create an instance of OLS regression model
        OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
        
        // Perform OLS regression
        regression.newSampleData(YData, XData);

        // Get regression coefficients
        double[] coefficients = regression.estimateRegressionParameters();

        // Get R-squared value
        double rSquared = regression.calculateRSquared();

        // Print results
        System.out.println("OLS Regression Results:");
        System.out.println("Coefficients (Intercept + X1, X2, ...):");
        for (int i = 0; i < coefficients.length; i++) {
            System.out.println("Coefficient for variable " + i + ": " + coefficients[i]);
        }

        System.out.println("R-squared: " + rSquared);
    }    
    public static DoubleMatrix2D addInterceptColumn(DoubleMatrix2D X) {
        int numRows = X.rows();
        int numCols = X.columns();

        // Create a new matrix with one additional column for the intercept
        DoubleMatrix2D XWithIntercept = new DenseDoubleMatrix2D(numRows, numCols + 1);

        for (int i = 0; i < numRows; i++) {
            XWithIntercept.set(i, 0, 1.0); // Set intercept column to 1
            for (int j = 0; j < numCols; j++) {
                XWithIntercept.set(i, j + 1, X.get(i, j));
            }
        }

        return XWithIntercept;
    }

    public static DoubleMatrix2D runOLSbyColt(DoubleMatrix2D X, DoubleMatrix2D Y) {
        Algebra algebra = new Algebra();

        // Compute X'X (transpose of X multiplied by X)
        DoubleMatrix2D XTranspose = algebra.transpose(X);
        DoubleMatrix2D XtX = algebra.mult(XTranspose, X);

        // Compute the inverse of X'X
        DoubleMatrix2D XtXInverse = algebra.inverse(XtX);

        // Compute X'Y (transpose of X multiplied by Y)
        DoubleMatrix2D XtY = algebra.mult(XTranspose, Y);

        // Compute the coefficients: Beta = (X'X)^-1 * X'Y
        DoubleMatrix2D beta = algebra.mult(XtXInverse, XtY);

        return beta;
    }

	@Test
	public void olsRegressionTest() throws Exception {
        try {
            // Specify the path to your CSV file, Y column name, and columns to exclude
            String csvFilePath = resource.getFile().getAbsolutePath();
            System.out.println("CSV File Path: " + csvFilePath);
            
            String yColumnName = "LN_3";  // Replace with your Y column name
            List<String> excludeColumns = List.of("gid","rdDst_1","rdDst_2");  // List of column names to exclude

            OLSUtils.DataResult dataResult = OLSUtils.loadData(csvFilePath, yColumnName, excludeColumns);            
            DecimalFormat df = new DecimalFormat("#.########");
            
            DenseDoubleMatrix2D X = dataResult.getX();
            DenseDoubleMatrix2D Y = dataResult.getY();
            
            System.out.println("X Matrix: " + X);
            for (int i = 0; i < Y.rows(); i++) {
                // Get the value at the ith row and 0th column (assuming Y is a single-column matrix)
                double yValue = Y.get(i, 0);

                // Print the value with the desired precision
                System.out.println("Y[" + i + "]: " + df.format(yValue));
            }
            
            System.out.println("Regression by Commons Math:");
            runOLSbyCommonsMath(X,Y);
            
            System.out.println("Regression by Colt:");
            X = (DenseDoubleMatrix2D) addInterceptColumn(X);
            // Perform OLS regression
            DoubleMatrix2D beta = runOLSbyColt(X, Y);
            
            System.out.println("Regression coefficients (Beta):");
            System.out.println(beta);     
            
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}
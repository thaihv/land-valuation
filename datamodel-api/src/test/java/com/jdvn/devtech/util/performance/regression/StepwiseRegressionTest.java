package com.jdvn.devtech.util.performance.regression;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.Resource;

import com.jdvn.devtech.datamodel.DatamodelApplication;

@SpringBootTest(classes=DatamodelApplication.class)
public class StepwiseRegressionTest {
	
    @Value("classpath:ols/dataset.csv")
    private Resource resource;  
    
//    public static DoubleMatrix1D calculateCoefficients(DoubleMatrix2D X, DoubleMatrix1D Y) {
//        Algebra algebra = new Algebra();
//        DoubleMatrix2D Xt = algebra.transpose(X);
//        DoubleMatrix2D XtX = algebra.mult(Xt, X);
//        DoubleMatrix2D XtXInv = algebra.inverse(XtX);
//        DoubleMatrix1D XtY = Xt.zMult(Y, null);
//
//        return XtXInv.zMult(XtY, null);
//    }        
//    public static Set<Integer> stepwiseRegression(DoubleMatrix2D X, DoubleMatrix1D Y) {
//        int numVariables = X.columns();
//        Set<Integer> includedVariables = new HashSet<>();
//        Set<Integer> excludedVariables = new HashSet<>();
//        for (int i = 0; i < numVariables; i++) excludedVariables.add(i);
//
//        boolean improved = true;
//        while (improved) {
//            improved = false;
//            Integer bestVariable = null;
//            double bestAdjustedR2 = -Double.MAX_VALUE;
//
//            // Try adding excluded variables
//            for (Integer var : excludedVariables) {
//                Set<Integer> testVariables = new HashSet<>(includedVariables);
//                testVariables.add(var);
//                double adjustedR2 = calculateAdjustedR2(X, Y, testVariables);
//
//                if (adjustedR2 > bestAdjustedR2) {
//                    bestAdjustedR2 = adjustedR2;
//                    bestVariable = var;
//                    improved = true;
//                }
//            }
//
//            // Add the best variable
//            if (bestVariable != null) {
//                includedVariables.add(bestVariable);
//                excludedVariables.remove(bestVariable);
//            }
//
//            // Try removing included variables
//            Integer worstVariable = null;
//            for (Integer var : includedVariables) {
//                Set<Integer> testVariables = new HashSet<>(includedVariables);
//                testVariables.remove(var);
//                double adjustedR2 = calculateAdjustedR2(X, Y, testVariables);
//
//                if (adjustedR2 > bestAdjustedR2) {
//                    bestAdjustedR2 = adjustedR2;
//                    worstVariable = var;
//                    improved = true;
//                }
//            }
//
//            // Remove the worst variable
//            if (worstVariable != null) {
//                includedVariables.remove(worstVariable);
//                excludedVariables.add(worstVariable);
//            }
//        }
//
//        return includedVariables;
//    }
//
//    public static double calculateAdjustedR2(DoubleMatrix2D X, DoubleMatrix1D Y, Set<Integer> variables) {
//        if (variables.isEmpty()) return -Double.MAX_VALUE;
//
//        DoubleMatrix2D reducedX = extractColumns(X, variables);
//        DoubleMatrix1D coefficients = calculateCoefficients(reducedX, Y);
//        DoubleMatrix1D predictions = reducedX.zMult(coefficients, null);
//
//        // Calculate mean of Y
//        double meanY = Y.zSum() / Y.size();
//
//        // Calculate Total Sum of Squares (TSS)
//        double totalSumOfSquares = Y.copy().assign(value -> Math.pow(value - meanY, 2)).zSum();
//
//        // Calculate Residual Sum of Squares (RSS)
//        double residualSumOfSquares = predictions.assign(Y, (a, b) -> Math.pow(a - b, 2)).zSum();
//
//        // Calculate R²
//        double r2 = 1 - (residualSumOfSquares / totalSumOfSquares);
//
//        // Adjust R²
//        int n = X.rows();
//        int k = variables.size();
//        return 1 - ((1 - r2) * (n - 1) / (n - k - 1));
//    }
//
//    public static DoubleMatrix2D extractColumns(DoubleMatrix2D X, Set<Integer> variables) {
//        int numRows = X.rows();
//        int numCols = variables.size();
//        DoubleMatrix2D reducedX = DoubleFactory2D.dense.make(numRows, numCols);
//
//        int colIndex = 0;
//        for (Integer var : variables) {
//            reducedX.viewColumn(colIndex++).assign(X.viewColumn(var));
//        }
//
//        return reducedX;
//    }

    public static double calculateAdjustedR2(double[][] X, double[] Y, Set<Integer> variables) {
        OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
        double[][] reducedX = extractColumns(X, variables);
        regression.newSampleData(Y, reducedX);
        
        double r2 = regression.calculateAdjustedRSquared();
        return r2;
    }

    public static double[][] extractColumns(double[][] X, Set<Integer> variables) {
        int numRows = X.length;
        int numCols = variables.size();
        double[][] reducedX = new double[numRows][numCols];
        
        int colIndex = 0;
        for (int var : variables) {
            for (int row = 0; row < numRows; row++) {
                reducedX[row][colIndex] = X[row][var];
            }
            colIndex++;
        }        
        return reducedX;
    }
    
    public static Set<Integer> stepwiseRegression(double[][] X, double[] Y) {
        int numVariables = X[0].length;
        Set<Integer> includedVariables = new HashSet<>();
        Set<Integer> excludedVariables = new HashSet<>();
        for (int i = 0; i < numVariables; i++) excludedVariables.add(i);
        
        boolean improved = true;
        while (improved) {
            improved = false;
            Integer bestVariable = null;
            double bestAdjustedR2 = -Double.MAX_VALUE;
            
            // Try adding excluded variables
            for (Integer var : excludedVariables) {
                Set<Integer> testVariables = new HashSet<>(includedVariables);
                testVariables.add(var);
                double adjustedR2 = calculateAdjustedR2(X, Y, testVariables);
                
                if (adjustedR2 > bestAdjustedR2) {
                    bestAdjustedR2 = adjustedR2;
                    bestVariable = var;
                    improved = true;
                }
            }
            
            // Add the best variable
            if (bestVariable != null) {
                includedVariables.add(bestVariable);
                excludedVariables.remove(bestVariable);
            }
            
            // Try removing included variables
            Integer worstVariable = null;
            for (Integer var : includedVariables) {
                Set<Integer> testVariables = new HashSet<>(includedVariables);
                testVariables.remove(var);
                double adjustedR2 = calculateAdjustedR2(X, Y, testVariables);
                
                if (adjustedR2 > bestAdjustedR2) {
                    bestAdjustedR2 = adjustedR2;
                    worstVariable = var;
                    improved = true;
                }
            }
            
            // Remove the worst variable
            if (worstVariable != null) {
                includedVariables.remove(worstVariable);
                excludedVariables.add(worstVariable);
            }
        }
        
        return includedVariables;
    }
    
	@Test
	public void stepwiseRegressionTest() throws Exception {
        String csvFilePath = resource.getFile().getAbsolutePath();
        System.out.println("CSV File Path: " + csvFilePath);
        
        String yColumnName = "LN_3";  // Replace with your Y column name
        List<String> excludeColumns = List.of("gid");  // List of column names to exclude

        OLSUtils.DataResult data = OLSUtils.loadData(csvFilePath, yColumnName, excludeColumns);
        
        // Perform stepwise regression
        System.out.println("Stepwise Regression :");
        double[][] X = data.getX().toArray();
        double[] Y = data.getY().toArray()[0];
        
        // Perform stepwise regression
        Set<Integer> selectedVariables = stepwiseRegression(X, Y);
        System.out.println("Selected Variables (Column Indices): " + selectedVariables);		

	}

}
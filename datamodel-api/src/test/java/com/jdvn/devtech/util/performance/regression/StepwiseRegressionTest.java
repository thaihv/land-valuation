package com.jdvn.devtech.util.performance.regression;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.Resource;

import com.jdvn.devtech.datamodel.DatamodelApplication;

import cern.colt.matrix.DoubleMatrix2D;
import cern.colt.matrix.impl.DenseDoubleMatrix2D;

@SpringBootTest(classes = DatamodelApplication.class)
public class StepwiseRegressionTest {

	@Value("classpath:ols/dataset.csv")
	private Resource resource;

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

	public static Set<Integer> stepwiseRegression(double[][] X, double[] Y, int maxIterations, double threshold) {
		int numVariables = X[0].length;
		Set<Integer> includedVariables = new HashSet<>();
		Set<Integer> excludedVariables = new HashSet<>();
		for (int i = 0; i < numVariables; i++)
			excludedVariables.add(i);

		// Estimate total work: adding + removing steps
		int totalWork = (int) Math.pow(numVariables, 2); // Rough estimate for the entire process
		int workDone = 0;

		boolean improved = true;
		double lastAdjustedR2 = -Double.MAX_VALUE;
		int iterations = 0;

		while (improved && iterations < maxIterations) {
			improved = false;
			iterations++;

			// Track variable addition
			Integer bestVariable = null;
			double bestAdjustedR2 = -Double.MAX_VALUE;

			// For each variable to add
			for (Integer var : new ArrayList<>(excludedVariables)) { // Avoid concurrent modification
				Set<Integer> testVariables = new HashSet<>(includedVariables);
				testVariables.add(var);

				double adjustedR2 = calculateAdjustedR2(X, Y, testVariables);
				if (adjustedR2 > bestAdjustedR2) {
					bestAdjustedR2 = adjustedR2;
					bestVariable = var;
					improved = true;
				}

				// Update global progress
				workDone++;
				logProgress(workDone, totalWork, "Adding variable: " + var);
			}

			if (bestVariable != null) {
				includedVariables.add(bestVariable);
				excludedVariables.remove(bestVariable);
			}

			// Track variable removal
			Integer worstVariable = null;

			// For each variable to remove
			for (Integer var : new ArrayList<>(includedVariables)) { // Avoid concurrent modification
				Set<Integer> testVariables = new HashSet<>(includedVariables);
				testVariables.remove(var);

				double adjustedR2 = calculateAdjustedR2(X, Y, testVariables);
				if (adjustedR2 > bestAdjustedR2) {
					bestAdjustedR2 = adjustedR2;
					worstVariable = var;
					improved = true;
				}

				// Update global progress
				workDone++;
				logProgress(workDone, totalWork, "Removing variable: " + var);
			}

			if (worstVariable != null) {
				includedVariables.remove(worstVariable);
				excludedVariables.add(worstVariable);
			}

			// Stop if the improvement is less than the threshold
			if (Math.abs(bestAdjustedR2 - lastAdjustedR2) < threshold) {
				System.out.println("No significant improvement, stopping...");
				break;
			}
			lastAdjustedR2 = bestAdjustedR2;

			// Adjust totalWork dynamically based on remaining variables
			totalWork = workDone + excludedVariables.size() + includedVariables.size();
			
            // Optional: Log progress of iterations
            System.out.println("Iteration " + iterations + ": Best Adjusted R² = " + bestAdjustedR2);
		}
		
		return includedVariables;
	}

	// Log progress with total and current progress
	public static void logProgress(int workDone, int totalWork, String message) {
		double percentDone = (double) workDone / totalWork * 100;
		System.out.printf("Progress: %d/%d (%.2f%%) - %s\n", workDone, totalWork, percentDone, message);
	}

	@Test
	public void stepwiseRegressionCommonMathTest() throws Exception {

		System.out.println("Stepwise Regression by Common Math:------>");

		String csvFilePath = resource.getFile().getAbsolutePath();
		System.out.println("CSV File Path: " + csvFilePath);

		String yColumnName = "LN_3"; // Replace with your Y column name
		List<String> excludeColumns = List.of("gid"); // List of column names to exclude

		OLSUtils.DataResult data = OLSUtils.loadData(csvFilePath, yColumnName, excludeColumns);

		// Perform stepwise regression
		System.out.println("Stepwise Regression :");
		double[][] X = data.getX().toArray();
		// Extract Y vector as 1D array
		double[] Y = new double[data.getY().rows()];
		for (int i = 0; i < data.getY().rows(); i++) {
			Y[i] = data.getY().get(i, 0); // Access the first (and only) column
		}

		// Perform stepwise regression
		Set<Integer> selectedVariables = stepwiseRegression(X, Y, 700, 0.0001);
		System.out.println("Selected Variables (Column Indices): " + selectedVariables);

	}

	// Stepwise regression function with cern.colt.matrix and maxIterations,
    public static Set<Integer> stepwiseRegression(DoubleMatrix2D X, DoubleMatrix2D Y, List<String> columnNames) {
        int numVariables = X.columns();
        Set<Integer> includedVariables = new HashSet<>();
        Set<Integer> excludedVariables = new HashSet<>();
        
        // Try to use other version of calculateAdjustedR2
		double[][] X_ = X.toArray();
		double[] Y_ = new double[Y.rows()];
		for (int i = 0; i < Y.rows(); i++) {
			Y_[i] = Y.get(i, 0); 
		}
		
		
        // Initially, all variables are excluded
        for (int i = 0; i < numVariables; i++) {
            excludedVariables.add(i);
        }

        int totalWork = (int) Math.pow(numVariables, 2);
        int workDone = 0;  // Initialize work done
        double previousAdjustedR2 = -Double.MAX_VALUE;
        boolean improved = true;
        int iteration = 0;
        
        // Declare maxIterations
        int maxIterations = 200;  // Set max iterations to prevent infinite loops

        while (improved && iteration < maxIterations) {
            improved = false;
            Integer bestVariable = null;
            double bestAdjustedR2 = -Double.MAX_VALUE;

            // Add new variables (forward selection)
            for (Integer var : excludedVariables) {
                Set<Integer> testVariables = new HashSet<>(includedVariables);
                testVariables.add(var);
                double adjustedR2 = calculateAdjustedR2(X_, Y_, testVariables);
                if (adjustedR2 > bestAdjustedR2) {
                    bestAdjustedR2 = adjustedR2;
                    bestVariable = var;
                    improved = true;
                }
                workDone++;  // Increment work done
                printProgress(workDone, totalWork);  // Print progress                
            }

            // If a variable is added, update sets
            if (bestVariable != null) {
                includedVariables.add(bestVariable);
                excludedVariables.remove(bestVariable);
            }

            // Try to remove variables to improve model (backward elimination)
            Integer worstVariable = null;
            for (Integer var : includedVariables) {
                Set<Integer> testVariables = new HashSet<>(includedVariables);
                testVariables.remove(var);
                double adjustedR2 = calculateAdjustedR2(X_, Y_, testVariables);
                if (adjustedR2 > bestAdjustedR2) {
                    bestAdjustedR2 = adjustedR2;
                    worstVariable = var;
                    improved = true;
                }
                workDone++;  // Increment work done
                printProgress(workDone, totalWork);  // Print progress                
            }

            // If a variable is removed, update sets
            if (worstVariable != null) {
                includedVariables.remove(worstVariable);
                excludedVariables.add(worstVariable);
            }

            // Check for improvement condition
            if (previousAdjustedR2 != Double.NaN && Math.abs(bestAdjustedR2 - previousAdjustedR2) < 0.0001) {
                System.out.println("No significant improvement in Adjusted R^2. Stopping process.");
                break;
            }

            previousAdjustedR2 = bestAdjustedR2;  // Update previous Adjusted R^2
            iteration++;
        }
		// Adjust totalWork dynamically based on remaining variables
		totalWork = workDone + excludedVariables.size() + includedVariables.size();
        // If loop stops due to max iterations, inform the user
        if (iteration >= maxIterations) {
            System.out.println("Maximum iterations reached.");
        }

        
		// Extra to print more info
        // Create a list to hold the selected column names
        List<String> selectedColumnNames = new ArrayList<>();
        
        // Run OLS regression on the final selected variables
        System.out.println("\nFinal Selected Variables:");
        for (Integer varIndex : includedVariables) {
        	selectedColumnNames.add(columnNames.get(varIndex));
            System.out.println(columnNames.get(varIndex));  // Display column names of selected variables
        }


        
        // Run OLS regression with selected variables
        int nDataPoints = X.rows();
        int nSelectedVariables = includedVariables.size();
        double[][] X_selected = new double[nDataPoints][nSelectedVariables];

        // Populate X_selected by selecting the relevant columns from X
        int i = 0;
        for (Integer var : includedVariables) {
            for (int j = 0; j < nDataPoints; j++) {
                X_selected[j][i] = X.get(j, var); // Assign data from X to X_selected
            }
            i++;
        }

        // Ensure Y_1d is a 1D array (matching number of data points)
        double[] Y_1d = new double[nDataPoints];
        for (int j = 0; j < nDataPoints; j++) {
            Y_1d[j] = Y.get(j, 0); // Assuming Y is a column vector, get the single column values
        }
        
        OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
        regression.newSampleData(Y_1d, X_selected);
        double[] coefficients = regression.estimateRegressionParameters();
        double rSquared = regression.calculateRSquared();
        double adjustedRSquared = regression.calculateAdjustedRSquared();

        // Display OLS results
        System.out.println("\nOLS Regression Results:");
        System.out.println("Coefficients:");
        System.out.println("const: " + coefficients[0]);
        for (int j = 0; j < selectedColumnNames.size(); j++) {
            System.out.println(selectedColumnNames.get(j) + ": " + coefficients[j+1]);
        }
        
        
        System.out.println("R²: " + rSquared);
        System.out.println("Adjusted R²: " + adjustedRSquared);		
		// End of Extra
        
        return includedVariables;
    }

    // Method to calculate Adjusted R^2 using cern.colt.matrix
    public static double calculateAdjustedR2(DoubleMatrix2D X, DoubleMatrix2D Y, Set<Integer> variables) {
        int numRows = X.rows();
        int numSelectedVariables = variables.size();
        
        // Create a new matrix for the selected variables
        DoubleMatrix2D reducedX = new DenseDoubleMatrix2D(numRows, numSelectedVariables);
        int colIndex = 0;
        for (Integer var : variables) {
            for (int row = 0; row < numRows; row++) {
                reducedX.set(row, colIndex, X.get(row, var));
            }
            colIndex++;
        }

        // Compute the regression (simplified version without external libraries)
        double[] YArray = new double[numRows];
        for (int i = 0; i < numRows; i++) {
            YArray[i] = Y.get(i, 0);
        }
        
        // Perform regression (simple matrix calculations for example purposes)
        // In a real scenario, you would use a more complex method like least squares
        double[] beta = new double[numSelectedVariables];
        double RSS = 0; // Residual sum of squares
        double TSS = 0; // Total sum of squares
        for (int i = 0; i < numRows; i++) {
            double predictedValue = 0;
            for (int j = 0; j < numSelectedVariables; j++) {
                predictedValue += reducedX.get(i, j) * beta[j];
            }
            RSS += Math.pow(YArray[i] - predictedValue, 2);
            TSS += Math.pow(YArray[i] - Arrays.stream(YArray).average().orElse(0), 2);
        }

        // Calculate Adjusted R^2
        double r2 = 1 - (RSS / TSS);
        double adjustedR2 = 1 - (1 - r2) * (numRows - 1) / (numRows - numSelectedVariables - 1);
        return adjustedR2;
    }

    // Method to print progress percentage
    public static void printProgress(int workDone, int totalWork) {
        int percent = (int) ((double) workDone / totalWork * 100);
        System.out.println("Progress: " + workDone + "/" + totalWork + " (" + percent + "%)");
    }

	@Test
	public void stepwiseRegressionColtTest() throws Exception {

		System.out.println("Stepwise Regression by Colt:------>");

		String csvFilePath = resource.getFile().getAbsolutePath();
		System.out.println("CSV File Path: " + csvFilePath);

		String yColumnName = "LN_3"; // Replace with your Y column name
		List<String> excludeColumns = List.of("gid"); // List of column names to exclude

		OLSUtils.DataResult data = OLSUtils.loadData(csvFilePath, yColumnName, excludeColumns);
        DoubleMatrix2D X = data.getX();  // Matrix for features
        DoubleMatrix2D Y = data.getY();  // Matrix for target variable
        List<String> Xcolumns = data.getXcolumnNames();
        
        // Perform stepwise regression
        Set<Integer> selectedVariables = stepwiseRegression(X, Y, Xcolumns);
        System.out.println("Selected Variables (Column Indices): " + selectedVariables);

	}

}
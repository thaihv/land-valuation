package com.jdvn.devtech.util.performance.regression;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;

public class StepwiseRegressionMethods_r2 {

    // Function to compute R² for a given feature subset
    public static double calculateR2(double[][] X, double[] y, List<Integer> selectedFeatures) {
        // Prepare X subset matrix
        double[][] XSubset = new double[y.length][selectedFeatures.size()];
        for (int i = 0; i < y.length; i++) {
            for (int j = 0; j < selectedFeatures.size(); j++) {
                XSubset[i][j] = X[i][selectedFeatures.get(j)];
            }
        }

        // Run OLS Regression
        OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
        regression.newSampleData(y, XSubset);

        // Get the estimated regression parameters (coefficients)
        double[] estimatedParameters = regression.estimateRegressionParameters();

        // Calculate predictions
        double[] predictions = new double[y.length];
        for (int i = 0; i < y.length; i++) {
            double prediction = estimatedParameters[0]; // Intercept term
            for (int j = 0; j < selectedFeatures.size(); j++) {
                prediction += XSubset[i][j] * estimatedParameters[j + 1]; // Multiply feature values by their coefficients
            }
            predictions[i] = prediction;
        }

        // Calculate R²
        double ssTotal = 0;
        double ssRes = 0;
        double meanY = Arrays.stream(y).average().orElse(0.0);

        for (int i = 0; i < y.length; i++) {
            ssTotal += Math.pow(y[i] - meanY, 2);
            ssRes += Math.pow(y[i] - predictions[i], 2);
        }

        return 1 - (ssRes / ssTotal);  // R²
    }

    // Forward Selection Function to return all subsets with R² >= threshold
    public static List<List<Integer>> forwardSelection(double[][] X, double[] y, double r2Threshold) {
        int numFeatures = X[0].length;
        List<Integer> remainingFeatures = new ArrayList<>();
        for (int i = 0; i < numFeatures; i++) {
            remainingFeatures.add(i);
        }
        List<Integer> selectedFeatures = new ArrayList<>();
        List<List<Integer>> validSubsets = new ArrayList<>();

        while (!remainingFeatures.isEmpty()) {
            double bestR2 = -Double.MAX_VALUE;
            @SuppressWarnings("unused")
			Integer bestFeature = null;
            List<Integer> bestSubset = null;

            // Try adding each remaining feature
            for (Integer feature : remainingFeatures) {
                List<Integer> currentSubset = new ArrayList<>(selectedFeatures);
                currentSubset.add(feature);
                double r2 = calculateR2(X, y, currentSubset);
                if (r2 >= r2Threshold) {
                    validSubsets.add(currentSubset); // Only add if R² >= threshold
                    if (r2 > bestR2) {
                        bestR2 = r2;
                        bestFeature = feature;
                        bestSubset = new ArrayList<>(currentSubset);
                    }
                }
            }

            // Break if no new subset meets the threshold
            if (bestR2 < r2Threshold) {
                break;
            }

            selectedFeatures = new ArrayList<>(bestSubset); // Update selected features
            remainingFeatures.removeAll(bestSubset); // Remove selected features from remaining
        }

        return validSubsets;
    }

    // Backward Elimination Function to return all subsets with R² >= threshold
    public static List<List<Integer>> backwardElimination(double[][] X, double[] y, double r2Threshold) {
        int numFeatures = X[0].length;
        List<Integer> selectedFeatures = new ArrayList<>();
        for (int i = 0; i < numFeatures; i++) {
            selectedFeatures.add(i);
        }

        List<List<Integer>> validSubsets = new ArrayList<>();

        while (selectedFeatures.size() > 0) {
            double bestR2 = -Double.MAX_VALUE;
            @SuppressWarnings("unused")
			Integer worstFeature = null;
            List<Integer> bestSubset = null;

            // Try removing each feature and check R²
            for (Integer feature : selectedFeatures) {
                List<Integer> currentSubset = new ArrayList<>(selectedFeatures);
                currentSubset.remove(feature);
                double r2 = calculateR2(X, y, currentSubset);
                if (r2 >= r2Threshold) {
                    validSubsets.add(currentSubset); // Only add if R² >= threshold
                    if (r2 > bestR2) {
                        bestR2 = r2;
                        worstFeature = feature;
                        bestSubset = new ArrayList<>(currentSubset);
                    }
                }
            }

            // If no subset improves R², break
            if (bestR2 < r2Threshold) {
                break;
            }

            selectedFeatures = new ArrayList<>(bestSubset);  // Update selected features
        }

        return validSubsets;
    }

    public static void main(String[] args) {
        // Example data: 5 samples, 3 features (X1, X2, X3)
        double[][] X = {
            {1, 2, 5},
            {2, 1, 3},
            {3, 4, 1},
            {4, 3, 4},
            {5, 5, 2}
        };

        double[] y = {5, 6, 7, 8, 9};

        // Ask user for desired R² threshold
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the minimum R² threshold value: ");
        double threshold = scanner.nextDouble();
        scanner.close();

        // Apply Forward Selection and Backward Elimination
        List<List<Integer>> forwardSelectedSubsets = forwardSelection(X, y, threshold);
        List<List<Integer>> backwardSelectedSubsets = backwardElimination(X, y, threshold);

        // Combine both lists
        List<List<Integer>> allSelectedSubsets = new ArrayList<>();
        allSelectedSubsets.addAll(forwardSelectedSubsets);
        allSelectedSubsets.addAll(backwardSelectedSubsets);

        // Display results
        System.out.println("Feature subsets with R² greater than or equal to " + threshold + ":");
        for (List<Integer> subset : allSelectedSubsets) {
            System.out.println("Selected Features: " + subset + " | R²: " + calculateR2(X, y, subset));
        }
    }

}

package com.jdvn.devtech.util.performance.regression;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;

public class StepwiseRegressionMethods_adjr2_fstats {

    // Function to compute Adjusted R² and F-statistic for a given feature subset
    public static Map<String, Double> calculateMetrics(double[][] X, double[] y, List<Integer> selectedFeatures) {
        Map<String, Double> metrics = new HashMap<>();
        if (selectedFeatures.isEmpty()) {
            metrics.put("adjR2", 0.0);
            metrics.put("fStatistic", 0.0);
            return metrics;
        }

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

        double[] residuals = regression.estimateResiduals();
        double rss = Arrays.stream(residuals).map(r -> r * r).sum();
        double totalSumOfSquares = Arrays.stream(y).map(v -> Math.pow(v - Arrays.stream(y).average().orElse(0.0), 2)).sum();

        // Calculate Adjusted R²
        int n = y.length;
        int p = selectedFeatures.size();
        double r2 = 1 - (rss / totalSumOfSquares);
        double adjR2 = 1 - (1 - r2) * (n - 1) / (n - p - 1);

        // Calculate F-statistic
        double msr = (totalSumOfSquares - rss) / p;
        double mse = rss / (n - p - 1);
        double fStatistic = msr / mse;

        metrics.put("adjR2", adjR2);
        metrics.put("fStatistic", fStatistic);

        return metrics;
    }

    // Forward Selection Function
    public static List<List<Integer>> forwardSelection(double[][] X, double[] y, double adjR2Threshold, double fStatisticThreshold) {
        int numFeatures = X[0].length;
        List<Integer> remainingFeatures = new ArrayList<>();
        for (int i = 0; i < numFeatures; i++) {
            remainingFeatures.add(i);
        }
        List<Integer> selectedFeatures = new ArrayList<>();
        List<List<Integer>> validSubsets = new ArrayList<>();

        while (!remainingFeatures.isEmpty()) {
            double bestAdjR2 = -Double.MAX_VALUE;
            Integer bestFeature = null;
            List<Integer> bestSubset = null;

            for (Integer feature : remainingFeatures) {
                List<Integer> currentSubset = new ArrayList<>(selectedFeatures);
                currentSubset.add(feature);

                Map<String, Double> metrics = calculateMetrics(X, y, currentSubset);
                double adjR2 = metrics.get("adjR2");
                double fStatistic = metrics.get("fStatistic");

                if (adjR2 >= adjR2Threshold && fStatistic >= fStatisticThreshold) {
                    validSubsets.add(currentSubset);
                    if (adjR2 > bestAdjR2) {
                        bestAdjR2 = adjR2;
                        bestFeature = feature;
                        bestSubset = new ArrayList<>(currentSubset);
                    }
                }
            }

            if (bestFeature == null) break;

            selectedFeatures = new ArrayList<>(bestSubset);
            remainingFeatures.remove(bestFeature);
        }

        return validSubsets;
    }

    // Backward Elimination Function
    public static List<List<Integer>> backwardElimination(double[][] X, double[] y, double adjR2Threshold, double fStatisticThreshold) {
        int numFeatures = X[0].length;
        List<Integer> selectedFeatures = new ArrayList<>();
        for (int i = 0; i < numFeatures; i++) {
            selectedFeatures.add(i);
        }

        List<List<Integer>> validSubsets = new ArrayList<>();

        while (selectedFeatures.size() > 0) {
            double bestAdjR2 = -Double.MAX_VALUE;
            Integer worstFeature = null;
            List<Integer> bestSubset = null;

            for (Integer feature : selectedFeatures) {
                List<Integer> currentSubset = new ArrayList<>(selectedFeatures);
                currentSubset.remove(feature);

                Map<String, Double> metrics = calculateMetrics(X, y, currentSubset);
                double adjR2 = metrics.get("adjR2");
                double fStatistic = metrics.get("fStatistic");

                if (adjR2 >= adjR2Threshold && fStatistic >= fStatisticThreshold) {
                    validSubsets.add(currentSubset);
                    if (adjR2 > bestAdjR2) {
                        bestAdjR2 = adjR2;
                        worstFeature = feature;
                        bestSubset = new ArrayList<>(currentSubset);
                    }
                }
            }

            if (worstFeature == null) break;

            selectedFeatures = new ArrayList<>(bestSubset);
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

        // Ask user for Adjusted R² and F-statistic thresholds
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the minimum Adjusted R² threshold value: ");
        double adjR2Threshold = scanner.nextDouble();
        System.out.print("Enter the minimum F-statistic threshold value: ");
        double fStatisticThreshold = scanner.nextDouble();
        scanner.close();

        // Apply Forward Selection and Backward Elimination
        List<List<Integer>> forwardSelectedSubsets = forwardSelection(X, y, adjR2Threshold, fStatisticThreshold);
        List<List<Integer>> backwardSelectedSubsets = backwardElimination(X, y, adjR2Threshold, fStatisticThreshold);

        // Combine both lists
        List<List<Integer>> allSelectedSubsets = new ArrayList<>();
        allSelectedSubsets.addAll(forwardSelectedSubsets);
        allSelectedSubsets.addAll(backwardSelectedSubsets);

        // Display results
        System.out.println("Feature subsets with Adjusted R² >= " + adjR2Threshold + " and F-statistic >= " + fStatisticThreshold + ":");
        for (List<Integer> subset : allSelectedSubsets) {
            Map<String, Double> metrics = calculateMetrics(X, y, subset);
            System.out.println("Selected Features: " + subset + " | Adjusted R²: " + metrics.get("adjR2") + " | F-statistic: " + metrics.get("fStatistic"));
        }
    }

}

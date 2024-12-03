package com.jdvn.devtech.util.performance.regression;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.math3.linear.SingularMatrixException;
import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;

public class StepwiseRegressionMethods {

    public static void main(String[] args) {
        // Sample data: predictors and target variable (Y)
        double[][] data = {
                {1, 2, 3},  // Predictor variables (X1, X2, X3)
                {2, 3, 5},
                {3, 4, 7},
                {4, 5, 9},
                {5, 6, 11}
        };
        double[] target = {1, 3, 5, 7, 9};  // Target variable (Y)

        // Feature names for reference
        String[] featureNames = {"X1", "X2", "X3"};

        // Run stepwise regression
        stepwiseForwardSelection(data, target, featureNames);
        stepwiseBackwardElimination(data, target, featureNames);
        stepwiseBidirectional(data, target, featureNames);
    }
 // Calculate Variance Inflation Factor (VIF) for each feature
    public static double[] calculateVIF(double[][] data) {
        int numFeatures = data[0].length;
        double[] vif = new double[numFeatures];

        for (int i = 0; i < numFeatures; i++) {
            double[][] reducedData = removeFeature(data, i);
            double[] target = getFeatureColumn(data, i);

            try {
                OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
                regression.newSampleData(target, reducedData);

                double rSquared = regression.calculateAdjustedRSquared();  // Assume adjusted R-squared method exists
                vif[i] = 1 / (1 - rSquared);
            } catch (Exception e) {
                vif[i] = Double.POSITIVE_INFINITY;
            }
        }

        return vif;
    }
 // Remove a specific feature from the dataset
    private static double[][] removeFeature(double[][] data, int featureIndex) {
        return Arrays.stream(data)
                     .map(row -> {
                         double[] newRow = new double[row.length - 1];
                         int index = 0;
                         for (int i = 0; i < row.length; i++) {
                             if (i != featureIndex) {
                                 newRow[index++] = row[i];
                             }
                         }
                         return newRow;
                     }).toArray(double[][]::new);
    }

    // Extract a specific feature column from the dataset
    private static double[] getFeatureColumn(double[][] data, int featureIndex) {
        return Arrays.stream(data)
                     .mapToDouble(row -> row[featureIndex])
                     .toArray();
    }    
    public static void stepwiseForwardSelection(double[][] data, double[] target, String[] featureNames) {
        List<Integer> selectedFeatures = new ArrayList<>();
        int numFeatures = data[0].length;

        while (selectedFeatures.size() < numFeatures) {
            double[] vif = calculateVIF(selectFeatures(data, selectedFeatures));
            for (int i = 0; i < vif.length; i++) {
                if (vif[i] > 10) {
                    System.out.println("Excluding feature due to high VIF: " + featureNames[i]);
                    selectedFeatures.remove((Integer) i);
                }
            }

            double bestPValue = Double.MAX_VALUE;
            int bestFeature = -1;

            for (int i = 0; i < numFeatures; i++) {
                if (selectedFeatures.contains(i)) continue;

                List<Integer> candidateFeatures = new ArrayList<>(selectedFeatures);
                candidateFeatures.add(i);

                double[][] subsetData = selectFeatures(data, candidateFeatures);
                double pValue = getPValue(subsetData, target);

                if (pValue < bestPValue) {
                    bestPValue = pValue;
                    bestFeature = i;
                }
            }

            if (bestFeature != -1 && bestPValue < 0.05) {
                selectedFeatures.add(bestFeature);
                System.out.println("Forward: Added feature: " + featureNames[bestFeature]);
            } else {
                break;
            }
        }
        System.out.println("Forward Method: Final selected features:");
        for (int idx : selectedFeatures) {
            System.out.println(featureNames[idx]);
        }
    }

    public static void stepwiseBackwardElimination(double[][] data, double[] target, String[] featureNames) {
        List<Integer> selectedFeatures = new ArrayList<>();
        for (int i = 0; i < data[0].length; i++) {
            selectedFeatures.add(i);
        }

        while (selectedFeatures.size() > 0) {
            double[] vif = calculateVIF(selectFeatures(data, selectedFeatures));
            for (int i = 0; i < vif.length; i++) {
                if (vif[i] > 10) {
                    System.out.println("Excluding feature due to high VIF: " + featureNames[i]);
                    selectedFeatures.remove((Integer) i);
                }
            }

            double worstPValue = 0;
            int worstFeature = -1;

            for (int i : selectedFeatures) {
                List<Integer> candidateFeatures = new ArrayList<>(selectedFeatures);
                candidateFeatures.remove((Integer) i);

                double[][] subsetData = selectFeatures(data, candidateFeatures);
                double pValue = getPValue(subsetData, target);

                if (pValue > worstPValue) {
                    worstPValue = pValue;
                    worstFeature = i;
                }
            }

            if (worstFeature != -1 && worstPValue > 0.10) {
                selectedFeatures.remove((Integer) worstFeature);
                System.out.println("Backward: Removed feature: " + featureNames[worstFeature]);
            } else {
                break;
            }
        }
        
        System.out.println("Backward Method: Final selected features:");
        for (int idx : selectedFeatures) {
            System.out.println(featureNames[idx]);
        }
    }


    // Bidirectional (Forward + Backward)
    public static void stepwiseBidirectional(double[][] data, double[] target, String[] featureNames) {
        List<Integer> selectedFeatures = new ArrayList<>();
        int numFeatures = data[0].length;
        boolean improvement = true;

        while (improvement) {
            improvement = false;

            // Forward Step
            int bestFeature = -1;
            double bestPValue = Double.MAX_VALUE;

            for (int i = 0; i < numFeatures; i++) {
                if (selectedFeatures.contains(i)) continue;

                List<Integer> candidateFeatures = new ArrayList<>(selectedFeatures);
                candidateFeatures.add(i);

                double[][] subsetData = selectFeatures(data, candidateFeatures);
                double pValue = getPValue(subsetData, target);

                if (pValue < 0.05 && pValue < bestPValue) {
                    bestPValue = pValue;
                    bestFeature = i;
                }
            }

            if (bestFeature != -1) {
                selectedFeatures.add(bestFeature);
                improvement = true;
                System.out.println("Bidirectional (Forward): Added feature: " + featureNames[bestFeature]);
            }

            // Backward Step
            int worstFeature = -1;
            double worstPValue = 0;

            double[] vif = calculateVIF(selectFeatures(data, selectedFeatures));
            for (int i = 0; i < selectedFeatures.size(); i++) {
                int featureIdx = selectedFeatures.get(i);

                if (vif[i] > 10) {
                    worstFeature = featureIdx;
                    break;
                }

                List<Integer> candidateFeatures = new ArrayList<>(selectedFeatures);
                candidateFeatures.remove((Integer) featureIdx);

                double[][] subsetData = selectFeatures(data, candidateFeatures);
                double pValue = getPValue(subsetData, target);

                if (pValue > 0.10 && pValue > worstPValue) {
                    worstPValue = pValue;
                    worstFeature = featureIdx;
                }
            }

            if (worstFeature != -1) {
                selectedFeatures.remove((Integer) worstFeature);
                improvement = true;
                System.out.println("Bidirectional (Backward): Removed feature: " + featureNames[worstFeature]);
            }
        }

        System.out.println("Bidirectional Methods: Final selected features:");
        for (int idx : selectedFeatures) {
            System.out.println(featureNames[idx]);
        }
    }


    private static double[][] selectFeatures(double[][] data, List<Integer> features) {
        return Arrays.stream(data)
                .map(row -> features.stream().mapToDouble(f -> row[f]).toArray())
                .toArray(double[][]::new);
    }

    private static double getPValue(double[][] data, double[] target) {
        try {
            OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();
            regression.newSampleData(target, data);

            double[] pValues = regression.estimateRegressionParametersStandardErrors();

            // Check if there are enough p-values (constant + at least one feature)
            if (pValues.length > 1) {
                return pValues[1]; // Return p-value of the first feature (ignoring intercept).
            } else {
                System.err.println("Not enough features for regression.");
                return Double.NaN;
            }
        } catch (SingularMatrixException e) {
            System.err.println("Matrix is singular. Check for multicollinearity.");
            return Double.NaN;
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            return Double.NaN;
        }
    }


}

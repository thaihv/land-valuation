package com.jdvn.devtech.util.performance.regression;

import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
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
    public static class DataResult {
        private DenseDoubleMatrix2D X;
        private DenseDoubleMatrix2D Y;

        public DataResult(DenseDoubleMatrix2D X, DenseDoubleMatrix2D Y) {
            this.X = X;
            this.Y = Y;
        }

        public DenseDoubleMatrix2D getX() {
            return X;
        }

        public DenseDoubleMatrix2D getY() {
            return Y;
        }
    }    
	
    public static DataResult loadData(String csvFilePath, String yColumnName, List<String> excludeColumns) throws IOException {
        List<double[]> XList = new ArrayList<>();  // To store the X matrix (features)
        List<Double> YList = new ArrayList<>();    // To store the Y vector (target values)

        // Read the CSV file with first record as header using CSVFormat
        FileReader fileReader = new FileReader(csvFilePath);
        CSVFormat csvFormat = CSVFormat.DEFAULT.builder()
                .setHeader()  // Sets the first record as header                
                .build();
        Iterable<CSVRecord> records = csvFormat.parse(fileReader);

        // Get the header map (first record is the header)
        LinkedHashMap<String, Integer> headerMap = new LinkedHashMap<>();
        for (CSVRecord record : records) {
            // The first row should be the header, so we create the header map
            if (headerMap.isEmpty()) {
                int index = 0;
                for (String column : record.toMap().keySet()) {
                    headerMap.put(column, index++);
                }
            }
            // Process the data rows (starting from the second row)
            double[] XRow = new double[headerMap.size() - 1 - excludeColumns.size()]; // Exclude Y column and excluded columns
            int xIndex = 0;  // To fill XRow
            double YValue = Double.parseDouble(record.get(headerMap.get(yColumnName)));  // Extract Y value

            // Identify indices to exclude based on column names
            List<Integer> excludeColumnIndices = new ArrayList<>();
            for (String columnName : excludeColumns) {
                excludeColumnIndices.add(headerMap.get(columnName));
            }

            // Iterate over columns and populate the XRow
            for (Map.Entry<String, Integer> entry : headerMap.entrySet()) {
                String columnName = entry.getKey();
                int columnIndex = entry.getValue();

                // Skip Y column and excluded columns
                if (columnName.equals(yColumnName) || excludeColumnIndices.contains(columnIndex)) {
                    continue;
                }

                // Extract X values from the data record
                XRow[xIndex++] = Double.parseDouble(record.get(columnIndex));
            }

            // Add the processed row to the X and Y lists
            XList.add(XRow);
            YList.add(YValue);
        }

        // Convert the lists to arrays for DenseDoubleMatrix2D
        int numRows = XList.size();
        int numCols = XList.get(0).length;

        // Create X matrix (features)
        double[][] XArray = new double[numRows][numCols];
        for (int i = 0; i < numRows; i++) {
            XArray[i] = XList.get(i);
        }

        // Create Y vector (target)
        double[] YArray = new double[numRows];
        for (int i = 0; i < numRows; i++) {
            YArray[i] = YList.get(i);
        }

        // Convert to DenseDoubleMatrix2D
        DenseDoubleMatrix2D XMatrix = new DenseDoubleMatrix2D(XArray);
        DenseDoubleMatrix2D YMatrix = new DenseDoubleMatrix2D(YArray.length, 1);
        for (int i = 0; i < YArray.length; i++) {
            YMatrix.set(i, 0, YArray[i]);
        }

        // Return both X and Y matrices wrapped in a DataResult object
        return new DataResult(XMatrix, YMatrix);
    }
        
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

            DataResult dataResult = loadData(csvFilePath, yColumnName, excludeColumns);            
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
            
            runOLSbyCommonsMath(X,Y);
                        
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
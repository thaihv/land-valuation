package com.jdvn.devtech.util.performance.regression;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import cern.colt.matrix.impl.DenseDoubleMatrix2D;

public class OLSUtils {
	public static long getLongValue(Object numObj) {
		String numObjStr = ObjectUtils.toString(numObj);
		return NumberUtils.toLong(numObjStr);
	}

	public static double getDoubleValue(Object numObj) {
		String numObjStr = ObjectUtils.toString(numObj);
		return NumberUtils.toDouble(numObjStr);
	}

	public static int getIntValue(Object numObj) {
		String numObjStr = ObjectUtils.toString(numObj);
		return NumberUtils.toInt(numObjStr);
	}

	public static boolean isValidContinuos(double min1, double max1, double min2, double max2) {
		if ((max1 <= min2 || max2 <= min1) && min1 >= 0 && max1 >= 0 && min2 >= 0 && max2 >= 0)
			return true;
		return false;
	}

	public static double calcLogeValue(double beta1, double beta2) {
		double result = 0;
		if (beta1 == beta2)
			result = 1;
		else if (Math.abs(beta1 - beta2) > 50) // TODO: ratio too much => temp value = 0
			result = 0;
		else
			result = Math.pow(Math.E, (beta1 - beta2));
		// Làm tròn 2 chữ số thập phân
		result = Math.round(result * 100.0) / 100.0;
		return result;
	}
    public static class DataResult {
        private DenseDoubleMatrix2D X;
        private DenseDoubleMatrix2D Y;
        private List<String> XcolumnNames;
        public DataResult(DenseDoubleMatrix2D X, DenseDoubleMatrix2D Y, List<String> XcolumnNames) {
            this.X = X;
            this.Y = Y;
            this.XcolumnNames = XcolumnNames;
        }

        public DenseDoubleMatrix2D getX() {
            return X;
        }

        public DenseDoubleMatrix2D getY() {
            return Y;
        }

		public List<String> getXcolumnNames() {
			return XcolumnNames;
		}


    }    
	
    public static DataResult loadData(String csvFilePath, String yColumnName, List<String> excludeColumns) throws IOException {
        List<double[]> XList = new ArrayList<>();  // To store the X matrix (features)
        List<Double> YList = new ArrayList<>();    // To store the Y vector (target values)
        List<String> XcolumnNames = new ArrayList<>();
        
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
                
                // Add the column name to the XcolumnNames list (only for X variables)
                if (!XcolumnNames.contains(columnName) && !columnName.equals(yColumnName) && !excludeColumns.contains(columnName)) {
                    XcolumnNames.add(columnName);
                }
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
        return new DataResult(XMatrix, YMatrix, XcolumnNames);
    }	
    public static String dummyfromContinuous(double income) {
        if (income < 30000) return "Low";
        else if (income < 70000) return "Medium";
        else return "High";
    }
    public static Map<String, DenseDoubleMatrix2D> createDummyVariablesFromCategorialColumn(String excelFilePath, String sheetName, String columnName) throws IOException {
        // Open the Excel file
        FileInputStream file = new FileInputStream(new File(excelFilePath));
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheet(sheetName);
        
        if (sheet == null) {
            throw new IllegalArgumentException("Sheet " + sheetName + " not found in the file.");
        }

        // Identify the header row
        Row headerRow = sheet.getRow(0);
        Map<String, Integer> columnIndexMap = new LinkedHashMap<>();
        for (Cell cell : headerRow) {
            columnIndexMap.put(cell.getStringCellValue(), cell.getColumnIndex());
        }

        if (!columnIndexMap.containsKey(columnName)) {
            throw new IllegalArgumentException("Column " + columnName + " not found in the sheet.");
        }

        int targetColumnIndex = columnIndexMap.get(columnName);

        // Collect unique categories from the target column
        Set<String> categories = new LinkedHashSet<>();
        for (Row row : sheet) {
            if (row.getRowNum() == 0) continue; // Skip header row
            Cell cell = row.getCell(targetColumnIndex);
            if (cell != null && cell.getCellType() == CellType.STRING) {
                categories.add(cell.getStringCellValue());
            }
        }

        // Create dummy variables
        List<int[]> dummyData = new ArrayList<>();
        Map<String, Integer> categoryIndexMap = new HashMap<>();
        int categoryIndex = 0;
        for (String category : categories) {
            if (categoryIndex < categories.size() - 1) { // Exclude one category for dummy variable trap
                categoryIndexMap.put(category, categoryIndex++);
            }
        }

        for (Row row : sheet) {
            if (row.getRowNum() == 0) continue; // Skip header row
            Cell cell = row.getCell(targetColumnIndex);
            String value = cell != null && cell.getCellType() == CellType.STRING ? cell.getStringCellValue() : null;

            int[] dummyRow = new int[categories.size() - 1]; // Exclude one category
            if (value != null && categoryIndexMap.containsKey(value)) {
                dummyRow[categoryIndexMap.get(value)] = 1;
            }
            dummyData.add(dummyRow);
        }

        // Convert to DenseDoubleMatrix2D
        int[][] dummyArray = dummyData.toArray(new int[0][]);
        double[][] dummyDoubleArray = Arrays.stream(dummyArray)
                .map(row -> Arrays.stream(row).asDoubleStream().toArray())
                .toArray(double[][]::new);

        DenseDoubleMatrix2D dummyMatrix = new DenseDoubleMatrix2D(dummyDoubleArray);

        // Close workbook and return result
        workbook.close();
        file.close();

        // Return dummy matrix and mapping
        Map<String, DenseDoubleMatrix2D> result = new HashMap<>();
        result.put("DummyMatrix", dummyMatrix);
        result.put("CategoryMapping", new DenseDoubleMatrix2D(
                new double[][]{categories.stream().mapToDouble(c -> categoryIndexMap.getOrDefault(c, -1)).toArray()}
        ));
        return result;
    }    
    public static Map<String, DenseDoubleMatrix2D> createDummyVariablesFromContinuousColumn(
            String excelFilePath, String sheetName, String columnName, int numBreaks) throws IOException, InvalidFormatException {

        // Open the Excel file
        FileInputStream file = new FileInputStream(new File(excelFilePath));
        Workbook workbook = WorkbookFactory.create(file);
        Sheet sheet = workbook.getSheet(sheetName);

        if (sheet == null) {
            throw new IllegalArgumentException("Sheet " + sheetName + " not found in the file.");
        }

        // Identify the header row
        Row headerRow = sheet.getRow(0);
        Map<String, Integer> columnIndexMap = new LinkedHashMap<>();
        for (Cell cell : headerRow) {
            columnIndexMap.put(cell.getStringCellValue(), cell.getColumnIndex());
        }

        if (!columnIndexMap.containsKey(columnName)) {
            throw new IllegalArgumentException("Column " + columnName + " not found in the sheet.");
        }

        int targetColumnIndex = columnIndexMap.get(columnName);

        // Read the continuous data values
        List<Double> dataValues = new ArrayList<>();
        for (Row row : sheet) {
            if (row.getRowNum() == 0) continue; // Skip header row
            Cell cell = row.getCell(targetColumnIndex);
            if (cell != null && cell.getCellType() == CellType.NUMERIC) {
                dataValues.add(cell.getNumericCellValue());
            }
        }

        double[] values = dataValues.stream().mapToDouble(Double::doubleValue).toArray();

        // Calculate Jenks Natural Breaks
        double[] breaks = jenksNaturalBreaks(values, numBreaks);

        // Generate dummy variables based on breaks
        List<int[]> dummyData = new ArrayList<>();
        for (double value : values) {
            int[] dummyRow = new int[numBreaks - 1];
            for (int i = 0; i < numBreaks - 1; i++) {
                if (value >= breaks[i] && value < breaks[i + 1]) {
                    dummyRow[i] = 1;
                    break;
                }
            }
            dummyData.add(dummyRow);
        }

        // Convert to DenseDoubleMatrix2D
        int[][] dummyArray = dummyData.toArray(new int[0][]);
        double[][] dummyDoubleArray = Arrays.stream(dummyArray)
                .map(row -> Arrays.stream(row).asDoubleStream().toArray())
                .toArray(double[][]::new);

        DenseDoubleMatrix2D dummyMatrix = new DenseDoubleMatrix2D(dummyDoubleArray);

        // Close workbook and file
        workbook.close();
        file.close();

        // Return dummy matrix and breaks mapping
        Map<String, DenseDoubleMatrix2D> result = new HashMap<>();
        result.put("DummyMatrix", dummyMatrix);
        result.put("BreaksMapping", new DenseDoubleMatrix2D(
                new double[][]{breaks}
        ));
        return result;
    }

    public static double[] jenksNaturalBreaks(double[] values, int numBreaks) {
        Arrays.sort(values);
        int n = values.length;
        double[][] mat1 = new double[n + 1][numBreaks + 1];
        double[][] mat2 = new double[n + 1][numBreaks + 1];

        for (int i = 1; i <= numBreaks; i++) {
            mat1[0][i] = 1.0;
            mat2[0][i] = 0.0;
            for (int j = 1; j <= n; j++) {
                mat2[j][i] = Double.MAX_VALUE;
            }
        }

        for (int l = 2; l <= n; l++) {
            double sum = 0, sumSq = 0, w = 0;
            for (int m = 1; m <= l; m++) {
                int i3 = l - m + 1;
                double val = values[i3 - 1];
                w++;
                sum += val;
                sumSq += val * val;
                double variance = sumSq - (sum * sum) / w;
                if (i3 != 1) {
                    for (int j = 2; j <= numBreaks; j++) {
                        if (mat2[l][j] >= (variance + mat2[i3 - 1][j - 1])) {
                            mat1[l][j] = i3;
                            mat2[l][j] = variance + mat2[i3 - 1][j - 1];
                        }
                    }
                }
            }
            mat1[l][1] = 1.0;
            mat2[l][1] = sumSq - (sum * sum) / w;
        }

        double[] breaks = new double[numBreaks + 1];
        breaks[numBreaks] = values[n - 1];
        int k = n;
        for (int j = numBreaks; j >= 2; j--) {
            int id = (int) mat1[k][j] - 1;
            breaks[j - 1] = values[id];
            k = id;
        }
        breaks[0] = values[0];
        return breaks;
    }  
}

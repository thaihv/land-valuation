package com.jdvn.devtech.util.performance.regression;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.Resource;

import com.jdvn.devtech.datamodel.DatamodelApplication;

import cern.colt.matrix.impl.DenseDoubleMatrix2D;

@SpringBootTest(classes=DatamodelApplication.class)
public class OLSDummyVariableTest {
	
    @Value("classpath:ols/dataraw.xlsx")
    private Resource resource;
    public static String dummyfromContinuous(double income) {
        if (income < 30000) return "Low";
        else if (income < 70000) return "Medium";
        else return "High";
    }
    public static Map<String, DenseDoubleMatrix2D> createDummyVariablesFromExcel(String excelFilePath, String sheetName, String columnName) throws IOException {
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
    
	@Test
	public void dummyGeneratedTest() throws Exception {
		
        String excelFilePath  = resource.getFile().getAbsolutePath();
        System.out.println("Excel File Path: " + excelFilePath );
        
        String sheetName = "step0";          // Sheet name
        String columnName = "zoning";      // Column to encode

        Map<String, DenseDoubleMatrix2D> result = createDummyVariablesFromExcel(excelFilePath, sheetName, columnName);

        // Print the dummy variables matrix
        DenseDoubleMatrix2D dummyMatrix = result.get("DummyMatrix");
        System.out.println("Dummy Variables Matrix: " + dummyMatrix);

        // Print the category mapping
        DenseDoubleMatrix2D categoryMapping = result.get("CategoryMapping");
        System.out.println("Category Mapping: " + categoryMapping);
	}

}
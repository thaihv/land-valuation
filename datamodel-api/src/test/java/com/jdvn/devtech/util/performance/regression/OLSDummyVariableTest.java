package com.jdvn.devtech.util.performance.regression;

import java.util.Map;

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
	@Test
	public void dummyGeneratedTest() throws Exception {
		
        String excelFilePath  = resource.getFile().getAbsolutePath();
        System.out.println("Excel File Path: " + excelFilePath );
        
        String sheetName = "step0";          // Sheet name
        String columnName = "zoning";      // Column to encode

        Map<String, DenseDoubleMatrix2D> result = OLSUtils.createDummyVariablesFromExcel(excelFilePath, sheetName, columnName);

        // Print the dummy variables matrix
        DenseDoubleMatrix2D dummyMatrix = result.get("DummyMatrix");
        System.out.println("Dummy Variables Matrix: " + dummyMatrix);

        // Print the category mapping
        DenseDoubleMatrix2D categoryMapping = result.get("CategoryMapping");
        System.out.println("Category Mapping: " + categoryMapping);
	}

}
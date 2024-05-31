package com.jdvn.devtech.util.performance.regression;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import com.jdvn.devtech.datamodel.DatamodelApplication;

import cern.colt.matrix.impl.DenseDoubleMatrix2D;

@SpringBootTest(classes=DatamodelApplication.class)
public class RegressionAnalysisUnitTest {
	@Test
	public void dummyRegressionTest() throws Exception {
		RegressionVariable orgRv = new RegressionVariable("DON VI LOP BANG SO SANH 1");

		// LAND PRICE
		orgRv.addDepedentVariable("PRICE");

		// CHAR_CD LAND TYPE
		orgRv.addIndepedentGroup("100");
		// CHAR_CD LAND SHAPE
		orgRv.addIndepedentGroup("200");
		// CHAR_CD LAND DISTANCE
		orgRv.addIndepedentGroup("300");

		// ADD LAND PRICE VALUES
		orgRv.addDepedentValue(35);
		orgRv.addDepedentValue(32);
		orgRv.addDepedentValue(19);
		orgRv.addDepedentValue(24);
		orgRv.addDepedentValue(25);
		orgRv.addDepedentValue(24);
		orgRv.addDepedentValue(52);
		orgRv.addDepedentValue(33);
		orgRv.addDepedentValue(29);
		orgRv.addDepedentValue(22);

		// ADD CHAR_CD LAND TYPE ITEM CATEGORIES
		List<String> items = new ArrayList<String>();
		items.add("101");
		items.add("102");
		items.add("103");
		orgRv.setItems("100", items);

		// ADD CHAR_CD LAND TYPE ITEM_CD
		orgRv.addItemValue("100", "101");
		orgRv.addItemValue("100", "102");
		orgRv.addItemValue("100", "102");
		orgRv.addItemValue("100", "103");
		orgRv.addItemValue("100", "102");
		orgRv.addItemValue("100", "103");
		orgRv.addItemValue("100", "101");
		orgRv.addItemValue("100", "101");
		orgRv.addItemValue("100", "101");
		orgRv.addItemValue("100", "103");

		// ADD CHAR_CD LAND SHAPE ITEM CATEGORIES
		items = new ArrayList<String>();
		items.add("201");
		items.add("202");
		items.add("203");
		orgRv.setItems("200", items);

		// ADD CHAR_CD LAND SHAPE ITEM_CD
		orgRv.addItemValue("200", "201");
		orgRv.addItemValue("200", "201");
		orgRv.addItemValue("200", "202");
		orgRv.addItemValue("200", "201");
		orgRv.addItemValue("200", "203");
		orgRv.addItemValue("200", "203");
		orgRv.addItemValue("200", "203");
		orgRv.addItemValue("200", "201");
		orgRv.addItemValue("200", "201");
		orgRv.addItemValue("200", "201");

		// ADD CHAR_CD LAND DISTANCE ITEM CATEGORIES
		items = new ArrayList<String>();
		items.add("301");
		items.add("302");
		items.add("303");
		items.add("304");
		orgRv.setItems("300", items);

		// ADD CHAR_CD LAND DISTANCE ITEM_CD
		orgRv.addItemValue("300", "301");
		orgRv.addItemValue("300", "303");
		orgRv.addItemValue("300", "302");
		orgRv.addItemValue("300", "302");
		orgRv.addItemValue("300", "302");
		orgRv.addItemValue("300", "303");
		orgRv.addItemValue("300", "303");
		orgRv.addItemValue("300", "304");
		orgRv.addItemValue("300", "301");
		orgRv.addItemValue("300", "301");

		System.out.println("=============REGRESSION==================");
		System.out.println();
		System.out.print(orgRv.getDependentVariable().getName());
		System.out.print("\t\t");
		System.out.print("\t\t");
		System.out.print(orgRv.getDependentVariable().getValues());			
		for (RegressionVariableEntity rve : orgRv.getIndependentEntities())
		{
			System.out.println();
			System.out.print(rve.getParent().getName());
			System.out.print("\t\t");
			System.out.print(rve.getName());
			System.out.print("\t\t");
			System.out.print(rve.getValues());
		}
		System.out.println("=============REGRESSION==================");		
		
		orgRv.fix(RegressionVariable.REFERENCE_TYPE_FIRST);
		DenseDoubleMatrix2D[] variable = null;

		try {
			variable = orgRv.assignVariable();
			RegressionProcess rp = new RegressionProcess(variable[0],
					variable[1]);

			rp.process();
			rp.calulateVIF(orgRv);
			orgRv.setResult(rp);

			orgRv.print();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
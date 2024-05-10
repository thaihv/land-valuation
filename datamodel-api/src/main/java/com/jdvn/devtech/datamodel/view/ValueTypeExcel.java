package com.jdvn.devtech.datamodel.view;

import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

import com.jdvn.devtech.datamodel.schema.valuation.ValueType;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/* 
 * Create Excel report using org.apache.poi 
 * To use predefine xls file template using functions from org.jxlsjxls-poi  
 * */
public class ValueTypeExcel extends AbstractXlsxView {
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {		
		// Define excel file name to be exported
		response.addHeader("Content-Disposition", "attachment;fileName=ValueTypeData.xlsx");
		// Read data provided by controller
		@SuppressWarnings("unchecked")
		List<ValueType> valueTypes = (List<ValueType>) model.get("list");

		// Create sheet
		Sheet sheet = workbook.createSheet("ValueType");
		// Create row0 as a header
		Row row0 = sheet.createRow(0);
		row0.createCell(0).setCellValue("Code");
		row0.createCell(1).setCellValue("Short");
		row0.createCell(2).setCellValue("Description");		
		row0.createCell(3).setCellValue("Status");

		// Create rows onwards from List<T>
		int rowNum = 1;
		for (ValueType vt : valueTypes) {
			Row row = sheet.createRow(rowNum++);
			row.createCell(0).setCellValue(vt.getCode());
			row.createCell(1).setCellValue(vt.getDisplay_value());
			row.createCell(2).setCellValue(vt.getDescription());			
			row.createCell(3).setCellValue(vt.getStatus() == 'a' ? "Yes" : "No");
		}
	}
}
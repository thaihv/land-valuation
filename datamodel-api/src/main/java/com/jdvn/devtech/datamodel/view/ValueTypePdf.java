package com.jdvn.devtech.datamodel.view;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.jdvn.devtech.datamodel.schema.valuation.ValueType;
import com.lowagie.text.Document;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.PdfWriter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ValueTypePdf extends AbstractPdfView  {
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<ValueType> valueTypes = (List<ValueType>) model.get("list");
		
		Table table = new Table(4);
		table.addCell("Code");
		table.addCell("Short");
		table.addCell("Description");
		table.addCell("Status");
		
		for (ValueType vt : valueTypes) {
			table.addCell(vt.getCode());
			table.addCell(vt.getDisplay_value());
			table.addCell(vt.getDescription());
			table.addCell(vt.getStatus() == 'a' ? "Yes" : "No");			
		}
		document.add(table);
	}
}
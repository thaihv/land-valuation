package com.jdvn.devtech.datamodel.schema.document;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "document", schema = "document", indexes = {@Index(name = "document_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Store electronic copies of documentation provided in support of land valuation processes.")
public class Document extends DomainObject<Long> {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@Comment("Identifier for the document.")
	private Long id;
	
	@Column(length = 20, nullable = false)
	@Comment("Unique number to identify the document.")
	private String unique_number;
	
	@Column(length = 5, nullable = false)
	@Comment("The file extension of the electronic file. E.g. pdf, tiff, doc, etc.")
	private String extension;
	
	@Column(length = 255, nullable = false)
	@Comment("Mime type of the file.")
	private String mime_type;	

	@Column(nullable = false)
	@Comment("The content of the electronic file.")
	private byte[] body = new byte[2048];
	
	@Column(length = 500)
	@Comment("Description of the valuation unit.")
	private String description;
    
	@Override
	public String print() {
		return unique_number;
	}
	

}
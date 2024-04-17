package com.jdvn.devtech.datamodel.schema.document;

import java.time.LocalDateTime;

import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "document_chunk", schema = "document",uniqueConstraints = { @UniqueConstraint(name = "start_unique_document_chunk", columnNames = { "document_id","start_position" })})
@Comment("Holds temporary pieces of a document uploaded on the server. In case of large files, document can be split into smaller pieces (chunks) allowing reliable upload. After all pieces uploaded, client will instruct server to create a document and remove temporary files stored in this table.")
public class DocumentChunk{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@Comment("Unique ID of the chunk.")
	private Long id;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "document_id", foreignKey = @ForeignKey(name = "document_id_fkey"))
    @Comment("Document ID, which will be used to create final document object. Used to group all chunks together.")
    private Document document;
    
	@Column(name = "claim_id")
	@Comment("Claim ID. Used to clean the table when saving claim. It will guarantee that no orphan chunks left in the table.")
	private Long claim_id;
    
	@Column
	@Comment("Staring position of the byte in the destination document.")
	private int start_position;

	@Column(nullable = false)
	@Comment("The content of the chunk.")
	private byte[] body = new byte[1024];
	
	@Column
	@Comment("Size of the chunk in bytes.")
	private int size;

	@Column(length = 50)
	@Comment("Checksum of the chunk, calculated using MD5.")
	private String md5;
    
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("Date and time when chuck was created.")
	private LocalDateTime creation_time = LocalDateTime.now();	
	
	@Column(length = 50)
	@Comment("User id or name who has uploaded the chunk.")
	private String user_name;
	

}
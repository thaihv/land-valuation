package com.jdvn.devtech.datamodel.schema.source;

import java.time.LocalDateTime;
import java.util.Date;

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
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "source", schema = "source")
@Comment("List of the sources in valuation process.")
public class Source {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(length = 200, nullable = false)
	@Comment("Display name of the source.")
	private String name;

	@Column(length = 4000)
	@Comment("Content of the source.")
	private String content;

	@Column
	@Comment("The acceptance date of source.")
	private Date acceptance;
	
	@Column
	@Comment("The recordation date of source.")
	private Date recordation;
	
	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The submission date of source.")
	private LocalDateTime submission = LocalDateTime.now();
	
	@Column
	@Comment("The expiration date of source.")
	private Date expiration;
    	
	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the valuation unit as active (a) or inactive (i).")
	private char status;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @JoinColumn(name = "type_code", foreignKey = @ForeignKey(name = "source_code_fkey"))
    @Comment("Refer to identifying of a source type.")
    private SourceType source_type;


}
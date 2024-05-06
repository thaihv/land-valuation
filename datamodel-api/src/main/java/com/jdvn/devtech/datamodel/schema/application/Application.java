package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@Table(name = "application", schema = "application", indexes = {
		@Index(name = "source_on_rowidentifier", columnList = "rowidentifier") })
@Comment("List of the sources in valuation process.")
public class Application extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the application.")
	private String id;

	@Column(length = 20, nullable = false)
	@Comment("The application number displayed to end users.")
	private String app_nr;

    
	@Override
	public String print() {
		return id;
	}
}
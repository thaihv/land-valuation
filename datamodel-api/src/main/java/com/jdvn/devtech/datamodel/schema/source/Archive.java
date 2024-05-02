package com.jdvn.devtech.datamodel.schema.source;

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
@Table(name = "archive", schema = "source", indexes = {@Index(name = "archive_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Represents an archive where collections of physical documents may be kept such as a filing cabinet, library or storage unit.")
public class Archive extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Comment("Identifier for the archive.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 250, nullable = false)
	@Comment("Description of the archive and its location.")
	private String name;
    
	@Override
	public String print() {
		return name;
	}
	

}
package com.jdvn.devtech.datamodel.schema.apikey;

import org.hibernate.annotations.Comment;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
@Table(name = "data_scopes", schema = "apikey")
@Comment("Presents data items provided follows api categories.")
public class DataScope {

	@Id
	@Comment("Data scope identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column(length = 256)
	@Comment("A detail explain of data scope.")
	private String description;
	
	@Column(length = 64, nullable = false)
	@Comment("Name to distinguish the data scope item.")
	private String name;
	
	
}
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
@Table(name = "key_performances", schema = "apikey")
@Comment("Presents performance indicator for each issued key implementation")
public class KeyPerformance {

	@Id
	@Comment("Key performance identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Comment("Number of request that consumed by user with key in total.")
	private int requests_count;
	
	@Comment("Size of data volume that consumed by user with key in total.")
	private int data_volumes;
	
	
}
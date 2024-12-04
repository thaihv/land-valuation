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
@Table(name = "ip_restrictions", schema = "apikey")
@Comment("A table records list Ips in restrictions for each key.")
public class Restriction {

	@Id
	@Comment("Key performance identifier.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@Column(length = 256)
	@Comment("A list of ip address with seperated commas.")
	private String ip_address;
	

}
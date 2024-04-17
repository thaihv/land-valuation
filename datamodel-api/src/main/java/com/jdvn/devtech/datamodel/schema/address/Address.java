package com.jdvn.devtech.datamodel.schema.address;

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
@Table(name = "address", schema = "address", indexes = {@Index(name = "address_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Describes a postal or physical address.")
public class Address extends DomainObject<Long> {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Comment("Address identifier.")
	@Column(name = "id")
	private Long id;

	@Column(length = 255)
	@Comment("The postal or physical address or if no formal addressing is used, a description or place name for the location.")
	private String description;

	@Column(length = 40)
	@Comment("Optional identifier for the address that may reference further address details from an external system (e.g. address validation database).")
	private String ext_address_id;
	
	@Override
	public String print() {
		return description;
	}
	

}
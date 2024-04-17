package com.jdvn.devtech.datamodel.schema.source;
import java.util.Set;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "availability_status_type", schema = "source", uniqueConstraints = { @UniqueConstraint(name = "availability_status_type_display_value_key", columnNames = { "display_value" })})
@Comment("Code list indicates if a document is available, archived, destroyed or incomplete")
public class AvailabilityStatusType {

	@Id
	@Column(length = 20, nullable = false)
	@Comment("The code for the availability status type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the availability status type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the availability status type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'i'")
	@Comment("Status in active of the availability status type as current (c) or noncurrent (x).")
	private char status;
	
    @OneToMany(cascade=CascadeType.ALL, mappedBy = "availability_status_type")
    @JsonBackReference
    private Set<Source> sources;
}
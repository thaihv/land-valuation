package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "utility_network_type", schema = "preparation", uniqueConstraints = { @UniqueConstraint(name = "utility_network_type_display_value", columnNames = { "display_value" })})
@Comment("Code list of utility network types. E.g. gas, oil, water, etc")
public class UtilityNetworkType{
	@Id
	@Column(length = 20, nullable = false)
	@Comment("Code of the utility network type.")
	private String code;

	@Column(length = 500, nullable = false)
	@Comment("Displayed value of the utility network type.")
	private String display_value;

	@Column(length = 1000)
	@Comment("Description of the utility network type.")
	private String description;

	@Column(columnDefinition = "character(1) default 'a'")
	@Comment("Status in active of the utility network type as active (a) or inactive (i).")
	private char status;

	@OneToOne(mappedBy = "utility_network_type")
	private UtilityNetwork utility_network;
	
}
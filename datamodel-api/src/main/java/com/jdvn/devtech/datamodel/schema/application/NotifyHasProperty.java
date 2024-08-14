package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
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
@Table(name = "notify_property", schema = "application", indexes = {
		@Index(name = "notify_property_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "notify_property_notify_id_fkey_ind", columnList = "application_id"),
		@Index(name = "notify_property_vunit_id_fkey_ind", columnList = "vunit_id")})
@Comment("Properties are associated to a notify.")
public class NotifyHasProperty extends DomainObject<String>{
	private static final long serialVersionUID = 1L;
	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifier for the notify property.")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "application_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "notify_property_application_id_fkey"))
	@Comment("Identifier for the application the record is associated to.")
    private Application application;	

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "vunit_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "notify_property_vunit_id_fkey"))
	@Comment("Reference to a record in the Valuation Unit table that matches the property details provided for the notification.")
    private ValuationUnit valuation_unit;
		
	@Override
	public String print() {
		return id;
	}
}
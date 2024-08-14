package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnit;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
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
		@Index(name = "notify_property_notify_id_fkey_ind", columnList = "notify_id"),
		@Index(name = "notify_property_vunit_id_fkey_ind", columnList = "vunit_id")})
@Comment("Properties are associated to a notification.")
@IdClass(NotifyPropertyId.class)
public class NotifyHasProperty extends DomainObject<String>{
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the nofification.")
	private String notify_id;
	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier of the source associated to the notification.")
	private String vunit_id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "notify_id", foreignKey = @ForeignKey(name = "notify_property_notify_id_fkey"))
    @Comment("Reference to a notification.")
    private Notify notify;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "notify_property_vunit_id_fkey"))
    @Comment("Reference to a valuation unit which has the targeted property.")
    private ValuationUnit valuation_unit;;

	@Override
	public String getId() {
		return notify_id + "_" + vunit_id;
	}

	@Override
	public String print() {
		return notify_id + "_" + vunit_id;
	}
    


}
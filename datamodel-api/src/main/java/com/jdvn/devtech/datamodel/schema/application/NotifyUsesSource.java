package com.jdvn.devtech.datamodel.schema.application;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.source.Source;

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
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "notify_uses_source", schema = "application", indexes = {
		@Index(name = "notify_uses_source_application_id_fkey_ind", columnList = "notify_id"), 
		@Index(name = "notify_uses_source_source_id_fkey_ind", columnList = "source_id"),
		@Index(name = "notify_uses_source_index_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Links the notification parties to the sources (a.k.a. documents) generated for services.")
@IdClass(NotifySourceId.class)
public class NotifyUsesSource extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the nofification.")
	private String notify_id;
	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier of the source associated to the notification.")
	private String source_id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "notify_id", foreignKey = @ForeignKey(name = "notify_uses_source_notify_id_fkey"))
    @Comment("Reference to a notify.")
    private Notify notify;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "source_id", foreignKey = @ForeignKey(name = "notify_uses_source_source_id_fkey"))
    @Comment("Reference to a source.")
    private Source source;
    
	@Override
	public String getId() {
		return notify_id + "_" + source_id;
	}	
	@Override
	public String print() {
		return notify_id + "_" + source_id;
	}
}
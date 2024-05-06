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
@Table(name = "application_uses_source", schema = "application", indexes = {
		@Index(name = "application_uses_source_on_application_id", columnList = "application_id"), 
		@Index(name = "application_uses_source_on_source_id", columnList = "source_id"),
		@Index(name = "application_uses_source_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Links the application to the sources (documents) submitted with the application.")
@IdClass(ApplicationSourceId.class)
public class ApplicationUsesSource extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the application the record is associated to.")
	private String application_id;
	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier of the source associated to the application.")
	private String source_id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "application_id", foreignKey = @ForeignKey(name = "application_uses_source_application_id_fkey"))
    @Comment("Reference to an application.")
    private Application application;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "source_id", foreignKey = @ForeignKey(name = "application_uses_source_source_id_fkey"))
    @Comment("Reference to a source.")
    private Source source;
    
	@Override
	public String getId() {
		return application_id + "_" + source_id;
	}	
	@Override
	public String print() {
		return application_id + "_" + source_id;
	}
}
package com.jdvn.devtech.datamodel.schema.valuation;

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
@Table(name = "valuation_unit_uses_source", schema = "valuation", indexes = {
		@Index(name = "valuation_unit_uses_source_vunit_id_fkey_ind", columnList = "vunit_id"), 
		@Index(name = "valuation_unit_uses_source_source_id_fkey_ind", columnList = "source_id"),
		@Index(name = "valuation_unit_uses_index_source_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Links the valuation unit to the sources (e.g., documents, photographs, deeds, entry forms collected in the\r\n"
		+ "on-site visits or new application submission, etc.) in valuation process.")
@IdClass(SourceUnitId.class)
public class ValuationUnitUsesSource extends DomainObject<String> {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the valuation unit the record is associated to.")
	private String vunit_id;
	
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier of the source associated to the application.")
	private String source_id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vunit_id", foreignKey = @ForeignKey(name = "valuation_unit_uses_source_vunit_id_fkey"))
    @Comment("Reference to a valuation unit.")
    private ValuationUnit valuation_unit;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "source_id", foreignKey = @ForeignKey(name = "valuation_unit_uses_source_source_id_fkey"))
    @Comment("Reference to a source.")
    private Source source;
    
	@Override
	public String getId() {
		return vunit_id + "_" + source_id;
	}	
	@Override
	public String print() {
		return vunit_id + "_" + source_id;
	}
}
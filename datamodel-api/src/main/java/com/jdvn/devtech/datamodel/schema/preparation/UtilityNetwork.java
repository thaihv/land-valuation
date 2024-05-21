package com.jdvn.devtech.datamodel.schema.preparation;

import org.hibernate.annotations.Comment;
import org.locationtech.jts.geom.MultiPolygon;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
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
@Table(name = "utility_network", schema = "preparation")
@Comment("A utility network concerns to implementation of the LADM LA_LegalSpaceUtilityNetwork class. Not used by Lao Land Valuation System.")
public class UtilityNetwork extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	private String id;

	@Column(length = 40)
	@Comment("External identifier for a physical utility network.")
	private String ext_physical_network_id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "status_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "utility_network_status_code_fkey"))
	@Comment("Status code for the utility network.")
    private UtilityNetworkStatusType utility_network_status_type;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "utility_network_type_code_fkey"))
	@Comment("Type code for the utility network.")
    private UtilityNetworkType utility_network_type;

	@Column(columnDefinition = "geometry")
	@Comment("Geometry of the utility network.")
	private MultiPolygon geom;
	
	@Override
	public String getId() {
		return id;
	}

	@Override
	public String print() {
		return id;
	}

}
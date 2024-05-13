package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Comment;
import org.locationtech.jts.geom.MultiPolygon;
import org.locationtech.jts.geom.Point;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
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
@Table(name = "valuation_unit_group", schema = "valuation")
@Comment("For grouping or zoning valuation units, such as administrative, economic and market zones that indicate similar characteristics or functions\r\n"
		+ "of valuation units (e.g., commercial, residential and agricultural).")
public class ValuationUnitGroup extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@Column(length = 500, nullable = false)
	@Comment("Display name of the valuation unit group.")
	private String name;

	@Column(length = 1000)
	@Comment("Description of the valuation unit group.")
	private String description;
	
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "vu_group_type_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "valuation_unit_group_vu_group_type_code_fkey"))
    @Comment("Type of the valuation unit group as zone or locality.")
    private ValuationUnitGroupType vu_group_type;

	@Column(columnDefinition = "geometry")
	@Comment("Reference point at center of group geometry.")
    private Point  reference_point;
	
	@Column(columnDefinition = "geometry NOT NULL")
	@Comment("Multi polygon as geometry of all valuation units for spatial displaying.")
    private MultiPolygon  geom;

    /* Reference to its self as parent-children relationship  */	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "found_in_vu_group_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "valuation_unit_group_found_in_vu_group_id_fkey"))
	@Comment("Parent group where this valuation group belongs, it could be NULL as no specific parent.")
	private ValuationUnitGroup found_in_vu_group;
	
    /* Control many-to-many relationship between valuation unit and valuation unit group, 
     * vu_groups is a variable in ValuationUnit  */
    @ManyToMany(mappedBy = "vu_groups")
    private List<ValuationUnit> valuation_units = new ArrayList<>();
    
	@Override
	public String print() {
		return id;
	}
	

}
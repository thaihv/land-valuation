package com.jdvn.devtech.datamodel.schema.administrative;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "party_for_rrr", schema = "administrative")
@Comment("Identifies the parties involved in each RRR. Also identifies the share each party has in the RRR if the RRR is subject to shared allocation.")
@IdClass(PartyRRRId.class)
public class PartyForRRR extends DomainObject<String> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(length = 40, nullable = false)
	@Comment("The id of the rrr.")
	private String rrr_id;
    @Id
	@Column(length = 40, nullable = false)
	@Comment("Identifier for the party associated to the RRR.")
	private String party_id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "rrr_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "party_for_rrr_rrr_id_fkey"))
	@Comment("Reference to a RRR to identify.")
	private RRR rrr;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "party_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "party_for_rrr_party_id_fkey"))
	@Comment("Reference to the involved party.")
	private Party party;

//    @ManyToOne(cascade = CascadeType.ALL , optional = true)
////    @JoinColumn(name = "share_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "party_for_rrr_share_id_fkey"))
//    @JoinColumns({
//    	@JoinColumn(name = "share_id", referencedColumnName = "id"),
//        @JoinColumn(name = "rrr_id", referencedColumnName = "rrr_id")        
//    })
//    @Comment("Reference to a rrr share.")
//    private RRRShare rrr_share;
	
	@Override
	public String getId() {
		return rrr_id + "_" + party_id;
	}

	@Override
	public String print() {
		return rrr_id + "_" + party_id;
	}

}
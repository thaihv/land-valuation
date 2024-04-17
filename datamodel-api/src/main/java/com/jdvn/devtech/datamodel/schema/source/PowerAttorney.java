package com.jdvn.devtech.datamodel.schema.source;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
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
@Table(name = "power_of_attorney", schema = "source", indexes = {
		@Index(name = "power_of_attorney_on_rowidentifier", columnList = "rowidentifier") })
@Comment("Captures details for power of attorney documents.")
public class PowerAttorney extends DomainObject<Long>{

	private static final long serialVersionUID = 1L;
	@Id
	@Comment("Identifier for the power of attorney record. Matches the source identifier for the power of attorney record.")
	@Column(name = "id")	
	private Long id;

	@Column(length = 500)
	@Comment("The name of the person that is granting the power of attorney (a.k.a. grantor).")
	private String person_name;
	
	@Column(length = 500)
	@Comment("The name of the person that will act on behalf of the grantor as their attorney.")
	private String attorney_name;
	
	@OneToOne
	@MapsId
	@JoinColumn(name = "id", foreignKey = @ForeignKey(name = "power_of_attorney_id_fkey"))
	private Source source;
	
	@Override
	public String print() {
		return "Power of Attorney ID" + Long.toString(id);
	}
}
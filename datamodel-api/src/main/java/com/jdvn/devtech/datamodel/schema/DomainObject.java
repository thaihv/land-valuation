package com.jdvn.devtech.datamodel.schema;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.annotations.Comment;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.Transient;

@MappedSuperclass
@SuppressWarnings("serial")
/*
 * For version objects
 */

public abstract class DomainObject<ID extends Serializable> implements Serializable {

	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("Identifies the all change records for the row in the table.")
	@JsonIgnore
	@Transient
	private String rowidentifier;

	@Column(nullable = false, columnDefinition = "integer DEFAULT 0")
	@Comment("Sequential value indicating the number of times this row has been modified.")
	@JsonIgnore
	@Transient
	private int rowversion;

	@Column(nullable = false, columnDefinition = "character(1) default 'i'")
	@Comment("Indicates if the last data modification action that occurred to the row was insert (i), update (u) or delete (d).")
	@JsonIgnore
	@Transient
	private char change_action;

	@Column(length = 50)
	@Comment("The user id of the last person to modify the row.")
	@JsonIgnore
	private String change_user;

	@Column(nullable = false, columnDefinition = "timestamp without time zone DEFAULT now()")
	@Comment("The date and time the row was last modified.")
	@JsonIgnore
	@Transient
	private LocalDateTime change_time = LocalDateTime.now();

	@JsonIgnore
	public abstract ID getId();
	@JsonIgnore
	public LocalDateTime getChangeTimeAt() {
		return change_time;
	}
	public void setChangeTimeAt(LocalDateTime createdAt) {
		this.change_time = createdAt;
	}
	@JsonIgnore
	public String getChangedBy() {
		return change_user;
	}
	public void setChangedBy(String createdBy) {
		this.change_user = createdBy;
	}

	public abstract String print();

	@SuppressWarnings("rawtypes")
	@Override
	public boolean equals(Object other) {
		if (this == other)
			return true;
		if (other == null || !(other instanceof DomainObject))
			return false;
		DomainObject that = (DomainObject) other;
		return new EqualsBuilder().append(getId(), that.getId()).isEquals();
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getId()).toHashCode();
	}

	@Override
	public String toString() {
		return getClass().getSimpleName() + " [id=" + getId() + "]";
	}
}
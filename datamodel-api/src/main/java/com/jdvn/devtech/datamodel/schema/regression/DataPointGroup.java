package com.jdvn.devtech.datamodel.schema.regression;

import java.util.Date;

import org.hibernate.annotations.Comment;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
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
@Table(name = "data_point_groups", schema = "regression", indexes = {
		@Index(name = "data_point_groups_index_on_id", columnList = "id") })
@Comment("Used to store the groupings of data points based on locality conditions.")
public class DataPointGroup {

	@Id
	@Comment("Identifier of the data group.")
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "model_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "data_point_groups_model_id_fkey"))
	@Comment("Model identifier of the group.")
	private Model model;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "data_point_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "data_point_groups_data_point_id_fkey"))
	@Comment("Data point identifier of the group.")
	private DataPoint dataPoint;

	@Column(length = 16)
	@Comment("Locality code for province, district or commune.")
	private String locality;
	
	@Comment("Is standard parcel as Y variable for generate model or not.")
	private boolean is_std_parcel;
	
	@Comment("The date that group is made.")
	private Date created_at;
}
package com.jdvn.devtech.datamodel.schema.valuation;

import java.util.Date;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
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
@Table(name = "sales_statistic", schema = "valuation", indexes = {@Index(name = "sales_statistic_on_rowidentifier", columnList = "rowidentifier")})
@Comment("Represents sales statistics produced through the analysis of transaction prices for monitoring price trends.")
public class SalesStatistic extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	@Comment("The analysis identifier.")
	private String id;	
	
	@Comment("The date that contract or declaration implement.")
	private Date analysis_date;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Price calculated average per square meter.")
	private Double average_price_per_square_meter;
	
	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Base price index calculated from transaction prices")
	private Double base_price_index;

	@Comment("The date to implement analysis of base price index.")
	private Date base_price_date;

	@Column(columnDefinition = "numeric(20,2) NOT NULL DEFAULT 0")
	@Comment("Price index calculated from transaction prices")
	private Double price_index;

	@Comment("The date to implement analysis of price index.")
	private Date price_date;
	
	@Override
	public String print() {
		return id;
	}
	

}
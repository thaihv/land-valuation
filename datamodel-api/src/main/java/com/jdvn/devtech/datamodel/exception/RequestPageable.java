package com.jdvn.devtech.datamodel.exception;

import org.apache.commons.lang3.math.NumberUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class RequestPageable {
	public static final Integer DEFAULT_PAGE = NumberUtils.INTEGER_ONE;
	public static final Integer DEFAULT_RPP = Integer.valueOf(10);

	@JsonProperty private Integer page = DEFAULT_PAGE;
	@JsonProperty private Integer rpp = DEFAULT_RPP;

	@JsonIgnore
	public int getOffset() {
		return (getPage() - 1) * getRpp();
	}
	@JsonIgnore
	public final int getNumberOfRows() {
		return getRpp();
	}
}
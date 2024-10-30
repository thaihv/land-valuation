package com.jdvn.valuation.landpublic.except;

import org.apache.commons.lang3.ObjectUtils;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ResponseError {
	@JsonProperty private String code;
	@JsonProperty private String message;
	@JsonProperty private String description;

	public ResponseError(String code, String message) {
		this.code = code;
		this.message = message;
		this.description = message;
	}
	public String getDescription() {
		return ObjectUtils.isEmpty(description) ? message : description;
	}
}
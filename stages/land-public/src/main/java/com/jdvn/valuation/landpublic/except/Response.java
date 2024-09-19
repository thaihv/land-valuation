package com.jdvn.valuation.landpublic.except;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class Response<T> {
	@JsonProperty private String status;
	@JsonProperty private String result;
	@JsonProperty private ResponseError error;
	@JsonProperty private T data;
}
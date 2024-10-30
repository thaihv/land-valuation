package com.jdvn.valuation.landpublic.except;

import com.fasterxml.jackson.annotation.JsonValue;

public interface Type<T> {
	@JsonValue
	T getValue();

	String getDescription();
}
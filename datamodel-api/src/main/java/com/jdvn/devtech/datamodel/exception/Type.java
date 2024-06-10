package com.jdvn.devtech.datamodel.exception;

import com.fasterxml.jackson.annotation.JsonValue;

public interface Type<T> {
	@JsonValue
	T getValue();

	String getDescription();
}
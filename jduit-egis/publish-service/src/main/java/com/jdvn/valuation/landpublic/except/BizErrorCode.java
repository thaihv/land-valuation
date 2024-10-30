package com.jdvn.valuation.landpublic.except;

public enum BizErrorCode implements ErrorCodeType {

	/**
	 * Error General exception.
	 */
	E0001("E0001", "Exception error."), 
	E0002("E0002", "Record not found."), 
	E0003("E0003", "Data is invalid."),
	E0004("E0004", "Access to this location is not allowed."),
	E0005("E0005", "Your credentials are not sufficiently trusted."),;

	
	final String value;
	final String description;

	BizErrorCode(String value, String description) {
		this.value = value;
		this.description = description;
	}

	@Override
	public String getValue() {
		return value;
	}

	@Override
	public String getDescription() {
		return description;
	}

}
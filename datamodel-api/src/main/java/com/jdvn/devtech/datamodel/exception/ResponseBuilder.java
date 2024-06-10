package com.jdvn.devtech.datamodel.exception;

public class ResponseBuilder<T> {
	private final Response<T> responseVO = new Response<>();

	private ResponseBuilder<T> result(String result) {
		responseVO.setResult(result);
		return this;
	}

	private ResponseBuilder<T> status(String status) {
		responseVO.setStatus(status);
		return this;
	}

	public ResponseBuilder<T> success() {
		return new ResponseBuilder<T>().result("Succeed").status("200");
	}

	public ResponseBuilder<T> fail() {
		return new ResponseBuilder<T>().result("Failed").status("500");
	}

	public ResponseBuilder<T> error(ResponseError error) {
		responseVO.setError(error);
		responseVO.setResult("Failed");
		responseVO.setStatus("500");
		return this;
	}

	public ResponseBuilder<T> addData(final T body) {
		responseVO.setData(body);
		responseVO.setResult("Succeeded");
		responseVO.setStatus("200");
		return this;
	}

	public Response<T> build() {
		return responseVO;
	}
}
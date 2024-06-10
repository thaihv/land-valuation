package com.jdvn.devtech.datamodel.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

@RestControllerAdvice
@Slf4j
public class RestExceptionHandlerAdvice {

	@SuppressWarnings("rawtypes")
	@SneakyThrows
	@ExceptionHandler(Exception.class)
	public ResponseEntity<Response> responseException(Exception ex) {
		log.error("Exception {}", ex.getMessage(), ex);
		return new ResponseEntity<>(
				new ResponseBuilder<>().fail().error(new ResponseError(BizErrorCode.E0001.getValue(),
						BizErrorCode.E0001.getDescription(), ex.getLocalizedMessage())).build(),
				HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@SuppressWarnings("rawtypes")
	@ExceptionHandler(BizException.class)
	public ResponseEntity<Response> responseBizException(BizException ex) {
		log.error("BizException {}", ex.getMessage(), ex);
		return new ResponseEntity<>(
				new ResponseBuilder<>().fail()
						.error(new ResponseError(ex.getError().getValue(), ex.getError().getDescription())).build(),
				HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
package com.jdvn.devtech.datamodel.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.preparation.ValuationParameter;

@RepositoryRestResource
public interface ValuationParameterRepository extends CrudRepository<ValuationParameter, Long> {
}
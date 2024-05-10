package com.jdvn.devtech.datamodel.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.valuation.ValueType;

@RepositoryRestResource
public interface ValueTypeRepository extends CrudRepository<ValueType, String> {
}
package com.jdvn.devtech.datamodel.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.regression.Model;

@RepositoryRestResource
public interface RegressionModelRepository extends CrudRepository<Model, Long> {
}
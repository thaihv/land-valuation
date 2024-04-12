package com.jdvn.devtech.datamodel.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.source.Source;

@RepositoryRestResource
public interface SourceRepository extends CrudRepository<Source, Long> {
}
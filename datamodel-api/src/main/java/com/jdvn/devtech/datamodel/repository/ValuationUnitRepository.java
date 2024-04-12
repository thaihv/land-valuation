package com.jdvn.devtech.datamodel.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.preparation.ValuationUnit;

@RepositoryRestResource
public interface ValuationUnitRepository extends PagingAndSortingRepository<ValuationUnit, Long>, CrudRepository<ValuationUnit, Long> {	
	List<ValuationUnit> findAllByName(String name, Pageable pageable);
}
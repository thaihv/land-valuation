package com.jdvn.devtech.datamodel.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;

@RepositoryRestResource
public interface ValuationUnitCategoryRepository extends PagingAndSortingRepository<ValuationUnitCategory, String>, CrudRepository<ValuationUnitCategory, String> {	
	Page<ValuationUnitCategory> findAllByName(String name, Pageable pageable);
}
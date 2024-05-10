package com.jdvn.devtech.datamodel.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;

@RepositoryRestResource
public interface ValuationUnitCategoryRepository extends PagingAndSortingRepository<ValuationUnitCategory, Long>, CrudRepository<ValuationUnitCategory, Long> {	
	List<ValuationUnitCategory> findAllByName(String name, Pageable pageable);
}
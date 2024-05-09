package com.jdvn.devtech.datamodel.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitType;

@RepositoryRestResource
public interface ValuationUnitTypeRepository extends PagingAndSortingRepository<ValuationUnitType, Long>, CrudRepository<ValuationUnitType, Long> {	
	List<ValuationUnitType> findAllByName(String name, Pageable pageable);
}
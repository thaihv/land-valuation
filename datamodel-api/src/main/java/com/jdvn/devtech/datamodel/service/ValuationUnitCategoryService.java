package com.jdvn.devtech.datamodel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.jdvn.devtech.datamodel.dto.UnitCategoryAttributesDTO;
import com.jdvn.devtech.datamodel.repository.ValuationUnitCategoryRepository;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;

import jakarta.transaction.Transactional;
import lombok.NonNull;

public class ValuationUnitCategoryService {
	
	@Autowired
	private ValuationUnitCategoryRepository vuCategoryRepository;
	
    public Optional<ValuationUnitCategory> findByCategoryCode(@NonNull String code) {
        return this.vuCategoryRepository.findById(code);
    }
    
    public List<ValuationUnitCategory> findByCategoryName(@NonNull String name, int from, int to) {    	
    	Pageable pageable = PageRequest.of(from, to, Sort.by("name").descending());
        return this.vuCategoryRepository.findAllByName(name, pageable);
    }
    
    public List<ValuationUnitCategory> findAllCategories() {    	
        return (List<ValuationUnitCategory>) this.vuCategoryRepository.findAll();
    }
    
    @Transactional
    public void addCategory(@NonNull ValuationUnitCategory vu_categoryToAdd) {
    	this.vuCategoryRepository.save(vu_categoryToAdd);
    }
    @Transactional
    public void removeCategory(@NonNull String code) {
    	Optional<ValuationUnitCategory> vu_Category = this.findByCategoryCode(code);
        this.vuCategoryRepository.delete(vu_Category.get());
    }
    @Transactional
    public void removeCategory(@NonNull ValuationUnitCategory vu_categoryToRemove) {
    	this.vuCategoryRepository.delete(vu_categoryToRemove);
    }

    @Transactional
    public ValuationUnitCategory updateValuationUnitCategoryAttributes(@NonNull String code, @NonNull UnitCategoryAttributesDTO dtoAttrs) {
    	ValuationUnitCategory vu_Category = this.vuCategoryRepository.findById(code).get();
        if (dtoAttrs.getCode() != null && !dtoAttrs.getCode().isEmpty()) {
        	vu_Category.setCode(dtoAttrs.getCode());
        }
        if (dtoAttrs.getName() != null && !dtoAttrs.getName().isEmpty()) {
        	vu_Category.setName(code);
        }
        return this.vuCategoryRepository.save(vu_Category);
    }
    
}

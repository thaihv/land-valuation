package com.jdvn.devtech.datamodel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jdvn.devtech.datamodel.dto.UnitCategoryAttributesDTO;
import com.jdvn.devtech.datamodel.repository.ValuationUnitCategoryRepository;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;

import jakarta.transaction.Transactional;
import lombok.NonNull;

@Service
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
	public void addCategory(@NonNull UnitCategoryAttributesDTO categoryToAdd) {
		Optional<ValuationUnitCategory> checkExistOne = this.vuCategoryRepository.findById(categoryToAdd.getCode());
		if (checkExistOne.isPresent()) {
			return;
		}else {
			ValuationUnitCategory newOne = new ValuationUnitCategory();
			newOne.setCode(categoryToAdd.getCode());
			newOne.setName(categoryToAdd.getName());
			newOne.setDescription(categoryToAdd.getDescription());
			if (categoryToAdd.getStatus().length() == 1)
				newOne.setStatus(categoryToAdd.getStatus().charAt(0));
			this.vuCategoryRepository.save(newOne);			
		}				
	}

	@Transactional
	public void addCategory(@NonNull ValuationUnitCategory vu_categoryToAdd) {
		Optional<ValuationUnitCategory> newOne = this.vuCategoryRepository.findById(vu_categoryToAdd.getCode());
		if (newOne.isPresent()) {
			return;
		} else
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
	public ValuationUnitCategory updateValuationUnitCategoryAttributes(
			@NonNull UnitCategoryAttributesDTO unitCategoryAttributes) {
		Optional<ValuationUnitCategory> vu_Category = this.vuCategoryRepository.findById(unitCategoryAttributes.getCode());
		if (vu_Category.isPresent()) {
			ValuationUnitCategory newOne = vu_Category.get();
			
			if (unitCategoryAttributes.getName() != null && !unitCategoryAttributes.getName().isEmpty()) {
				newOne.setName(unitCategoryAttributes.getName());
			}
			newOne.setDescription(unitCategoryAttributes.getDescription());
			if (unitCategoryAttributes.getStatus().length() == 1)
				newOne.setStatus(unitCategoryAttributes.getStatus().charAt(0));
			return this.vuCategoryRepository.save(newOne);
		}
		return null;
	}

}

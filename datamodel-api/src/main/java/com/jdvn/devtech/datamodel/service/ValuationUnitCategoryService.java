package com.jdvn.devtech.datamodel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.jdvn.devtech.datamodel.dto.UnitCategoryAttributesDTO;
import com.jdvn.devtech.datamodel.exception.RequestPageable;
import com.jdvn.devtech.datamodel.repository.ValuationUnitCategoryRepository;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;
import com.jdvn.devtech.datamodel.utils.FieldPatcher;

import jakarta.transaction.Transactional;
import lombok.NonNull;

@Service
public class ValuationUnitCategoryService {
	
	@Autowired
	FieldPatcher fieldPatcher;
	
	@Autowired
	private ValuationUnitCategoryRepository vuCategoryRepository;

	public Optional<ValuationUnitCategory> findByCategoryCode(@NonNull String code) {
		return this.vuCategoryRepository.findById(code);
	}

	public Page<ValuationUnitCategory> findByCategoryName(@NonNull String name, @NonNull RequestPageable pageable ) {
		Pageable p = PageRequest.of(pageable.getPage() - 1, pageable.getRpp(), Sort.by("name").descending());		
		return this.vuCategoryRepository.findAllByName(name, p);
	}

	public Page<ValuationUnitCategory> findAllCategories(@NonNull RequestPageable pageable) {
		Pageable p = PageRequest.of(pageable.getPage() - 1, pageable.getRpp());
		return this.vuCategoryRepository.findAll(p);
	}
	public List<ValuationUnitCategory> findAllCategories() {
		return (List<ValuationUnitCategory>) this.vuCategoryRepository.findAll();
	}
	@Transactional
	public ValuationUnitCategory addCategory(@NonNull UnitCategoryAttributesDTO categoryToAdd) {
		Optional<ValuationUnitCategory> checkExistOne = this.vuCategoryRepository.findById(categoryToAdd.getCode());
		if (checkExistOne.isPresent()) {
			return checkExistOne.get();
		}else {
			ValuationUnitCategory newOne = new ValuationUnitCategory();
			newOne.setCode(categoryToAdd.getCode());
			newOne.setName(categoryToAdd.getName());
			newOne.setDescription(categoryToAdd.getDescription());
			newOne.setStatus(categoryToAdd.getStatus());
			return this.vuCategoryRepository.save(newOne);			
		}				
	}

	@Transactional
	public ValuationUnitCategory addCategory(@NonNull ValuationUnitCategory vu_categoryToAdd) {
		Optional<ValuationUnitCategory> newOne = this.vuCategoryRepository.findById(vu_categoryToAdd.getCode());
		if (newOne.isPresent()) {
			return newOne.get();
		} else
			return this.vuCategoryRepository.save(vu_categoryToAdd);
	}

	@Transactional
	public void removeCategory(@NonNull String code) {
		Optional<ValuationUnitCategory> existingOne = this.findByCategoryCode(code);
		if (existingOne.isPresent())
			this.vuCategoryRepository.delete(existingOne.get());
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
			ValuationUnitCategory existingOne = vu_Category.get();
			try {
				FieldPatcher.doPatchingFields(existingOne, unitCategoryAttributes);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			return this.vuCategoryRepository.save(existingOne);
		}
		else {
			return null;
		}
	}

	@Transactional
	public ValuationUnitCategory updateOrSaveValuationUnitCategoryAttributes(
			@NonNull UnitCategoryAttributesDTO unitCategoryAttributes) {
		Optional<ValuationUnitCategory> vu_Category = this.vuCategoryRepository.findById(unitCategoryAttributes.getCode());
		if (vu_Category.isPresent()) {
			ValuationUnitCategory existingOne = vu_Category.get();
			try {
				FieldPatcher.doPatchingFields(existingOne, unitCategoryAttributes);
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return this.vuCategoryRepository.save(existingOne);
		}
		else {
			ValuationUnitCategory newOne = new ValuationUnitCategory();
			try {
				FieldPatcher.doPatchingFields(newOne, unitCategoryAttributes);
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return this.vuCategoryRepository.save(newOne);			
		}
	}
}

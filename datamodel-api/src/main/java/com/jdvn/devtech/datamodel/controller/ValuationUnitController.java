package com.jdvn.devtech.datamodel.controller;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.jdvn.devtech.datamodel.repository.ValuationUnitRepository;
import com.jdvn.devtech.datamodel.schema.preparation.ValuationUnit;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/ValuationUnits/v1")
public class ValuationUnitController {

	@Autowired
	private ValuationUnitRepository valuationUnitRepository;
	

	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Iterable<ValuationUnit> getAllValuationUnitTypes() {
		return valuationUnitRepository.findAll();
	}

	@GetMapping("/find/{id}")
	public Optional<ValuationUnit> findValuationUnitTypeById(@PathVariable Long id) {
		return valuationUnitRepository.findById(id);
	}
	@GetMapping("/findbyname/{name}")
	public List<ValuationUnit> findValuationUnitTypeByName(@PathVariable String name, @RequestParam int from, @RequestParam int to) {
		if (to > from) {
			Pageable pageable = PageRequest.of(from, to, Sort.by("name").descending());
			return valuationUnitRepository.findAllByName(name, pageable);			
		}
		else {
			Pageable pageable = PageRequest.of(0, 1, Sort.by("name").descending());
			return valuationUnitRepository.findAllByName(name, pageable);			
		}

	}
	@PostMapping("/update")
	public ValuationUnit updateValuationUnitType(@RequestBody ValuationUnit valuationUnitType) {
		return valuationUnitRepository.save(valuationUnitType);
	}

	@PostMapping("/create")
	public Iterable<ValuationUnit> createValuationUnitType(@RequestBody ValuationUnit valuationUnitType) {
		valuationUnitRepository.save(valuationUnitType);
		return valuationUnitRepository.findAll();
	}

	@DeleteMapping("/delete/{id}")
	public void deleteValuationUnitType(@PathVariable Long id) {
		valuationUnitRepository.deleteById(id);
	}
}
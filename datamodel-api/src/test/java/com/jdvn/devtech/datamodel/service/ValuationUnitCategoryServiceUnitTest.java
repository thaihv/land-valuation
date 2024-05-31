package com.jdvn.devtech.datamodel.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import com.jdvn.devtech.datamodel.repository.ValuationUnitCategoryRepository;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;

@ExtendWith(MockitoExtension.class)
public class ValuationUnitCategoryServiceUnitTest {

	private final ValuationUnitCategory vu_codo = ValuationUnitCategory.builder().code("codominium").name("Codominium")
			.description("For using with Mockito Unit test").status('i').build();

	private final ValuationUnitCategory vu_legal_space = ValuationUnitCategory.builder().code("legalSpace")
			.name("Legal Space").description("For using with Mockito Unit test").status('i').build();

	private final List<ValuationUnitCategory> vuCategories = Arrays.asList(this.vu_codo, this.vu_legal_space);

	@Mock
	private ValuationUnitCategoryRepository mockvuCategoryRepository;

	@InjectMocks
	private ValuationUnitCategoryService vuCategoryService;

	@BeforeAll
	public static void beforeAll() {
		MockitoAnnotations.openMocks(ValuationUnitCategoryServiceUnitTest.class);
	}

	@Test
	public void whenValuationUnitCategoryAdded_thenActiveExpected() {

		ValuationUnitCategory vuCategoryToAdd = this.vuCategories.get(new Random().nextInt(this.vuCategories.size()));
		Mockito.when(this.mockvuCategoryRepository.save(Mockito.any(ValuationUnitCategory.class))).thenReturn(vuCategoryToAdd);
		this.vuCategoryService.addCategory(vuCategoryToAdd);

		Mockito.verify(this.mockvuCategoryRepository, Mockito.times(1)).save(Mockito.any(ValuationUnitCategory.class));
	}
	@Test
    public void whenValuationUnitCategoryDeleted_thenNotFoundExpected() {
        Mockito.doNothing().when(this.mockvuCategoryRepository).delete(Mockito.any(ValuationUnitCategory.class));
        this.vuCategoryService.removeCategory(this.vuCategories.get(new Random().nextInt(this.vuCategories.size())));

        Mockito.verify(this.mockvuCategoryRepository, Mockito.times(1))
                .delete(Mockito.any(ValuationUnitCategory.class));
    }
	
    @ParameterizedTest
    @CsvFileSource(resources = {"/mock_tests.csv"}, numLinesToSkip = 1)
    public void whenValuationUnitCategoryQueried_thenDetailsAsExpected(String queriedBy, String queryValue) {
    	List<ValuationUnitCategory> objValuationUnitCategories = new ArrayList<>();
    	Optional<ValuationUnitCategory> vu_codo = null;
        boolean isParamCode = queriedBy.equals("code");

        if (isParamCode) {
            Mockito.when(this.mockvuCategoryRepository.findAll())
                    .thenReturn(this.vuCategories);
            
            objValuationUnitCategories = this.vuCategoryService.findAllCategories();
            vu_codo = this.vuCategoryService.findByCategoryCode(queryValue);
            
        }

        if (vu_codo.isPresent()) {
        	System.out.println(vu_codo.get().getName());
        	Assertions.assertEquals("Codominium", vu_codo.get().getName());
        }
        	
        Assertions.assertEquals(this.vuCategories.size(), objValuationUnitCategories.size());
        for (int idx = 0; idx < this.vuCategories.size(); idx++) {
            Assertions.assertEquals(this.vuCategories.get(idx).getCode(), objValuationUnitCategories.get(idx).getCode());
        }
    }
}
-- SCRIPTS: Get category and valuation object type for generic Parcel (category 9) 
SELECT A.id, A.name, A.description, B.name as type
FROM preparation.valuation_unit_category A, preparation.valuation_unit_type B
WHERE A.vunit_type_id = B.id AND A.id = 9;

-- SCRIPTS: Get valuation parameters of parcel (category 9)  
SELECT B.id, B.name, B.type, B.description, B.is_active, B.is_mandatory, B.is_virtual 
FROM preparation.valuation_parameter B
WHERE B.id IN (
SELECT parameter_id
FROM preparation.categories_parameters_links
WHERE category_id = 9) AND B.is_virtual = false

-- SCRIPTS: Get parameter (ori_rad 82) and its settings 
SELECT B.name, B.type, B.description, A.key, A.value
FROM preparation.parameter_setting A, preparation.valuation_parameter B 
WHERE A.id = B.id AND B.id = 82
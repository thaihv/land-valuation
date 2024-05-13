-- SCRIPTS: Get type and valuation object category for generic Parcel (type 9) 
SELECT A.id, A.name, A.description, B.name as type
FROM valuation.valuation_unit_type A, valuation.valuation_unit_category B
WHERE A.vunit_category_id = B.id AND A.id = 9;

-- SCRIPTS: Get valuation parameters of parcel (type 9)  
SELECT B.code, B.name, B.type, B.description, B.is_active, B.is_mandatory, B.is_virtual 
FROM preparation.tech_parameter B
WHERE B.code IN (
SELECT parameter_code
FROM preparation.types_parameters_links
WHERE type_id = 9) AND B.is_virtual = false

-- SCRIPTS: Get parameter (ori_rad) and its settings 
SELECT B.name, B.type, B.description, A.key, A.value
FROM preparation.parameter_setting A, preparation.tech_parameter B 
WHERE A.code = B.code AND B.code = 'ori_rad'
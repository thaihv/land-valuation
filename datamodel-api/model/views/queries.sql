-- View a category with id = 4 with parameters	
SELECT A.name, B.name, B.type, B.description 
FROM preparation.valuation_unit_category A, preparation.valuation_parameter B 
WHERE A.id = 4 AND B.id IN(
	SELECT parameter_id 
	FROM preparation.categories_parameters_links 
	WHERE category_id = 4)
	
-- Convert row in parameter_setting with parameter id = 2 to column with specific keys	
SELECT
    name,
    MAX(CASE WHEN key = 'Max value' THEN value END) AS Max_value,
    MAX(CASE WHEN key = 'Min value' THEN value END) AS Min_value,
	MAX(CASE WHEN key = 'Precision' THEN value END) AS Precision
FROM
    (SELECT A.name, B.key, B.value FROM preparation.valuation_parameter A, preparation.parameter_setting B
		WHERE A.id = B.id AND A.id = 2)
GROUP BY
    name;
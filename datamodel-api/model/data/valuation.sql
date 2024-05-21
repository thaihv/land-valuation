-- Table: valuation.valuation_unit_group_type
INSERT INTO valuation.valuation_unit_group_type(code, display_value, description, status) VALUES ('zone','Zone','The valuation zones can be useful to represent geographical parts of the country (i.e. postcode areas, enumeration districts, towns or regions, or even as, for examples buffers on high streets or industrial zones), which may have similar statistical influence on the technical parameters and on the technical object value','a');
INSERT INTO valuation.valuation_unit_group_type(code, display_value, description, status) VALUES ('locality','Locality','The valuation groups can represent the geographical union of different parts of country with similar statistical characteristics (e.g. major city centers, rural suburbs, west/east of the country, etc.)','a');


-- Table: valuation.valuation_approach
INSERT INTO valuation.valuation_approach(code, display_value, status) VALUES ('salesComparison','Sales Comparison','a');
INSERT INTO valuation.valuation_approach(code, display_value, status) VALUES ('income','Income Method','a');
INSERT INTO valuation.valuation_approach(code, display_value, status) VALUES ('cost','Cost Method','a');

-- Table: valuation.appeal_status_type
INSERT INTO valuation.appeal_status_type (code, display_value, status) VALUES ('accepted', 'Accepted', 'a');
INSERT INTO valuation.appeal_status_type (code, display_value, status) VALUES ('inDecision', 'In Decision', 'a');
INSERT INTO valuation.appeal_status_type (code, display_value, status) VALUES ('rejected', 'Rejected', 'a');
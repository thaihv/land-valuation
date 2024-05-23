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

-- Table: valuation.mass_appraisal_analysis_type
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('multipleRegressionAnalysis', 'Multiple Regression Analysis', 'a');
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('artificialNeuralNetwork', 'Artificial Neural Network', 'a');
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('adaptiveEstimationProcedure', 'Adaptive Estimation Procedure', 'a');
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('timeSeriesAnalysis', 'Time Series Analysis', 'a');
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('clusterAnalysis', 'Cluster Analysis', 'a');
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('locationalValueResponseSurfaceAnalysis', 'Locational Value Response Surface Analysis', 'a');
INSERT INTO valuation.mass_appraisal_analysis_type (code, display_value, status) VALUES ('other', 'Other', 'a');

-- Table: valuation.appraisal_level_type
INSERT INTO valuation.appraisal_level_type (code, display_value, status) VALUES ('mean', 'Mean', 'a');
INSERT INTO valuation.appraisal_level_type (code, display_value, status) VALUES ('median', 'Median', 'a');
INSERT INTO valuation.appraisal_level_type (code, display_value, status) VALUES ('weightedMean', 'Weighted Mean', 'a');

-- Table: valuation.appraisal_uniformity_type
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('coefficientOfConcentration', 'Coefficient Of Concentration', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('coefficientOfDispersion', 'Coefficient Of Dispersion', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('coefficientOfVariation', 'Coefficient Of Variation', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('interquartileRange', 'Interquartile Range', 'i');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('medianAbsoluteDeviation', 'Median Absolute Deviation', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('medianPercentDeviation', 'Median Percent Deviation', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('range', 'Range', 'i');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('standardDeviation', 'Standard Deviation', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('weightedCoefficientDispersion', 'Weighted Coefficient Dispersion', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('weightedCoefficientVariation', 'Weighted Coefficient Variation', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('vif', 'VIF-Variance Inflation Factor', 'a');
INSERT INTO valuation.appraisal_uniformity_type (code, display_value, status) VALUES ('r2', 'R-Squared-Coefficient Of Determination', 'a');
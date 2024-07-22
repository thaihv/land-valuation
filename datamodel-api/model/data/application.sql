-- Table: application.request_category_type
INSERT INTO application.request_category_type (code, display_value, description, status) VALUES ('appraisalServices', 'Appraisal Services', 'Services for Mass Appraisals or Single Property Appraisal', 'a');
INSERT INTO application.request_category_type (code, display_value, description, status) VALUES ('surveyServices', 'Survey Services', 'Survey services for plans with 4-year cycle or for appraisal of specific properties', 'a');
INSERT INTO application.request_category_type (code, display_value, description, status) VALUES ('supportServices', 'Supporting Services', 'Services for providing valuation information or appeal handling', 'a');

-- Table: application.request_type
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('singleAgricultural', 'appraisalServices','Single Appraisal of Agricultural Parcel', 'Single Appraisal of Agricultural Lands', 'a', 10, 0.00, 0.00, 0.00);
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('massIndustry', 'appraisalServices', 'Mass Appraisal of Industry Parcels', 'Mass Appraisal of Industry Real Estates', 'a', 15, 50.00, 0.00, 0.00);
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('massResidential', 'appraisalServices', 'Mass Appraisal of Residential Parcels', 'Mass Appraisal of Residential Estates', 'a', 25, 50.00, 0.00, 0.00);
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('surveyPlan', 'surveyServices', 'Survey a Plan', 'Survey Request on Properties & Values of No-Valued Properties', 'a', 60, 0.00, 0.00, 0.00);
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('extractMap', 'supportServices', 'Extract Map', 'Extract Valuation Maps for Specific Zone or Locality', 'a', 1, 5.00, 0.00, 0.00);
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('historicExport', 'supportServices', 'Historic Export', 'Copy Historic Records of Property Values', 'a', 1, 5.00, 0.00, 0.00);
INSERT INTO application.request_type (code, request_category_code, display_value, description, status, nr_days_to_complete, base_fee, area_base_fee, value_base_fee) VALUES ('reappraisal', 'supportServices', 'Reappraisal', 'Explain and Response with most accurated & most update value due to an appeals on Values & Taxes', 'a', 1, 5.00, 0.00, 0.00);

-- Table: application.application_status_type
INSERT INTO application.application_status_type (code, display_value, status) VALUES ('requisitioned', 'Requisitioned', 'a');
INSERT INTO application.application_status_type (code, display_value, status, description) VALUES ('to-be-transferred', 'To be transferred', 'a', 'Application is marked for transfer.');
INSERT INTO application.application_status_type (code, display_value, status, description) VALUES ('transferred', 'Transferred', 'a', 'Application is transferred.');
INSERT INTO application.application_status_type (code, display_value, status) VALUES ('annulled', 'Annulled', 'a');
INSERT INTO application.application_status_type (code, display_value, status) VALUES ('approved', 'Approved', 'a');
INSERT INTO application.application_status_type (code, display_value, status) VALUES ('completed', 'Completed', 'a');
INSERT INTO application.application_status_type (code, display_value, status, description) VALUES ('lodged', 'Lodged', 'a', 'Application has been lodged and officially received by land office');

-- Table: application.application_action_type
INSERT INTO application.application_action_type (code, display_value, status_to_set, status) VALUES ('assign', 'Assign', NULL, 'a');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status) VALUES ('resubmit', 'Resubmit', 'lodged', 'a');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('archive', 'Archive', 'completed', 'a', 'Paper application records are archived (action is manually logged)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('approve', 'Approve', 'approved', 'a', 'Application is approved (automatically logged when application is approved successively)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('validateFailed', 'Quality Check Fails', NULL, 'a', 'Quality check fails (automatically logged when a critical business rule failure occurs)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('validatePassed', 'Quality Check Passes', NULL, 'a', 'Quality check passes (automatically logged when business rules are run without any critical failures)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status) VALUES ('unAssign', 'Unassign', NULL, 'a');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('requisition', 'Requisition', 'requisitioned', 'a', 'Further information requested from applicant (action is manually logged)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('transfer', 'Transfer', 'to-be-transferred', 'a', 'Marks the application for transfer');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status) VALUES ('lapse', 'Lapse', 'annulled', 'a');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('withdraw', 'Withdraw application', 'annulled', 'a', 'Application withdrawn by Applicant (action is manually logged)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status) VALUES ('addSpatialUnit', 'Add spatial unit', NULL, 'a');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('cancel', 'Cancel application', 'annulled', 'a', 'Application cancelled by Land Office (action is automatically logged when application is cancelled)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('addDocument', 'Add document', NULL, 'a', 'Scanned Documents linked to Application (action is automatically logged when a new document is saved)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('validate', 'Validate', NULL, 'a', 'The action validate does not leave a mark, because validateFailed and validateSucceded will be used instead when the validate is completed.');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('dispatch', 'Dispatch', NULL, 'a', 'Application documents and new land office products are sent or collected by applicant (action is manually logged)');
INSERT INTO application.application_action_type (code, display_value, status_to_set, status, description) VALUES ('lodge', 'Lodgement Notice Prepared', 'lodged', 'a', 'Lodgement notice is prepared (action is automatically logged when application details are saved for the first time');

-- Table: application.service_status_type
INSERT INTO application.service_status_type (code, display_value, status) VALUES ('cancelled', 'Cancelled', 'a');
INSERT INTO application.service_status_type (code, display_value, status) VALUES ('completed', 'Completed', 'a');
INSERT INTO application.service_status_type (code, display_value, status, description) VALUES ('lodged', 'Lodged', 'a', 'Application for a service has been lodged and officially received by land office');
INSERT INTO application.service_status_type (code, display_value, status) VALUES ('pending', 'Pending', 'c');

-- Table: application.service_action_type
INSERT INTO application.service_action_type (code, display_value, status_to_set, status, description) VALUES ('complete', 'Complete', 'completed', 'a', 'Application is ready for approval (action is automatically logged when service is marked as complete');
INSERT INTO application.service_action_type (code, display_value, status_to_set, status, description) VALUES ('lodge', 'Lodge', 'lodged', 'a', 'Application for service(s) is officially received by Land Valuation Office (action is automatically logged when application is saved for the first time)');
INSERT INTO application.service_action_type (code, display_value, status_to_set, status, description) VALUES ('revert', 'Revert', 'pending', 'a', 'The status of the service has been reverted to pending from being completed (action is automatically logged when a service is reverted back for further work)');
INSERT INTO application.service_action_type (code, display_value, status_to_set, status, description) VALUES ('cancel', 'Cancel', 'cancelled', 'a', 'Service is cancelled by Land Valuation Office (action is automatically logged when a service is cancelled)');
INSERT INTO application.service_action_type (code, display_value, status_to_set, status, description) VALUES ('start', 'Start', 'pending', 'a', 'Changes Made to Database as a result of application (action is automatically logged when a change is made to a valuation object)');


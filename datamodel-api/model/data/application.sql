-- Table: application.request_type
INSERT INTO application.request_type (code, display_value, description, status) VALUES ('massAppraisals', 'Mass Appraisal Services', 'Mass Appraisal Services', 'a');
INSERT INTO application.request_type (code, display_value, description, status) VALUES ('singleAppraisals', 'Single Appraisal Services', 'Single Appraisal Services', 'a');
INSERT INTO application.request_type (code, display_value, description, status) VALUES ('feeIndividual', 'Payment Individual Appraisal Services', 'Payment Individual Appraisal Services', 'i');

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


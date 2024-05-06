-- Table: source.availability_status_type
INSERT INTO source.availability_status_type (code, display_value, status, description) VALUES ('archiveConverted', 'Converted', 'c', '');
INSERT INTO source.availability_status_type (code, display_value, status, description) VALUES ('archiveDestroyed', 'Destroyed', 'x', '');
INSERT INTO source.availability_status_type (code, display_value, status, description) VALUES ('available', 'Available', 'c', '');
INSERT INTO source.availability_status_type (code, display_value, status, description) VALUES ('incomplete', 'Incomplete', 'c', '');
INSERT INTO source.availability_status_type (code, display_value, status, description) VALUES ('archiveUnknown', 'Unknown', 'c', '');

-- Table: source.presentation_form_type
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('documentDigital', 'Digital Document', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description)VALUES ('imageDigital', 'Digital Image', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('mapDigital', 'Digital Map', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('modelDigital', 'Digital Model', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('profileDigital', 'Digital Profile', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('tableDigital', 'Digital Table', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('videoDigital', 'Digital Video', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('documentHardcopy', 'Hardcopy Document', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('imageHardcopy', 'Hardcopy Image', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('mapHardcopy', 'Hardcopy Map', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('modelHarcopy', 'Hardcopy Model', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('profileHardcopy', 'Hardcopy Profile', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('tableHardcopy', 'Hardcopy Table', 'c', '');
INSERT INTO source.presentation_form_type (code, display_value, status, description) VALUES ('videoHardcopy', 'Hardcopy Video', 'c', '');

-- Table: source.source_type
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('restrictionOrder', 'Suppression Order', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('standardDocument', 'Standard Document', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('courtOrder', 'Court Order', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('mortgage', 'Mortgage', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('powerOfAttorney', 'Power of Attorney', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('proclamation', 'Proclamation', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('pdf', 'Pdf Scanned Document', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('will', 'Will', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('relationshipTitle', 'Vital Record', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('caveat', 'Caveat', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('agriConsent', 'Agricultural Consent', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('personPhoto', 'Person photo', 'c', 'Photo of the person');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('taxPayment', 'Tax payment', 'c', 'Tax payment');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('utilityBill', 'Utility bill', 'c', 'Utility bill');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('lease', 'Lease', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('tiff', 'Tiff Scanned Document', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('cadastralSurvey', 'Cadastral Survey', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('jpg', 'Jpg Scanned Document', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('agriLease', 'Agricultural Lease', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('title', 'Title', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('deed', 'Deed', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('tif', 'Tif Scanned Document', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('officeNote', 'Office Note', 'c', 'Document created by a staff member to note information or points of interest related to a given application');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('other', 'Other', 'c', 'Document that does not fit one of the other named categories.');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('requisition', 'Requisition Notice', 'c', 'Notice sent by the valuation agency to inform the agent of items that must be addressed with their application before the application can be processed and approved.');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('surveyDataFile', 'Survey Data File', 'c', 'A CSV data file containing survey coordinate points that can be imported when processing related to Cadastre data.');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('publicNotification', 'Public Notification for Systematic Land Valuation', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('agreement', 'Agreement', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('contractForSale', 'Contract for Sale', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('cadastralMap', 'Cadastral Map', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('idVerification', 'Proof of Identity', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('systematicValue', 'Systematic Valuation Application', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('objection', 'Objection  Document', 'x', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('waiver', 'Waiver', 'c', '');
INSERT INTO source.source_type (code, display_value, status, description) VALUES ('notaryStatement', 'Notary Statement', 'x', '');

-- Table: source.spatial_source_type
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('cadastralSurvey', 'Cadastral Survey', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('fieldSketch', 'Field Sketch', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('gnssSurvey', 'GNSS (GPS) Survey', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('orthoPhoto', 'Orthophoto', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('relativeMeasurement', 'Relative Measurements', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('surveyData', 'Survey Data (Coordinates)', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('topoMap', 'Topographical Map', 'c', '');
INSERT INTO source.spatial_source_type (code, display_value, status, description) VALUES ('video', 'Video', 'c', '');

-- Table: source.archive
INSERT INTO source.archive (id,name) VALUES ('7500fad4-0826-11ef-8b92-b7efa14863c6','Lao Land Information Land Registration Online');
INSERT INTO source.archive (id,name) VALUES ('80c3c648-0827-11ef-b971-8b13f18f3a14','National Cadastre Storage Center');

-- Table: source.source
INSERT INTO source.source (present_format, assess_nr, reference_nr, archive_id, document_id, acceptance, recordation, submission, expiration, ext_archive_id, availability_status_code, type_code, content, owner_name, version, description, signing_date) VALUES ('mapDigital', '120220-008000006', NULL, '7500fad4-0826-11ef-8b92-b7efa14863c6','74641dae-0826-11ef-85c9-d3ac41beaf89', NULL, NULL, '2011-06-29', NULL, NULL, 'available', 'cadastralMap', 'Cadastre Map from Registration Online', NULL, NULL, NULL, NULL);
INSERT INTO source.source (present_format, assess_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration, ext_archive_id, availability_status_code, type_code, content, owner_name, version, description, signing_date) VALUES (NULL, '140220-000000001', NULL, '80c3c648-0827-11ef-b971-8b13f18f3a14', NULL, '2014-02-20', '2014-02-20', NULL, 'd3ac733d-3679-4351-89ef-35151f2745a5', 'available', 'agreement', 'Deeds on Parcel Ownership ', NULL, NULL, NULL, NULL);
INSERT INTO source.source (present_format, assess_nr, reference_nr, archive_id, acceptance, recordation, submission, expiration, ext_archive_id, availability_status_code, type_code, content, owner_name, version, description, signing_date) VALUES (NULL, '150407-000000001', NULL, NULL, NULL, '2015-04-01', '2015-04-07', NULL, 'b6f24c42-1c88-4d5b-bffd-7a94487ae6a1', 'available', 'title', NULL, NULL, NULL, NULL, NULL);



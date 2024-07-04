-- Table: administrative.communication_type
INSERT INTO administrative.communication_type (code, display_value, status) VALUES ('eMail', 'e-Mail', 'a');
INSERT INTO administrative.communication_type (code, display_value, status) VALUES ('phone', 'Phone', 'a');
INSERT INTO administrative.communication_type (code, display_value, status) VALUES ('post', 'Post', 'a');
INSERT INTO administrative.communication_type (code, display_value, status) VALUES ('fax', 'Fax', 'a');
INSERT INTO administrative.communication_type (code, display_value, status) VALUES ('courier', 'Courier', 'a');

-- Table: administrative.gender_type
INSERT INTO administrative.gender_type (code, display_value, status) VALUES ('female', 'Female', 'a');
INSERT INTO administrative.gender_type (code, display_value, status) VALUES ('male', 'Male', 'a');
INSERT INTO administrative.gender_type (code, display_value, status) VALUES ('na', 'Not applicable', 'i');

-- Table: administrative.id_type
INSERT INTO administrative.id_type (code, display_value, status, description) VALUES ('nationalID', 'National ID', 'a', 'The main person ID that exists in the country');
INSERT INTO administrative.id_type (code, display_value, status, description) VALUES ('nationalPassport', 'National Passport', 'a', 'A passport issued by the country');
INSERT INTO administrative.id_type (code, display_value, status, description) VALUES ('otherPassport', 'Other Passport', 'a', 'A passport issued by another country');

-- Table: administrative.group_party_type
INSERT INTO administrative.group_party_type (code, display_value, status) VALUES ('association', 'Association', 'a');
INSERT INTO administrative.group_party_type (code, display_value, status) VALUES ('family', 'Family', 'a');
INSERT INTO administrative.group_party_type (code, display_value, status) VALUES ('baunitGroup', 'Basic Administrative Unit Group', 'i');
INSERT INTO administrative.group_party_type (code, display_value, status) VALUES ('tribe', 'Tribe', 'i');

-- Table: administrative.party_type
INSERT INTO administrative.party_type (code, display_value, status) VALUES ('naturalPerson', 'Natural Person', 'a');
INSERT INTO administrative.party_type (code, display_value, status) VALUES ('nonNaturalPerson', 'Non-natural Person', 'a');
INSERT INTO administrative.party_type (code, display_value, status) VALUES ('group', 'Group', 'a');
INSERT INTO administrative.party_type (code, display_value, status) VALUES ('baunit', 'Basic Administrative Unit', 'a');

-- Table: administrative.party_role_type
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('lodgingAgent', 'Lodging Agent', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('applicant', 'Applicant', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('moneyProvider', 'Money Provider', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('notary', 'Notary', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('bank', 'Bank', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('citizen', 'Citizen', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('inheritor', 'Inheritor', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('powerOfAttorney', 'Power of Attorney', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('landOfficer', 'Land Officer', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('conveyor', 'Conveyor', 'i');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('certifiedSurveyor', 'Licenced Surveyor', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('notifiablePerson', 'Notifiable Person', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('partner', 'Partner', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('stateAdministrator', 'Registrar / Approving Surveyor', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('spouse', 'Spouse', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('employee', 'Employee', 'i');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('surveyor', 'Surveyor', 'i');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('farmer', 'Farmer', 'i');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('transferee', 'Transferee (to)', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('transferor', 'Transferor (from)', 'a');
INSERT INTO administrative.party_role_type (code, display_value, status) VALUES ('writer', 'Writer', 'i');

-- Table: administrative.mortgage_type
INSERT INTO administrative.mortgage_type (code, display_value, status) VALUES ('levelPayment', 'Level Payment', 'a');
INSERT INTO administrative.mortgage_type (code, display_value, status) VALUES ('linear', 'Linear', 'a');
INSERT INTO administrative.mortgage_type (code, display_value, status) VALUES ('microCredit', 'Micro Credit', 'a');

-- Table: administrative.rrr_group_type
INSERT INTO administrative.rrr_group_type (code, display_value, status) VALUES ('rights', 'Rights', 'a');
INSERT INTO administrative.rrr_group_type (code, display_value, status) VALUES ('responsibilities', 'Responsibilities', 'a');
INSERT INTO administrative.rrr_group_type (code, display_value, status) VALUES ('restrictions', 'Restrictions', 'a');

-- Table: administrative.rrr_type
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('tenancy', 'rights', 'Tenancy', true, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('ownershipAssumed', 'rights', 'Ownership Assumed', true, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('customaryType', 'rights', 'Customary Right', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('caveat', 'restrictions', 'Caveat', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('commonOwnership', 'rights', 'Common Ownership', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('servitude', 'restrictions', 'Servitude', false, false, false, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('waterrights', 'rights', 'Water Right', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('waterwayMaintenance', 'responsibilities', 'Waterway Maintenance', false, false, false, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('agriActivity', 'rights', 'Agriculture Activity', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('noBuilding', 'restrictions', 'Building Restriction', false, false, false, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('grazing', 'rights', 'Grazing Right', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('lease', 'rights', 'Lease', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('monumentMaintenance', 'responsibilities', 'Monument Maintenance', false, false, false, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('mortgage', 'restrictions', 'Mortgage', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('ownership', 'rights', 'Ownership', true, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('usufruct', 'rights', 'Usufruct', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('monument', 'restrictions', 'Monument', false, true, true, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('occupation', 'rights', 'Occupation', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('superficies', 'rights', 'Superficies', false, true, true, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('informalOccupation', 'rights', 'Informal Occupation', false, false, false, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('lifeEstate', 'rights', 'Life Estate', true, true, true, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('adminPublicServitude', 'restrictions', 'Administrative Public Servitude', false, true, true, 'i');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('firewood', 'rights', 'Firewood Collection', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('fishing', 'rights', 'Fishing Right', false, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('apartment', 'rights', 'Apartment Ownership', true, true, true, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('historicPreservation', 'restrictions', 'Historic Preservation', false, false, false, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('limitedAccess', 'restrictions', 'Limited Access (to Road)', false, false, false, 'a');
INSERT INTO administrative.rrr_type (code, rrr_group_type_code, display_value, is_primary, share_check, party_required, status) VALUES ('stateOwnership', 'rights', 'State Ownership', true, false, false, 'a');

-- Table: administrative.condition_type
INSERT INTO administrative.condition_type (code, display_value, description, status) VALUES ('c1', 'Condition 1', 'Unless the Minister directs otherwise the Lessee shall fence the boundaries of the land within 6 (six) months of the date of the grant and the Lessee shall maintain the fence to the satisfaction of the Commissioner.', 'a');
INSERT INTO administrative.condition_type (code, display_value, description, status) VALUES ('c2', 'Condition 2', 'Unless special written authority is given by the Commissioner, the Lessee shall commence development of the land within 5 years of the date of the granting of a lease. This shall also apply to further development of the land held under a lease during the term of the lease.', 'a');
INSERT INTO administrative.condition_type (code, display_value, description, status) VALUES ('c3', 'Condition 3', 'Within a period of the time to be fixed by the planning authority, the Lessee shall provide at his own expense main drainage or main sewerage connections from the building erected on the land as the planning authority may require.', 'a');
INSERT INTO administrative.condition_type (code, display_value, description, status) VALUES ('c4', 'Condtion 4', 'The Lessee shall use the land comprised in the lease only for the purpose specified in the lease or in any variation made to the original lease.', 'a');
INSERT INTO administrative.condition_type (code, display_value, description, status) VALUES ('c5', 'Condition 5', 'Save with the written authority of the planning authority, no electrical power or telephone pole or line or water, drainage or sewer pipe being upon or passing through, over or under the land and no replacement thereof, shall be moved or in any way be interfered with and reasonable access thereto shall be preserved to allow for inspection, maintenance, repair, renewal and replacement.', 'a');
INSERT INTO administrative.condition_type (code, display_value, description, status) VALUES ('c6', 'Condition 6', 'The interior and exterior of any building erected on the land and all building additions thereto and all other buildings at any time erected or standing on the land and walls, drains and other appurtenances, shall be kept by the Lessee in good repair and tenantable condition to the satisfaction of the planning authority.', 'a');



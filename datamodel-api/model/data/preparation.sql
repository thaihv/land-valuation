-- Table: valuation.valuation_unit_category
INSERT INTO valuation.valuation_unit_category(code, name, description, status) VALUES ('parcel','Parcel','Represents land on which a specific building or set of buildings is located','a');
INSERT INTO valuation.valuation_unit_category(code, name, description, status) VALUES ('building','Building','Represents individual construction structure on the land parcel','a');
INSERT INTO valuation.valuation_unit_category(code, name, description, status) VALUES ('buildingUnit','Building Unit','Represents individual building units (e.g., apartments, stores, factory units) inside individual buildings, or even parts of a unit, e.g., store-front as required', 'a');
INSERT INTO valuation.valuation_unit_category(code, name, description, status) VALUES ('parcelBuilding','Parcel & Building','Represents a combination of valuation units on parcel and building','i');

-- Table: valuation.valuation_unit_type
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('agriculturalLand', 'Agricultural Land','Land used for Agriculture Purposes ','a', 'parcel');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('forestLand', 'Forest Land','Land used for Forestry Purposes','a', 'parcel');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('buildingLand', 'Building Land','Land is used for Development Purposes as Building or Living','a', 'parcel');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('singleFamilyHouse', 'Single Family House','House for Individuals or Households','a', 'building');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('residentialCondominium', 'Residential Condominium','Apartment for Residential Living','a', 'buildingUnit');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('commercialCondominium', 'Commercial Condominium','Apartment for Commercial Buildings','a', 'buildingUnit');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('parkingSpace', 'Parking Space','A Space Part of Building for Parking','i', 'buildingUnit');
INSERT INTO valuation.valuation_unit_type(code, name, description, status, vunit_category_code) VALUES ('garage', 'Garage','Area included to Building for Parking','i', 'buildingUnit');

-- Table: valuation.value_type
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('assessedValue','Assessement Value','The value is amount local government identifes the property worth','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('marketValue','Market Value','This value is refelct for market transaction. It is consumer-driven','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('appraisedValue','Appraised Value','This value is the amount a professional appraiser identifes the property worth','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('taxValue','Tax Value','This value is for taxing operations','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('financeValue','Financing Value','This value is for financing of real estate as sale,buy,rent or lease','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('compensationValue','Compensation Value','This value is for compensating upon revocation of land use rights or land consolidation','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('insuranceValue','Insurance Value','This value is for operating of insurance assessment', 'a');
INSERT INTO valuation.value_type(code, display_value, status) VALUES ('investmentValue','Investment Value', 'a');
INSERT INTO valuation.value_type(code, display_value, status) VALUES ('reversionaryValue','Reversionary Value', 'i');
INSERT INTO valuation.value_type(code, display_value, status) VALUES ('reconstrutionValue','Reconstrution Value', 'i');
INSERT INTO valuation.value_type(code, display_value, status) VALUES ('morgageLendingValue','Morgage Lending Value', 'i');
INSERT INTO valuation.value_type(code, display_value, status) VALUES ('netPresentValue','Net Present Value', 'i');
INSERT INTO valuation.value_type(code, display_value, status) VALUES ('synertegicValue','Synertegic Value', 'i');

-- Table: preparation.tech_parameter
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('id', 'ID','String','Property label from Cadastre.',true,true,true);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('purchasePrice','Purchase Price','Numeric','Price in purchase in time.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('landUse','Land Use','String','Indicates how people are using the land.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('location','Location','Geometry','Location of preparation property.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('boundary','Shape','Geometry','Shape geometry of preparation property.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('landParcelArea','Land Parcel Area','Numeric','Land boundary area of preparation property.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('heightAboveSeaLevel', 'Height Above Sea Level','Numeric','Measure of vertical distance (height, elevation or altitude) of location in reference to a vertical datum based on a historic mean sea level.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('slope','Slope','Numeric','A number that describes both the direction and the steepness compared to the plane',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('orientation','Orientation','String','Determination of the physical position in direction.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('soilType','Soil Type','String','Category of soil based on the dominating size of the particles within a soil as sand, clay, silt, peat, chalk and loam.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('landCover','Land Cover','String','Indicates the physical land type such as forest or open water (usually get from environmental information system).',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('precipitations','Precipitations','Numeric','Average rain water volume falls back per year (usually get from national hydrometeorological Institute).',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('numberOfSunnyHours', 'Number of Sunny Hours','Numeric','Average sunny time in a day (usually get from national hydrometeorological Institute).',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('improvements','Improvements','Boolean','Capability to be improvement .',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('woodMass','Wood Mass','Numeric','Estimate of wood massive.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('utilityInfrastructure','Utility Infrastructure','Enumerated','Utilities in list of cadastre.',true,true,true);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('zone','Zone','Geometry','An area or stretch of land having a particular characteristic, purpose, use, or subject to particular restrictions.',true,true,true);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('buildableArea', 'Buildable Area','Numeric','Capability to develop in term of area.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('numberOfFlats', 'Number of Flats','Numeric','Flat number for a condominium or building.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('buildingSurfaceArea', 'Building Surface Area','Numeric','Building area of a house is calculated.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('netUsableArea', 'Net usable area','Numeric','Reality usable area of a property.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('terraceBalconyLoggiaArea','Terrace, Balcony, and Loggia Area','Numeric','Additional spaces area as building parts.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('surfaceAreaOfParkingSpace','Surface Area of Parking Space','Numeric','Building Area of Parking Space.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('surfaceAreaOfGarage', 'Surface Area of Garage','Numeric','Building Area of Garage.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('elevator','Elevator','Boolean','Whether has elevator or not.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('dateOfConstruction', 'Date of Construction','Date','Date of construction in permit documents.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('dateOfLastRenovation', 'Date of Last Renovation','Date','Date of last renew or renovation.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('energyClass', 'Energy Class','String','Register of buildings energy type.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('numberOfRooms', 'Number of Rooms','Numeric','Room number for a flat or floor.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('numberOfBathrooms', 'Number of Bathrooms','Numeric','Bath room number for a flat or house.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('heatingType', 'Heating Type','String','Register of heating system type.',false,false,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('floor', 'Floor','String','Register of buildings energy certificates.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('numberOfFloors', 'Number of Floors','String','Floor number of a particular residential property.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('constructionCompletion', 'Construction Completion','Boolean','Whether in completion of buiding or not.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('commercialType', 'Commercial Type','String','Type of commerce or business in register.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('structureType', 'Structure Type','String','Type of building structure.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('directEntrance', 'Direct Entrance','Boolean','Whether has entrance directly or not.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('streetSide', 'Street Side','Numeric','Indicates distance to street the property standing.',true,true,false);
INSERT INTO preparation.tech_parameter(code, name, type, description, is_active, is_mandatory, is_virtual) VALUES ('closestStreetType', 'Closest Street Type','String','Indicates type of street the property is near by or contermious.',true,true,false);

-- Table: preparation.types_parameters_links
-- Categoty: Agricultural Land
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','landUse');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','boundary');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','landParcelArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','heightAboveSeaLevel');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','slope');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','orientation');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','soilType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','landCover');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','precipitations');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','numberOfSunnyHours');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('agriculturalLand','improvements');
-- Categoty: Forest Land
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','landParcelArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','landCover');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','improvements');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('forestLand','woodMass');
-- Categoty: Building Land
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','boundary');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','landParcelArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','utilityInfrastructure');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','zone');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('buildingLand','buildableArea');

-- Categoty: Single Family House
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','landParcelArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','utilityInfrastructure');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','zone');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','buildableArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','numberOfFlats');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','buildingSurfaceArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','netUsableArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','terraceBalconyLoggiaArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','surfaceAreaOfParkingSpace');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','surfaceAreaOfGarage');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','elevator');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','dateOfConstruction');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','dateOfLastRenovation');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','energyClass');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','numberOfRooms');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','heatingType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','numberOfFloors');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','constructionCompletion');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','commercialType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','structureType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','closestStreetType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('singleFamilyHouse','heightAboveSeaLevel');
-- Categoty: Residential Condominium
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','zone');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','buildingSurfaceArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','netUsableArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','terraceBalconyLoggiaArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','surfaceAreaOfParkingSpace');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','surfaceAreaOfGarage');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','elevator');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','dateOfConstruction');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','dateOfLastRenovation');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','energyClass');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','numberOfRooms');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','heatingType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','floor');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','constructionCompletion');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','commercialType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','structureType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','closestStreetType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('residentialCondominium','heightAboveSeaLevel');
-- Categoty: Commercial Condominium
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','zone');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','buildingSurfaceArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','netUsableArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','terraceBalconyLoggiaArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','surfaceAreaOfParkingSpace');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','surfaceAreaOfGarage');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','elevator');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','dateOfConstruction');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','dateOfLastRenovation');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','energyClass');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','numberOfRooms');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','heatingType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','floor');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','constructionCompletion');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','commercialType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','structureType');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','directEntrance');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','streetSide');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('commercialCondominium','heightAboveSeaLevel');
-- Categoty: Parking Space
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('parkingSpace','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('parkingSpace','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('parkingSpace','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('parkingSpace','landParcelArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('parkingSpace','streetSide');
-- Categoty: Garage
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('garage','id');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('garage','purchasePrice');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('garage','location');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('garage','landParcelArea');
INSERT INTO preparation.types_parameters_links(type_code, parameter_code) VALUES ('garage','streetSide');

-- Table: preparation.parameter_setting
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('purchasePrice','Min value','0');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('purchasePrice','Max value','9999');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('purchasePrice','Precision','2');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('id','Max Length','64');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('id','Format','UUcode');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('boundary','Geometry Format','OGC WKT');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('boundary','Length Unit','m');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('boundary','Area Unit','m2');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('boundary','Min Area','1');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('boundary','Geometry Type','Polygon');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('landParcelArea','Calculation Unit','m2');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('landParcelArea','Min Area','1');
INSERT INTO preparation.parameter_setting(code, key, value) VALUES ('landParcelArea','Max Area','1000000');

-- Table: preparation.utility_network_status_type
INSERT INTO preparation.utility_network_status_type (code, display_value, status) VALUES ('inUse', 'In Use', 'a');
INSERT INTO preparation.utility_network_status_type (code, display_value, status) VALUES ('outOfUse', 'Out of Use', 'a');
INSERT INTO preparation.utility_network_status_type (code, display_value, status) VALUES ('planned', 'Planned', 'a');

-- Table: preparation.utility_network_type
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('chemical', 'Chemicals', 'a');
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('electricity', 'Electricity', 'a');
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('gas', 'Gas', 'a');
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('heating', 'Heating', 'a');
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('oil', 'Oil', 'a');
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('telecommunication', 'Telecommunication', 'a');
INSERT INTO preparation.utility_network_type (code, display_value, status) VALUES ('water', 'Water', 'a');

-- Table: preparation.neighborhood_type
INSERT INTO preparation.neighborhood_type (code, display_value, status) VALUES ('urban', 'Urban', 'a');
INSERT INTO preparation.neighborhood_type (code, display_value, status) VALUES ('rural', 'Rural', 'a');
INSERT INTO preparation.neighborhood_type (code, display_value, status) VALUES ('suburban', 'Sub Urban', 'a');
INSERT INTO preparation.neighborhood_type (code, display_value, status) VALUES ('agricultural', 'Agricultural', 'a');


-- Table: preparation.building_use_type
INSERT INTO preparation.building_use_type(code, display_value, status) VALUES ('residential','Residential','a');
INSERT INTO preparation.building_use_type(code, display_value, status) VALUES ('office','Office','a');
INSERT INTO preparation.building_use_type(code, display_value, status) VALUES ('industrial','Industrial','a');

-- Table: administrative.area_type
INSERT INTO preparation.area_type (code, display_value, status) VALUES ('officialArea', 'Official Area', 'a');
INSERT INTO preparation.area_type (code, display_value, status) VALUES ('surveyedArea', 'Surveyed Area', 'a');
INSERT INTO preparation.area_type (code, display_value, status) VALUES ('calculatedArea', 'Calculated Area', 'a');
INSERT INTO preparation.area_type (code, display_value, status) VALUES ('nonOfficialArea', 'Non-official Area', 'a');

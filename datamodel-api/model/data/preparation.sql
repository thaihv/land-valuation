-- Table: valuation.valuation_unit_category
INSERT INTO valuation.valuation_unit_category(name, description, status) VALUES ('Parcel','Represents land on which a specific building or set of buildings is located','a');
INSERT INTO valuation.valuation_unit_category(name, description, status) VALUES ('Building','Represents individual construction structure on the land parcel','a');
INSERT INTO valuation.valuation_unit_category(name, description, status) VALUES ('Building Unit','Represents individual building units (e.g., apartments, stores, factory units) inside individual buildings, or even parts of a unit, e.g., store-front as required', 'a');
INSERT INTO valuation.valuation_unit_category(name, description, status) VALUES ('Parcel & Building','Represents a combination of valuation units on parcel and building','i');

-- Table: valuation.valuation_unit_type
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Agricultural Land','Land used for Agriculture Purposes ','a', 1);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Forest Land','Land used for Forestry Purposes','a', 1);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Building Land','Land is used for Development Purposes as Building or Living','a', 1);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Single Family House','House for Individuals or Households','a', 2);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Residential Condominium','Apartment for Residential Living','a', 3);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Commercial Condominium','Apartment for Commercial Buildings','a', 3);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Parking Space','A Space Part of Building for Parking','i', 3);
INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Garage','Area included to Building for Parking','i', 3);

-- Table: valuation.value_type
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('assessedValue','Assessement Value','The value is amount local government identifes the property worth','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('marketValue','Market Value','This value is refelct for market transaction. It is consumer-driven','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('appraisedValue','Appraised Value','This value is the amount a professional appraiser identifes the property worth','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('taxValue','Tax Value','This value is for taxing operations','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('financeValue','Financing Value','This value is for financing of real estate as sale,buy,rent or lease','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('compensationValue','Compensation Value','This value is for compensating upon revocation of land use rights or land consolidation','a');
INSERT INTO valuation.value_type(code, display_value, description, status) VALUES ('insuranceValue','Insurance Value','This value is for operating of insurance assessment', 'i');

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
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'landUse');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'boundary');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'landParcelArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'heightAboveSeaLevel');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'slope');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'orientation');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'soilType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'landCover');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'precipitations');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'numberOfSunnyHours');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (1,'improvements');
-- Categoty: Forest Land
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'landParcelArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'landCover');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'improvements');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (2,'woodMass');
-- Categoty: Building Land
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'boundary');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'landParcelArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'utilityInfrastructure');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'zone');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (3,'buildableArea');

-- Categoty: Single Family House
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'landParcelArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'utilityInfrastructure');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'zone');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'buildableArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'numberOfFlats');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'buildingSurfaceArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'netUsableArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'terraceBalconyLoggiaArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'surfaceAreaOfParkingSpace');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'surfaceAreaOfGarage');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'elevator');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'dateOfConstruction');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'dateOfLastRenovation');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'energyClass');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'numberOfRooms');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'heatingType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'numberOfFloors');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'constructionCompletion');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'commercialType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'structureType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'closestStreetType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (4,'heightAboveSeaLevel');
-- Categoty: Residential Condominium
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'zone');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'buildingSurfaceArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'netUsableArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'terraceBalconyLoggiaArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'surfaceAreaOfParkingSpace');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'surfaceAreaOfGarage');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'elevator');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'dateOfConstruction');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'dateOfLastRenovation');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'energyClass');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'numberOfRooms');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'heatingType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'floor');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'constructionCompletion');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'commercialType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'structureType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'closestStreetType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (5,'heightAboveSeaLevel');
-- Categoty: Commercial Condominium
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'zone');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'buildingSurfaceArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'netUsableArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'terraceBalconyLoggiaArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'surfaceAreaOfParkingSpace');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'surfaceAreaOfGarage');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'elevator');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'dateOfConstruction');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'dateOfLastRenovation');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'energyClass');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'numberOfRooms');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'heatingType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'floor');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'constructionCompletion');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'commercialType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'structureType');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'directEntrance');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'streetSide');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (6,'heightAboveSeaLevel');
-- Categoty: Parking Space
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (7,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (7,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (7,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (7,'landParcelArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (7,'streetSide');
-- Categoty: Garage
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (8,'id');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (8,'purchasePrice');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (8,'location');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (8,'landParcelArea');
INSERT INTO preparation.types_parameters_links(type_id, parameter_code) VALUES (8,'streetSide');

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


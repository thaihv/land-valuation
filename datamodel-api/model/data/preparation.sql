-- Table: preparation.value_type
INSERT INTO preparation.value_type(code, display_value, description, status) VALUES ('TAX','Tax Value','This value is for taxing operations','a');
INSERT INTO preparation.value_type(code, display_value, description, status) VALUES ('FIN','Financing Value','This value is for financing of real estate as sale,buy,rent or lease','a');
INSERT INTO preparation.value_type(code, display_value, description, status) VALUES ('COM','Compensation Value','This value is for compensating upon revocation of land use rights or land consolidation','a');
INSERT INTO preparation.value_type(code, display_value, description, status) VALUES ('ISUR','Insurance Value','This value is for operating of insurance assessment', 'i');

-- Table: preparation.valuation_unit_type
INSERT INTO preparation.valuation_unit_type(name, description, status) VALUES ('Parcel','Represents land on which a specific building or set of buildings is located','a');
INSERT INTO preparation.valuation_unit_type(name, description, status) VALUES ('Building','Represents individual construction structure on the land parcel','a');
INSERT INTO preparation.valuation_unit_type(name, description, status) VALUES ('Building Unit','Represents individual building units (e.g., apartments, stores, factory units) inside individual buildings, or even parts of a unit, e.g., store-front as required', 'a');
INSERT INTO preparation.valuation_unit_type(name, description, status) VALUES ('Parcel & Building','Represents a combination of valuation units on parcel and building','i');

-- Table: preparation.valuation_unit_category
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Agricultural Land','Land used for Agriculture Purposes ','a', 1);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Forest Land','Land used for Forestry Purposes','a', 1);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Building Land','Land is used for Development Purposes as Building or Living','a', 1);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Single Family House','House for Individuals or Households','a', 2);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Residential Condominium','Apartment for Residential Living','a', 3);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Commercial Condominium','Apartment for Commercial Buildings','a', 3);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Parking Space','A Space Part of Building for Parking','i', 3);
INSERT INTO preparation.valuation_unit_category(name, description, status, vunit_type_id) VALUES ('Garage','Area included to Building for Parking','i', 3);

-- Table: preparation.valuation_parameter
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ID','String','Property label from Cadastre.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Purchase Price','Numeric','Price in purchase in time.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Land Use','String','Indicates how people are using the land.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Location','Geometry','Location of valuation property.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Shape','Geometry','Shape geometry of valuation property.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Land Parcel Area','Numeric','Land boundary area of valuation property.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Height Above Sea Level','Numeric','Measure of vertical distance (height, elevation or altitude) of location in reference to a vertical datum based on a historic mean sea level.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Slope','Numeric','A number that describes both the direction and the steepness compared to the plane',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Orientation','String','Determination of the physical position in direction.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Soil Type','String','Category of soil based on the dominating size of the particles within a soil as sand, clay, silt, peat, chalk and loam.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Land Cover','String','Indicates the physical land type such as forest or open water (usually get from environmental information system).',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Precipitations','Numeric','Average rain water volume falls back per year (usually get from national hydrometeorological Institute).',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Number of Sunny Hours','Numeric','Average sunny time in a day (usually get from national hydrometeorological Institute).',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Improvements','Boolean','Capability to be improvement .',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Wood Mass','Numeric','Estimate of wood massive.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Utility Infrastructure','Enumerated','Utilities in list of cadastre.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Zone','Geometry','An area or stretch of land having a particular characteristic, purpose, use, or subject to particular restrictions.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Buildable Area','Numeric','Capability to develop in term of area.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Number of Flats','Numeric','Flat number for a condominium or building.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Building Surface Area','Numeric','Building area of a house is calculated.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Net usable area','Numeric','Reality usable area of a property.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Terrace, Balcony, and Loggia Area','Numeric','Additional spaces area as building parts.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Surface Area of Parking Space','Numeric','Building Area of Parking Space.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Surface Area of Garage','Numeric','Building Area of Garage.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Elevator','Boolean','Whether has elevator or not.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Date of Construction','Date','Date of construction in permit documents.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Date of Last Renovation','Date','Date of last renew or renovation.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Energy Class','String','Register of buildings energy type.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Number of Rooms','Numeric','Room number for a flat or floor.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Number of Bathrooms','Numeric','Bath room number for a flat or house.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Heating Type','String','Register of heating system type.',false,false,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Floor','String','Register of buildings energy
certificates.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Number of Floors','String','Floor number of a particular residential property.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Construction Completion','Boolean','Whether in completion of buiding or not.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Commercial Type','String','Type of commerce or business in register.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Structure Type','String','Type of building structure.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Direct Entrance','Boolean','Whether has entrance directly or not.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Street Side','Numeric','Indicates distance to street the property standing.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Closest Street Type ','String','Indicates type of street the property is near by or contermious.',true,true,false);


INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Rec_Area','Real','Diện tích hình chữ nhật nhỏ nhất
ngoại tiếp thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Con_Area','Real','Diện tích hình bao lồi (Convex
hull).',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Eff_Ratio','Real','Tỷ lệ diện tích hiệu dụng.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Con_Ratio','Real','Chỉ số độ cong.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Cnt_bld_co','Integer','Số tòa nhà xây dựng trên thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Area_bld_c','Real','Tổng diện tích các tòa nhà xây
dựng trên thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd100_Pave','Boolean','Tuyến đường trục chính gần nhất
đã cứng hóa chưa.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd100_Ele','Real','Cao độ của đường nhất trục chính gần.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd100_dst','Real','Khoảng cách từ thửa đất đến
đường trục chính gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat100X','Real','Tọa độ X của thửa đất ở điểm
gần đường trục chính nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat100Y','Real','Tọa độ Y của thửa đất ở điểm
gần đường trục chính nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near100X','Real','Tọa độ X của đường trục chính ở
điểm gần thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near100Y','Real','Tọa độ Y của đường trục chính ở
điểm gần thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd200_Pave','Boolean','Tuyến đường trục phụ gần nhất đã
cứng hóa chưa.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd200_Ele','Real','Cao độ của đường nhất trục phụ gần.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd200_dst','Real','Khoảng cách từ thửa đất đến
đường trục phụ gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat200X','Real','Tọa độ X của thửa đất ở điểm
gần đường trục phụ nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat200Y','Real','Tọa độ Y của thửa đất tại điểm
gần đường trục phụ nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near200X','Real','Tọa độ X của đường trục phụ tại
điểm gần nhất với thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near200Y','Real','Tọa độ Y của đường trục phụ tại
điểm gần nhất với thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd300_Pave','Boolean','Đường làng gần nhất đã cứng hóa
chưa.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd300_Ele','Real','Cao độ của đường làng gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd300_dst','Real','Khoảng cách đến nhấtđường làng gần.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat300X','Real','Tọa độ X của thửa đất tại điểm
gần với đường làng nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat300Y','Real','Tọa độ Y của thửa đất tại điểm
gần với đường làng nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near300X','Real','Tọa độ X của đường làng tại điểm
gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near300Y','Real','Tọa độ Y của đường làng tại điểm
gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd400_Pave','Boolean','Đường khác gần với thửa đất nhất
đã được cứng hóa chưa.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd400_Ele','Real','Cao độ của tuyến đường khác gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd400_dst','Real','Khoảng cách từ thửa đất đến tuyến
đường khác gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat400X','Real','Tọa độ X của thửa đất tại điểm
gần với đường khác nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat400Y','Real','Tọa độ Y của thửa đất tại điểm
gần với đường khác nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near400X','Real','Tọa độ X của đường khác tại
điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near400Y','Real','Tọa độ X của đường khác tại
điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('obj_ID','Integer','ID đơn giản phục vụ phân tích
không gian.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RoadDst','Real','Khoảng cách từ thửa đất đến con
đường gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RoadCls','Integer','Phân cấp của đường nhất gần với thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Pave','Boolean','Tuyến đường gần thửa đất nhất đã
cứng hóa chưa.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('featureX','Real','Tọa độ X của thửa đất ở điểm
gần với tuyến đường nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('featureY','Real','Tọa độ Y của thửa đất ở điểm
gần với tuyến đường nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('nearX','Real','Tọa độ X của tuyến đường ở
điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('nearY','Real','Tọa độ Y của tuyến đường ở
điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ori_rad','Real','Hướng của thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Elemean','Real','Cao độ của thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RoadEle','Real','Cao độ của đường gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('EleDiff','Real','Cao độ của thửa đất so với cao
độ của đường gần nhất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('cenX','Real','Tọa độ X của tâm thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('cenY','Real','Tọa độ Y của tâm thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('dst_railro','Real','Khoảng cách đến đường sắt.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('dst_statio','Real','Khoảng cách đến ga tàu Viêng
Chăn.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('adjRdCls','Integer','Phân cấp của đường tiếp giáp.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('objIDInt','Integer','ID đơn giản để phân tích không
gian.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schdst1','Real','Khoảng cách từ thửa đất đến
trường học gần nhấ.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schname1','String','Tên trường học gần nhất với thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schdst2','Real','Khoảng cách từ thửa đất đến
trường học gần thứ hai.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schname2','String','Tên trường học gần thứ hai tính
từ thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schdst3','Real','Khoảng cách từ thửa đất đến
trường học gần thứ ba.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schname3','String','Tên trường học gần thứ ba tính từ
thửa đất.',true,true,true);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('width_rd','Real','Chiều dài (rộng) mặt tiếp giáp với
đường của hình chữ nhất ngoại tiếp.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('height_rd','Real','Chiều sâu của hình chữ nhật ngoại
tiếp.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Shape','String','Hình dạng của thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Hwratio','Real','Tỷ lệ chiều rộng/chiều sâu.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('EleDiff100','Real','Chênh lệch cao độ với đường trục
lân cận.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RdDstStn','Real','Chiều dài quãng đường đến ga
Viêng Chăn.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('StID','String','ID đơn giản để phân tích không
gian.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds100_1','Real','Khoảng cách đến đường trục chính
gần thửa đất nhấ.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds100_2','Real','Khoảng cách đến đường trục chính
gần thứ hai tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds100_3','Real','Khoảng cách đến đường trục chính
gần thứ ba tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds200_1','Real','Khoảng cách đến đường trục phụ
gần nhất tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds200_2','Real','Khoảng cách đến đường trục phụ
gần thứ hai tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds200_3','Real','Khoảng cách đến đường trục phụ
gần thứ ba tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds300_1','Real','Khoảng cách đến đường làng gần nhất tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds300_2','Real','Khoảng cách đến đường làng gần
thứ hai tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds300_2','Real','Khoảng cách đến đường làng gần
thứ ba tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds400_1','Real','Khoảng cách đến đường khác gần nhất tính từ thửa đất.',true,true,false);
INSERT INTO preparation.valuation_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds400_2','Real','Khoảng cách đến đường khác gần
thứ hai tính từ thửa đất.',true,true,false);

-- Table: preparation.categories_parameters_links
-- Categoty: Agricultural Land
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,3);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,5);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,6);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,7);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,8);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,9);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,10);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,11);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,12);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,13);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (1,14);
-- Categoty: Forest Land
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,6);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,11);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,14);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (2,15);
-- Categoty: Building Land
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,5);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,6);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,16);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,17);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (3,18);

-- Categoty: Single Family House
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,6);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,16);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,17);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,18);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,19);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,20);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,21);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,22);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,23);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,24);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,25);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,26);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,27);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,28);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,29);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,30);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,31);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,32);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,33);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,34);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,38);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (4,39);
-- Categoty: Residential Condominium
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,17);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,20);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,21);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,22);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,23);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,24);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,25);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,26);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,27);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,28);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,29);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,30);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,31);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,32);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,33);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,34);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,38);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (5,39);
-- Categoty: Commercial Condominium
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,17);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,20);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,21);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,22);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,23);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,24);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,25);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,26);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,27);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,28);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,29);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,30);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,31);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,32);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,33);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,34);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,35);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,36);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,37);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,38);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (6,39);
-- Categoty: Parking Space
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (7,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (7,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (7,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (7,6);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (7,36);
-- Categoty: Garage
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (8,1);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (8,2);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (8,4);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (8,6);
INSERT INTO preparation.categories_parameters_links(category_id, parameter_id) VALUES (8,36);

-- Table: preparation.parameter_setting
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (2,'Min value','0');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (2,'Max value','9999');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (2,'Precision','2');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (1,'Max Length','64');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (1,'Format','UUID');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (5,'Geometry Format','OGC WKT');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (5,'Length Unit','m');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (5,'Area Unit','m2');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (5,'Min Area','1');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (5,'Geometry Type','Polygon');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (6,'Calculation Unit','m2');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (6,'Min Area','1');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (6,'Max Area','1000000');


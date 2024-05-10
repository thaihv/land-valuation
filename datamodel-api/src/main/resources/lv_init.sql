INSERT INTO valuation.valuation_unit_type(name, description, status, vunit_category_id) VALUES ('Generic Valuation Land','Land used for general valuation without specific purpose use','a', 1);

INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Rec_Area','Real','Diện tích hình chữ nhật nhỏ nhất ngoại tiếp thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Con_Area','Real','Diện tích hình bao lồi (Convex hull).',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Eff_Ratio','Real','Tỷ lệ diện tích hiệu dụng. Là tỷ lệ giữa diện tích của thửa đất với diện tích của hình chữ nhật ngoại tiếp nhỏ nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Con_Ratio','Real','Chỉ số độ cong. Là tỷ lệ giữa diện tích của thửa đất với diện tích của hình bao lồi.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Cnt_bld_co','Integer','Số tòa nhà xây dựng trên thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Area_bld_c','Real','Tổng diện tích các tòa nhà xây dựng trên thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd100_Pave','Boolean','Tuyến đường trục chính gần nhất đã cứng hóa chưa. As True/Yes: đã cứng hóa, False/No: chưa.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd100_Ele','Real','Cao độ của đường nhất trục chính gần.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd100_dst','Real','Khoảng cách từ thửa đất đến đường trục chính gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat100X','Real','Tọa độ X của thửa đất ở điểm gần đường trục chính nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat100Y','Real','Tọa độ Y của thửa đất ở điểm gần đường trục chính nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near100X','Real','Tọa độ X của đường trục chính ở điểm gần thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near100Y','Real','Tọa độ Y của đường trục chính ở điểm gần thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd200_Pave','Boolean','Tuyến đường trục phụ gần nhất đã cứng hóa chưa. As True/Yes: đã cứng hóa, False/No: chưa.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd200_Ele','Real','Cao độ của đường nhất trục phụ gần.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd200_dst','Real','Khoảng cách từ thửa đất đến đường trục phụ gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat200X','Real','Tọa độ X của thửa đất ở điểm gần đường trục phụ nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat200Y','Real','Tọa độ Y của thửa đất tại điểm gần đường trục phụ nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near200X','Real','Tọa độ X của đường trục phụ tại điểm gần nhất với thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near200Y','Real','Tọa độ Y của đường trục phụ tại điểm gần nhất với thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd300_Pave','Boolean','Đường làng gần nhất đã cứng hóa chưa. As True/Yes: đã cứng hóa, False/No: chưa.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd300_Ele','Real','Cao độ của đường làng gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd300_dst','Real','Khoảng cách đến nhấtđường làng gần.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat300X','Real','Tọa độ X của thửa đất tại điểm gần với đường làng nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat300Y','Real','Tọa độ Y của thửa đất tại điểm gần với đường làng nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near300X','Real','Tọa độ X của đường làng tại điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near300Y','Real','Tọa độ Y của đường làng tại điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd400_Pave','Boolean','Đường khác gần với thửa đất nhất đã được cứng hóa chưa. As True/Yes: đã cứng hóa, False/No: chưa.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd400_Ele','Real','Cao độ của tuyến đường khác gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('rd400_dst','Real','Khoảng cách từ thửa đất đến tuyến đường khác gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat400X','Real','Tọa độ X của thửa đất tại điểm gần với đường khác nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('feat400Y','Real','Tọa độ Y của thửa đất tại điểm gần với đường khác nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near400X','Real','Tọa độ X của đường khác tại điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('near400Y','Real','Tọa độ X của đường khác tại điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('obj_ID','Integer','ID đơn giản phục vụ phân tích không gian.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RoadDst','Real','Khoảng cách từ thửa đất đến con đường gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RoadCls','Integer','Phân cấp của đường nhất gần với thửa đất. As 100: đường trục chính, 200: đường trục phụ, 300: đường làng, 400: đường khác.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Pave','Boolean','Tuyến đường gần thửa đất nhất đã cứng hóa chưa. As True/Yes: đã cứng hóa, False/No: chưa.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('featureX','Real','Tọa độ X của thửa đất ở điểm gần với tuyến đường nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('featureY','Real','Tọa độ Y của thửa đất ở điểm gần với tuyến đường nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('nearX','Real','Tọa độ X của tuyến đường ở điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('nearY','Real','Tọa độ Y của tuyến đường ở điểm gần với thửa đất nhất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ori_rad','Real','Hướng của thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Elemean','Real','Cao độ của thửa đất. As Hướng Đông: Value = 0 tính ngược chiều kim đồng hồ là + cùng chiều kim đồng hồ là -, đơn vị radian',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RoadEle','Real','Cao độ của đường gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('EleDiff','Real','Cao độ của thửa đất so với cao độ của đường gần nhất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('cenX','Real','Tọa độ X của tâm thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('cenY','Real','Tọa độ Y của tâm thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('dst_railro','Real','Khoảng cách đến đường sắt.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('dst_statio','Real','Khoảng cách đến ga tàu Viêng Chăn.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('adjRdCls','Integer','Phân cấp của đường tiếp giáp. As 100: đường trục chính, 200: đường trục phụ, 300: đường làng, 400: đường khác.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('objIDInt','Integer','ID đơn giản để phân tích không gian.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schdst1','Real','Khoảng cách từ thửa đất đến trường học gần nhấ.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schname1','String','Tên trường học gần nhất với thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schdst2','Real','Khoảng cách từ thửa đất đến trường học gần thứ hai.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schname2','String','Tên trường học gần thứ hai tính từ thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schdst3','Real','Khoảng cách từ thửa đất đến trường học gần thứ ba.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('schname3','String','Tên trường học gần thứ ba tính từ thửa đất.',true,true,true);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('width_rd','Real','Chiều dài (rộng) mặt tiếp giáp với đường của hình chữ nhất ngoại tiếp.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('height_rd','Real','Chiều sâu của hình chữ nhật ngoại tiếp.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Shape','String','Hình dạng của thửa đất. As Values: Hình vuông, Hình chữ nhật ngang/dọc, Hình thang, Hình tam giác, Không định hình.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('Hwratio','Real','Tỷ lệ chiều rộng/chiều sâu.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('EleDiff100','Real','Chênh lệch cao độ với đường trục lân cận.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('RdDstStn','Real','Chiều dài quãng đường đến ga Viêng Chăn.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('StID','String','ID đơn giản để phân tích không gian.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds100_1','Real','Khoảng cách đến đường trục chính gần thửa đất nhấ.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds100_2','Real','Khoảng cách đến đường trục chính gần thứ hai tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds100_3','Real','Khoảng cách đến đường trục chính gần thứ ba tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds200_1','Real','Khoảng cách đến đường trục phụ gần nhất tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds200_2','Real','Khoảng cách đến đường trục phụ gần thứ hai tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds200_3','Real','Khoảng cách đến đường trục phụ gần thứ ba tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds300_1','Real','Khoảng cách đến đường làng gần nhất tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds300_2','Real','Khoảng cách đến đường làng gần thứ hai tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds300_2','Real','Khoảng cách đến đường làng gần thứ ba tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds400_1','Real','Khoảng cách đến đường khác gần nhất tính từ thửa đất.',true,true,false);
INSERT INTO preparation.tech_parameter(name, type, description, is_active, is_mandatory, is_virtual) VALUES ('ds400_2','Real','Khoảng cách đến đường khác gần thứ hai tính từ thửa đất.',true,true,false);


-- Categoty: Generic Valuation Land
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,40);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,41);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,42);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,43);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,44);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,45);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,46);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,47);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,48);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,49);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,50);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,51);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,52);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,53);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,54);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,55);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,56);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,57);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,58);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,59);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,60);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,61);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,62);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,63);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,64);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,65);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,66);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,67);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,68);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,69);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,70);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,71);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,72);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,73);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,74);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,75);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,76);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,77);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,78);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,79);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,80);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,81);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,82);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,83);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,84);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,85);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,86);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,87);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,88);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,89);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,90);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,91);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,92);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,93);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,94);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,95);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,96);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,97);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,98);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,99);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,100);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,101);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,102);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,103);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,104);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,105);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,106);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,107);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,108);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,109);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,110);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,111);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,112);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,113);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,114);
INSERT INTO preparation.types_parameters_links(type_id, parameter_id) VALUES (9,115);


-- Table: preparation.parameter_setting
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'Min value','0');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'Max value','6.28319'); -- 360 degree
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'Unit','Radian');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'X Axis','East');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'Y Axis','North');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'Positive Sign','Counter-clockwise');
INSERT INTO preparation.parameter_setting(id, key, value) VALUES (82,'Negative Sign','Clockwise');
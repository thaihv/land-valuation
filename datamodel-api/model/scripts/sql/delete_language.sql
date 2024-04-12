
CREATE OR REPLACE FUNCTION public.get_translation2(mixed_value character varying, language_code character varying)
  RETURNS character varying AS
$BODY$
DECLARE
  delimiter_word varchar;
  language_index integer;
  result varchar;
BEGIN
  if mixed_value is null then
    return mixed_value;
  end if;
  delimiter_word = '::::';
  language_index = (select lng.row_number from (select row_number() over(order by item_order asc) as row_number, code from system.language) lng where lower(lng.code)=lower(language_code));
  result = split_part(mixed_value, delimiter_word, language_index);
  if result is null then
      result = '';
  end if;
  return result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
DO $$
declare
  rec record;
  lang character varying(10);
  sql character varying(2000);
  sql_tmp character varying(2000);
  sql_tmp2 character varying(2000);
begin
  lang = 'sq-AL';
  sql = '';
  for rec in select code from system.language order by item_order loop
    if lang != rec.code then
      if sql != '' then
        sql = sql || ' || ''::::'' || ';
      end if;
      sql = sql || 'get_translation2(%1$s, ''' || rec.code || ''')';
    end if;
  end loop;

  -- update tables
  sql_tmp = format(sql, 'display_value');
  sql_tmp2 = format(sql, 'description');
  
  -- SOLA SL
  if EXISTS (SELECT 1 FROM   pg_catalog.pg_class c JOIN   pg_catalog.pg_namespace n ON n.oid = c.relnamespace 
     WHERE  n.nspname = 'application' AND c.relname = 'checklist_group' AND c.relkind = 'r') then
       EXECUTE 'UPDATE administrative.valuation_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.authority SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.checklist_group SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.checklist_item SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.negotiate_status SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.negotiate_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.notify_relationship_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.objection_status SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.public_display_status SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE application.public_display_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
       EXECUTE 'UPDATE cadastre.state_land_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  end if;

  -- SOLA OT
  if EXISTS (SELECT 1 FROM   pg_catalog.pg_class c JOIN   pg_catalog.pg_namespace n ON n.oid = c.relnamespace 
     WHERE  n.nspname = 'opentenure' AND c.relname = 'claim_status' AND c.relkind = 'r') then
    EXECUTE 'UPDATE opentenure.claim_status SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
    EXECUTE 'UPDATE opentenure.field_constraint_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
    EXECUTE 'UPDATE opentenure.field_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
    EXECUTE 'UPDATE opentenure.field_value_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2; 
    EXECUTE 'UPDATE opentenure.rejection_reason SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2; 
  end if;
  
  EXECUTE 'UPDATE administrative.rrr_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.application_action_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.application_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.request_category_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.request_display_group SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.request_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.service_action_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.service_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE application.type_action SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.area_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.building_unit_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.cadastre_object_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.dimension_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.hierarchy_level SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.land_use_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.level_content_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.register_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.structure_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.surface_relation_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.utility_network_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE cadastre.utility_network_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE party.communication_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE party.gender_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE party.group_party_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE party.id_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE party.party_role_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE party.party_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE source.administrative_source_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE source.availability_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE source.presentation_form_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE source.spatial_source_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.approle SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.br_severity_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.br_technical_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.br_validation_target_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.config_map_layer_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.config_panel_launcher SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE system.panel_launcher_group SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE transaction.reg_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  EXECUTE 'UPDATE transaction.transaction_status_type SET display_value = ' || sql_tmp || ', description = ' || sql_tmp2;
  
  
  -- finally remove language
  delete from system.language where code = lang;
end;
$$;

DROP FUNCTION public.get_translation2(character varying, character varying);

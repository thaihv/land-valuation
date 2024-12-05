COPY (
    SELECT 
        c.table_schema,
        c.table_name,
        c.column_name,
        CASE 
            WHEN c.data_type IN ('character varying', 'character') THEN c.data_type || '(' || c.character_maximum_length || ')'
            WHEN c.data_type IN ('numeric', 'decimal') THEN c.data_type || '(' || c.numeric_precision || ',' || c.numeric_scale || ')'
            WHEN c.data_type LIKE 'timestamp%' THEN c.data_type || '(' || c.datetime_precision || ')'
            ELSE c.data_type
        END AS data_type,
        c.column_default,
        CASE WHEN pk.column_name IS NOT NULL THEN 'YES' ELSE 'NO' END AS is_primary_key,
		c.is_nullable,
        CASE WHEN fk.column_name IS NOT NULL THEN 'YES' ELSE 'NO' END AS is_foreign_key,
        pgd.description AS column_comment
    FROM 
        information_schema.columns c
    LEFT JOIN (
        SELECT kcu.table_schema, kcu.table_name, kcu.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu 
          ON tc.constraint_name = kcu.constraint_name
         AND tc.table_schema = kcu.table_schema
        WHERE tc.constraint_type = 'PRIMARY KEY'
    ) pk
    ON c.table_schema = pk.table_schema 
   AND c.table_name = pk.table_name 
   AND c.column_name = pk.column_name
    LEFT JOIN (
        SELECT kcu.table_schema, kcu.table_name, kcu.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu 
          ON tc.constraint_name = kcu.constraint_name
         AND tc.table_schema = kcu.table_schema
        WHERE tc.constraint_type = 'FOREIGN KEY'
    ) fk
    ON c.table_schema = fk.table_schema 
   AND c.table_name = fk.table_name 
   AND c.column_name = fk.column_name
    LEFT JOIN pg_catalog.pg_statio_all_tables st
    ON c.table_schema = st.schemaname AND c.table_name = st.relname
    LEFT JOIN pg_catalog.pg_description pgd 
    ON st.relid = pgd.objoid AND c.ordinal_position = pgd.objsubid
    WHERE 
        c.table_schema IN ('regression', 'apikey')
    ORDER BY 
        c.table_schema, c.table_name, c.ordinal_position
) TO 'D:\LaoLIS\schema.csv' WITH CSV HEADER;


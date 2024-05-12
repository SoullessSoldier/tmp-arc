--TRUNCATE ALL SCHEMA
CREATE OR REPLACE FUNCTION truncate_tables_in_schema(p_schema varchar) RETURNS void AS
$$
DECLARE
    table_name varchar;
BEGIN
    FOR table_name IN (
        SELECT ist.table_name 
        FROM information_schema.tables as ist
        WHERE table_schema = p_schema
    ) 
    LOOP
        EXECUTE 'TRUNCATE TABLE ' || p_schema || '.' || table_name || ' CASCADE';
    END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT truncate_tables_in_schema('content');

SELECT table_name FROM information_schema.tables WHERE table_schema = 'content'
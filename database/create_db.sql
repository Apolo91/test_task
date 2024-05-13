-- create trigger test_1

SET TIME ZONE 'Europe/Moscow';

CREATE TABLE IF NOT EXISTS test_table (
    id SERIAL PRIMARY KEY,
    data VARCHAR (10),
    date TIMESTAMPTZ
);

CREATE OR REPLACE FUNCTION clean_table() RETURNS TRIGGER AS $clean_table$
    declare
    count_row integer;
    BEGIN
        select count(*) 
        into count_row
        from test_table;

        IF count_row > 30 THEN
            DELETE FROM test_table;
            ALTER SEQUENCE test_table_id_seq RESTART WITH 1;
            -- truncate test_table RESTART IDENTITY;
        END IF;
        RETURN NULL;
    END;
$clean_table$ LANGUAGE plpgsql;

CREATE TRIGGER clean_table AFTER INSERT OR UPDATE ON test_table EXECUTE FUNCTION clean_table();

-- Create schema test_2

CREATE TABLE IF NOT EXISTS servers (
    srv_id INT PRIMARY KEY,
    srv_name VARCHAR (30)
);

































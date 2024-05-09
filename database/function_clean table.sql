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

INSERT INTO test_table (data, date)
VALUES('asdasdasd',NOW());

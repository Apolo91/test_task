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

CREATE TABLE IF NOT EXISTS server_hdd (
    hdd_id INT PRIMARY KEY,
    srv_id INT, 
    hdd_name VARCHAR (50),
    hdd_capacity INT,
    CONSTRAINT fk_server
      FOREIGN KEY(srv_id) 
        REFERENCES servers(srv_id)
);

CREATE TABLE IF NOT EXISTS hdd_monitoring (
    hdd_id INT,
    used_space INT, 
    formatted_space INT, 
    monitoring_date  TIMESTAMPTZ,
    CONSTRAINT fk_server_hdd
      FOREIGN KEY(hdd_id) 
        REFERENCES server_hdd(hdd_id)
);








INSERT INTO servers (srv_id, srv_name) VALUES
(1,'vlg-zmon-prx01'),
(2,'vlg-zmon-prx02'),
(3,'kvk-zmon-prx01'),
(4,'kvk-zmon-prx02'),
(5,'dv-zmon-prx01'),
(6,'dv-zmon-prx02'),
(7,'msk-zmon-prx01'),
(8,'msk-zmon-prx02'),
(9,'sib-zmon-prx01')
(10,'sib-zmon-prx02');





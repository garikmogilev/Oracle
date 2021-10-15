-- LAB 8 work in SQL PLUS

-- TASK 1 sqlnet.ora tnsnames.ora
-- sqlnet.ora:      /u01/app/oracle/product/19.3.0/dbhome_1/network/admin/sqlnet.ora
-- tnsnames.ora:    /u01/app/oracle/product/19.3.0/dbhome_1/network/admin/tnsnames.ora

-- TASK 2
-- connect system/9I50ybkubu@(DESCRIPTION=(ADDRESS=(PROTOCOL = TCP)(HOST =192.168.13.128)(PORT = 1521))(CONNECT_DATA=(SERVICE_NAME = orcl)))
-- select * from V$SPPARAMETER;
-- select * from V$SPPARAMETER where VALUE IS NOT NULL;

-- TASK 3 tablespace in sql plus USER_TABLESPACES
-- select TABLESPACE_NAME from user_tablespaces;                     // list by tablespace
-- select file_name, tablespace_name from  dba_data_files;           // files by tablespace

-- TASK 4 regedit

-- TASK 5 create user and pdb if don't have, create a string for connection
-- connect SIA_PDB_CS/9I50ybkubu@(DESCRIPTION=(ADDRESS=(PROTOCOL = TCP)(HOST =192.168.13.128)(PORT = 1521))(CONNECT_DATA=(SERVICE_NAME = SIA_PDB)))

-- TASK 6
-- connect to PDB, using a connection string

-- TASK 7
-- create table person (ID NUMBER  primary key,name varchar2(20));
-- insert  into person(ID, name) VALUES (1,'person1');
-- insert  into person(ID, name) VALUES (2,'person2');
-- insert  into person(ID, name) VALUES (3,'person3');

-- select * from person;

-- TASK 8 timing
-- set timing on;
-- select * from person;
-- Elapsed: 00:00:00.99
-- set timing off

-- TASK 9
-- describe person;

-- TASK 10
select * from user_segments;

-- TASK 11
create view view_for_lab8 as
    select count(*)  segments_count, sum(extents) extents_count,sum(blocks) bloks_count, sum(bytes)/1024 memory_size
        from user_segments;

select  * from view_for_lab8;

drop view view_for_lab8;
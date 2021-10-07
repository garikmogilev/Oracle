-- LAB 5

-- TASK 1 total memory size SGA
select sum(VALUE) as TOTALSIZESGA, 'BYTES' as UNITS from V$SGA;
select * from V$SGA;

-- TASK 2 sizes of pools SGA
select * from V_$SGASTAT;

-- TASK 3 sizes of granule
select COMPONENT, CURRENT_SIZE, MAX_SIZE, GRANULE_SIZE
    from V_$SGA_DYNAMIC_COMPONENTS
    where CURRENT_SIZE > 0;

-- TASK 4 free size SGA
select (CURRENT_SIZE/1048576), 'MB' as UNITS from V_$SGA_DYNAMIC_FREE_MEMORY;

-- TASK 5 pool size КЕЕP, DEFAULT and RECYCLE buffer cache
select COMPONENT, CURRENT_SIZE, MAX_SIZE, GRANULE_SIZE
    from V_$SGA_DYNAMIC_COMPONENTS where COMPONENT
in ('DEFAULT buffer cache', 'KEEP buffer cache', 'RECYCLE buffer cache');

-- TASK 6 create table to KEEP
-- select file_name, tablespace_name, status from  dba_data_files;

create table PERSONS (
    ID int,
    NAME char(20)
) storage (buffer_pool keep) tablespace USERS;
-- drop table persons;
insert into PERSONS values (1, 'person 1');
insert into PERSONS values (2, 'person 2');
insert into PERSONS values (3, 'person 3');

select SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL from SYS.USER_SEGMENTS where SEGMENT_NAME = 'PERSONS';

-- TASK 7 create table to cache DEFAULT
create table PERSONS2 (
    ID int,
    NAME char(20)
) cache storage (buffer_pool default ) tablespace USERS;
-- drop table PERSONS2;
insert into PERSONS2 values (1, 'person 1');
insert into PERSONS2 values (2, 'person 2');
insert into PERSONS2 values (3, 'person 3');
 -- select * from PERSONS2;
select SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BUFFER_POOL from SYS.USER_SEGMENTS where SEGMENT_NAME = 'PERSONS2';

-- TASK 8 size of buffer log (run sqlplus)
-- show parameter log_buffer;

-- TASK 9 max size of 10 components
select * from V_$SGA_DYNAMIC_COMPONENTS order by CURRENT_SIZE desc
    fetch first 10 rows only;

-- TASK 10 free memory in large pool
select COMPONENT, ((MAX_SIZE - CURRENT_SIZE)/1048576), 'MB' as UNITS from V_$SGA_DYNAMIC_COMPONENTS
    where COMPONENT = 'large pool';

-- TASK 11 sessions
select USERNAME, OSUSER, MACHINE, PROGRAM from V$SESSION where USERNAME is not null ;

-- TASK 12 mode for sessions (shared, dedicated)
select USERNAME, SERVER from V$SESSION where USERNAME is not null;
-- TASK 1 Create TABLE SPACE
create tablespace TS_SIA
    datafile 'C:\APP\ORACLE\ORADATA\ORCL\TS_SIA.DBF'
    size 7M
    autoextend on next 5M
    maxsize 20M;

-- TASK 2 Create TABLE TEMPORARY
create temporary tablespace TS_SIA_TEMP
    tempfile 'C:\APP\ORACLE\ORADATA\ORCL\TS_SIA_TEMP.DBF'
    size 5M
    autoextend on next 5M
    maxsize 20M;

-- TASK 3 Statements list files and and tables views
select TABLESPACE_NAME, STATUS, CONTENTS from dba_tablespaces;                -- list tables paces
select FILE_NAME, TABLESPACE_NAME from DBA_DATA_FILES;      -- list database files
select FILE_NAME, TABLESPACE_NAME from DBA_TEMP_FILES;      -- list database temp files

-- TASK 4 create role
alter session set "_ORACLE_SCRIPT"=true;

create role RL_SIACORE;

grant   create session,
        create table, drop any table,           -- table
        create view, drop any view,             -- view
        create procedure, drop any procedure    -- procedure
to RL_SIACORE;

-- TASK 5 select ROLE to dictionary
select * from dba_roles ;                                   -- all roles
select * from dba_roles where role = 'RL_SIACORE';          -- also RL_SIACORE
select * from dba_sys_privs where grantee = 'RL_SIACORE';   -- privilege RL_SIACORE

-- TASK 6 create security profile
alter session set "_ORACLE_SCRIPT"=true;
create profile PF_SIACORE limit
    password_life_time unlimited
    sessions_per_user 3
    failed_login_attempts 30
    password_lock_time 1
    password_reuse_time 10
    connect_time 180
    idle_time 30;

-- Task 7 select all list profiles and parameters for default and PF_XXXCORE
select * from DBA_PROFILES;
select * from DBA_PROFILES  where PROFILE='PF_SIACORE';
select * from DBA_PROFILES  where PROFILE='DEFAULT';

-- Task 8 create new user XXXCORE
alter session set "_ORACLE_SCRIPT"=true;

create user SIACORE identified by c5yylugbmb
    default tablespace TS_SIA quota unlimited on TS_SIA
    temporary tablespace TS_SIA_TEMP
    profile PF_SIACORE
    account unlock
    password expire;

grant RL_SIACORE to SIACORE;
-- drop user SIACORE cascade

-- Task 10 RUN using new user
/*create table student (
    name varchar2(20),
    course number(1),
    faculty varchar2(10)
);

drop table student;

create view view_students (name, faculty) as select * from student;
select * from view_students;*/

-- Task 11 tablespace XXX_QDATA
-- create new table space XXX_QDATA
create tablespace SIA_QDATA
    datafile 'C:\APP\ORACLE\ORADATA\ORCL\SIA_QDATA.DBF'
    size 10M
    autoextend on next 5M
    maxsize 20M
    offline;

alter tablespace SIA_QDATA online;
--drop tablespace SIA_QDATA;

-- create new user XXX
alter session set "_ORACLE_SCRIPT"=true;

create user SIA identified by c5yylugbmb
    default tablespace SIA_QDATA quota 2M on SIA_QDATA
    temporary tablespace TS_SIA_TEMP
    profile PF_SIACORE
    account unlock
    password expire;

grant RL_SIACORE to SIA;

-- create tablespace XXX_T1
create tablespace SIA_T1
    datafile 'C:\APP\ORACLE\ORADATA\ORCL\SIA_T1.DBF'
    size 10M
    autoextend on next 5M
    maxsize 20M
    offline;

alter tablespace SIA_T1 online;
alter user SIA quota 5M on SIA_T1;

-- SELECT CDB FROM V_$DATABASE
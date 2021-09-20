-- Lab 4

-- Task 1 list pdb and states
select pdb_id, pdb_name, status  from SYS.DBA_PDBS;

-- Task 2 instance list
select * from V$INSTANCE;

-- Task 3 list of components, their version and status
select comp_name, version, status from SYS.DBA_REGISTRY;

-- Task 4 create PDB
-- PDB: SIA_PDB
-- PASS: 9I50ybkubu

-- TASK 5 check SIA_PDB

-- TASK 6
-- ACTION create role
alter session set "_ORACLE_SCRIPT"=true;

create role U1_RL_SIACORE;

grant   create session,
        create table, drop any table,           -- table
        create view, drop any view,             -- view
        create procedure, drop any procedure    -- procedure
to U1_RL_SIACORE;

-- ACTION select ROLE to dictionary
select * from dba_roles ;                                   -- all roles
select * from dba_roles where role = 'U1_RL_SIACORE';          -- also RL_SIACORE
select * from dba_sys_privs where grantee = 'U1_RL_SIACORE';   -- privilege RL_SIACORE

-- TASK 6 create security profile
-- ACTION Create table spaces
create tablespace TS_SIA_PDB
    datafile 'C:\APP\PRACLE\ORADATA\orcl\SIA_PDB\TS_SIA.DBF'
    size 7M
    autoextend on next 5M
    maxsize 20M;

-- ACTION Create TABLE TEMPORARY
create temporary tablespace TS_SIA_TEMP_PDB
    tempfile 'C:\APP\PRACLE\ORADATA\orcl\SIA_PDB\TS_SIA_TEMP.DBF'
    size 5M
    autoextend on next 5M
    maxsize 20M;


-- ACTION create role
alter session set "_ORACLE_SCRIPT"=true;

create role U1_RL_SIACORE;

grant   create session,
        create table, drop any table,           -- table
        create view, drop any view,             -- view
        create procedure, drop any procedure    -- procedure
to U1_RL_SIACORE;

-- ACTION create profile
alter session set "_ORACLE_SCRIPT"=true;
create profile U1_PF_SIACORE limit
    password_life_time unlimited
    sessions_per_user 3
    failed_login_attempts 30
    password_lock_time 1
    password_reuse_time 10
    connect_time 180
    idle_time 30;

-- ACTION create new user XXXCORE
alter session set "_ORACLE_SCRIPT"=true;

create user U1_SIA_PDB identified by c5yylugbmb
    default tablespace TS_SIA_PDB quota unlimited on TS_SIA_PDB
    temporary tablespace TS_SIA_TEMP_PDB
    profile U1_PF_SIACORE
    account unlock
    password expire;

grant U1_RL_SIACORE to U1_SIA_PDB ;

-- TASK 8
select * from USER_TABLESPACES;

select * from USER_FILE_GROUP_TABLESPACES;

select * from ALL_TAB_PRIVS;

select * from ALL_USERS;

select * from USER_APPLICATION_ROLES;

-- TASK 9
create user c##cdb_admin identified by pass12345;
alter database open;
-- TASK

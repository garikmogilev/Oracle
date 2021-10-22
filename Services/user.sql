-- create role
alter session set "_ORACLE_SCRIPT"=true;

create role RL_SKVORTSOFF;

grant   create session,
        create table, drop any table,           -- table
        create view, drop any view,             -- view
        create procedure, drop any procedure    -- procedure
to RL_SKVORTSOFF;

-- create profile

create profile PF_SKVORTSOFF limit
    password_life_time unlimited
    sessions_per_user 3
    failed_login_attempts 30
    password_lock_time 1
    password_reuse_time 10
    connect_time 180
    idle_time 30;

--  create new user

create user SKVORTSOFF identified by pass12345
    default tablespace TS_SKVORTSOFF quota unlimited on TS_SKVORTSOFF
    profile PF_SKVORTSOFF
    account unlock
    password expire;

grant all privileges to SKVORTSOFF;

grant RL_SKVORTSOFF to SKVORTSOFF;


-- revoke all privileges from U1_SIA_PDB;

-- drop user SKVORTSOFF;
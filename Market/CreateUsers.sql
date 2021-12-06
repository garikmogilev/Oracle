alter session set "_ORACLE_SCRIPT"=true;

-- ----------------------------------------------
-- create PDB using DBCA
-- ----------------------------------------------

-- ----------------------------------------------
-- create roles for PDB Market
-- ----------------------------------------------

create role ROLE_MARKET_CLIENT;
create role ROLE_MARKET_ADMIN;

-- ----------------------------------------------
-- create roles for PDB Market
-- ----------------------------------------------

grant create session,
    execute any procedure
to ROLE_MARKET_CLIENT;

grant create session,
    create any table, drop any table,
    create any index, drop any index,
    create any procedure, drop any procedure,
    create sequence, drop any sequence,
    create view, drop any view,
    create trigger, drop any trigger,
    execute any procedure
to ROLE_MARKET_ADMIN;


-- ----------------------------------------------
-- create profile for PDB Market
-- ----------------------------------------------
alter session set "_ORACLE_SCRIPT"=true;
create profile PF_MARKET limit
    password_life_time unlimited
    sessions_per_user 3
    failed_login_attempts 30
    password_lock_time 1
    password_reuse_time 10
    connect_time 180
    idle_time 30;

create user MARKET_CLIENT identified by c5yylugbmb
    profile PF_MARKET
    account unlock;

create user MARKET_ADMIN identified by c5yylugbmb
    profile PF_MARKET
    account unlock;
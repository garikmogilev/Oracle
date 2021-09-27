-- LAB 5
-- TASK 1 all list tablespace temporary and permanents
select file_name, tablespace_name, status from  dba_data_files
union
select file_name, tablespace_name, status from dba_temp_files;

-- TASK 2 create tablespace, user, table
create tablespace SIA_QDATA
dataFile 'C:\APP\PRACLE\ORADATA\ORCL\SIA_QDATA.dbf'
size 10 M
autoExtend on next 1M
MAXSIZE 30 M
offline;

--drop tablespace SIA_QDATA;

alter tablespace SIA_QDATA online;

-- profile
alter session set "_ORACLE_SCRIPT"=true;

create profile PFQ_SIACORE limit
    password_life_time unlimited
    sessions_per_user 3
    failed_login_attempts 30
    password_lock_time 1
    password_reuse_time 10
    connect_time 180
    idle_time 30;

-- role
create role SIA_QROLE;

grant   create session,
        create table, drop any table,           -- table
        create view, drop any view,             -- view
        create procedure, drop any procedure    -- procedure
to SIA_QROLE;

-- user

create user SIA identified by pass12345
    default tablespace SIA_QDATA quota 2M on SIA_QDATA
    profile PFQ_SIACORE
    account unlock;

-- revoke all privileges from SIA;


grant SIA_QROLE to SIA;

alter session set "_oracle_script"=true;
drop user SIA ;

SELECT * FROM USER_SYS_PRIVS;

-- TASK 3 segments of tablespace
select * from dba_segments where TABLESPACE_NAME = 'SIA_QDATA';

-- TASK 4 >>>>>> SIA.sql
select * from dba_segments where TABLESPACE_NAME = 'SIA_QDATA';

-- TASK 5 >>>>>> SIA.SQL
-- TASK 6 >>>>>> SIA.SQL

-- TASK 7 segments of tablespace
select * from dba_segments where TABLESPACE_NAME = 'SIA_QDATA';

-- TASK 8 drop tablespace
drop tablespace SIA_QDATA including contents and datafiles;

-- TASK 9
select * from v$log;
select * from v$log where STATUS= 'CURRENT';

-- TASK 10
select * from v$logfile;

-- TASK 11 4:20
alter system switch logfile;
select GROUP#, SEQUENCE#, BYTES, MEMBERS, STATUS, FIRST_CHANGE# from v$log;

-- TASK 12 add new group logfile
alter database ADD LOGFILE GROUP 4 'C:\APP\PRACLE\ORADATA\ORCL\RED004.LOG' size 10m blocksize 512;

alter database add logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED0041.LOG' to GROUP 4;
alter database add logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED0042.LOG' to GROUP 4;
alter database add logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED0043.LOG' to GROUP 4;

-- alter database drop Logfile group 4;

select * from v$log;
select * from v$logfile;

alter system switch logfile;
select GROUP#, SEQUENCE#, BYTES, MEMBERS, STATUS, FIRST_CHANGE# from v$log;

-- TASK 13 drop logfiles

alter database drop logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED004.LOG';
alter database drop logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED0041.LOG';
alter database drop logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED0042.LOG';
alter database drop logfile member 'C:\APP\PRACLE\ORADATA\ORCL\RED0043.LOG';
alter database drop Logfile group 4;

-- TASK 14 check status archive log
select * from V_$INSTANCE;
select * from V_$DATABASE;


-- TASK 15 check a last archive
select * from V$ARCHIVED_LOG;

-- TASK 16 run archivelog (SQLPLUS)
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

-- TASK 17
select GROUP#,ARCHIVED, SEQUENCE#, BYTES, MEMBERS, STATUS, FIRST_CHANGE# from v$log;

alter system switch logfile;
select * from V$ARCHIVED_LOG;

-- TASK 18 stop noarchivelog (SQLPLUS)

-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

-- TASK 19 list control-files
SELECT status, name, is_recovery_dest_file FROM V$CONTROLFILE;

-- TASK 20 (SQLPLUS)
-- show parameter control;

-- TASK 21
select * from v$parameter;
select NAME, VALUE, DESCRIPTION from v$parameter;

-- TASK 22 create SPFILE  (product/%version%/dbhome/database)
create PFILE = 'SIA_PFILE.ORA' from SPFILE;

-- TASK 23 passwords
select * from v$pwfile_users;

-- TASK 24 list dir messages and diagnostics (tracers, data, dumps)
select * from v$diag_info;

SELECT * from dba_undo_extents;
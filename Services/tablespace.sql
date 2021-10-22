create tablespace TS_SKVORTSOFF
    datafile '/u01/app/oracle/oradata/ORCL/orclpdb/TS_SKVORTSOFF.DBF'
    size 10M
    autoextend on next 5M
    maxsize 100M;

-- drop tablespace TS_SKVORTSOFF including contents and datafiles;
--alter user SKVORTSOFF default tablespace TS_SKVORTSOFF quota unlimited on TS_SKVORTSOFF;
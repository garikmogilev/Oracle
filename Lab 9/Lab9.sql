-- LAB 9
-- TASK 1 check current user and privileges
SELECT * FROM USER_SYS_PRIVS;
-- grant all privileges to SIA_PDB_CS; -- all privileges to XXX_PDB

-- TASK 2 create SEQUENCE S1
create sequence SIA_PDB_CS.S1
    start with 1000
    increment by 10
    nomaxvalue
    nominvalue
    nocycle
    nocache;

select SIA_PDB_CS.S1.nextval from DUAL;
select SIA_PDB_CS.S1.currval from DUAL;
-- drop sequence S1;

-- TASK 3 create SEQUENCE S2
create sequence SIA_PDB_CS.S2
    start with 10
    increment by 10
    maxvalue 100;

select SIA_PDB_CS.S2.nextval from DUAL;
select SIA_PDB_CS.S2.currval from DUAL;
-- drop sequence S2;

-- TASK 4  ERROR in task list

-- TASK 5 create SEQUENCE S3
create sequence SIA_PDB_CS.S3
    start with 10
    increment by -10
    minvalue -100
    maxvalue 10
    order;

select SIA_PDB_CS.S3.nextval from DUAL;
select SIA_PDB_CS.S3.currval from DUAL;
-- drop sequence S3;

-- TASK 6 create SEQUENCE S2 ERROR maxvalue or minvalue
create sequence SIA_PDB_CS.S4
    start with 1
    increment by 1
    maxvalue 10
    cache 5
    cycle
    noorder;

select SIA_PDB_CS.S4.nextval from DUAL;
select SIA_PDB_CS.S4.currval from DUAL;
-- drop sequence SIA_PDB_CS.S4;

-- TASK 7 select all SEQUENCES the current user
select * from SYS.USER_SEQUENCES;

-- TASK 8 create table T1
create table T1
(
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
) cache storage (buffer_pool keep);

insert into T1 values (S1.nextval, S2.nextval, S3.nextval , S4.nextval);
select * from T1;

-- TASK 9 create cluster ABC
create cluster ABC
(
    X number (10),
    V varchar2(12)
) hashkeys 200;

-- TASK 10 create table A
create table A
(
    XA number (10),
    VA varchar2(12),
    YA number(10)
) cluster ABC(XA, VA) ;

-- TASK 11 create table B
CREATE TABLE B
(
    XB NUMBER (10),
    VB VARCHAR2(12),
    YB NUMBER (20)
)
CLUSTER  ABC (XB,VB);

-- TASK 12 create table C
CREATE TABLE C
(
    XC NUMBER (10),
    VC VARCHAR2(12),
    YC NUMBER (20)
)
CLUSTER  ABC (XC,VC);

-- TASK 13
SELECT * FROM dba_tables WHERE owner='SIA_PDB_CS';  -- SYS or SYSTEM
SELECT * FROM user_objects;                         -- your USER

-- TASK 14 create synonym
create synonym SIA_C for C;

insert into SIA_C values (10, 'ABC', 10);

select * from SIA_C;
-- drop synonym SIA_C;

-- TASK 14 create public synonym
create public synonym SIA_B for B;

insert into SIA_B values (1, 'CBA', 100);

select * from SIA_B;
-- drop synonym SIA_B;

-- TASK 15
CREATE TABLE TABLE_STUDENT
(
    ID number generated always as identity (start with  1 increment by 1),
    FIRSTNAME varchar2(20),
    LASTNAME varchar2(20),
    FACULTY varchar2(12),
    constraint FK_FACULTY FOREIGN KEY (FACULTY) references TABLE_FACULTY(FACULTY),
    constraint PK_ID primary key (ID)
);

--DROP TABLE TABLE_STUDENT;

CREATE TABLE TABLE_FACULTY
(
    ID number generated always as identity (start with  1 increment by 1),
    FACULTY varchar2(12) unique
);
-- drop table TABLE_FACULTY;

insert into TABLE_FACULTY (FACULTY) values('ПОИТ');
insert into TABLE_FACULTY (FACULTY) values('ДЭиВИ');
insert into TABLE_FACULTY (FACULTY) values('ИСИТ');
insert into TABLE_FACULTY (FACULTY) values('ПОиБМС');

insert into TABLE_STUDENT (FIRSTNAME, LASTNAME, FACULTY) values('Igor', 'Skvortsov', 'ПОИТ');
insert into TABLE_STUDENT (FIRSTNAME, LASTNAME, FACULTY) values('Sergo', 'Valco', 'ПОИТ');
insert into TABLE_STUDENT (FIRSTNAME, LASTNAME, FACULTY) values('VASYA', 'Krivtsova', 'ИСИТ');

select * from TABLE_FACULTY;
select * from TABLE_STUDENT;

create or replace force view V1
 as select TF.FIRSTNAME, TF.FACULTY
        from TABLE_FACULTY
        inner join TABLE_STUDENT TF on TF.FACULTY = TABLE_FACULTY.FACULTY;

select * from V1;
-- drop view V1;

-- TASK 16
CREATE MATERIALIZED VIEW MV
BUILD IMMEDIATE
REFRESH COMPLETE NEXT SYSDATE + NUMTODSINTERVAL(2,'MINUTE')
AS SELECT TF.FIRSTNAME, TF.LASTNAME, TF.FACULTY
FROM TABLE_FACULTY  INNER JOIN TABLE_STUDENT TF on TF.FACULTY = TABLE_FACULTY.FACULTY;

select * from MV;

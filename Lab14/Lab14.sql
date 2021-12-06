-- LAB 14
CREATE DATABASE LINK olegDb
    CONNECT TO U_KOA_CORE
    IDENTIFIED BY "Main_123098"
    USING 'olegcdb';

select * from pulpit@olegDb;
insert into pulpit@olegDb values ('ФХИ','Физико-химический ','ЛХФ' );
update pulpit@olegDb set PULPIT_NAME@olegDb = 'Физико-экономисеский', PULPIT@olegDb = 'ФЭ' where PULPIT@olegDb = 'ФХИ';
delete from PULPIT@olegDb where PULPIT@olegDb = 'ФЭ';


-- drop database link olegDb;


CREATE PUBLIC DATABASE LINK public_olegDb
    CONNECT TO U_KOA_CORE
    IDENTIFIED BY "Main_123098"
    USING 'olegcdb';

select * from pulpit@public_olegDb;
insert into pulpit@public_olegDb values ('ФХИ','Физико-химический ','ЛХФ' );
update pulpit@public_olegDb set PULPIT_NAME@public_olegDb = 'Физико-экономисеский', PULPIT@public_olegDb = 'ФЭ'
    where PULPIT@public_olegDb = 'ФХИ';
delete from PULPIT@public_olegDb where PULPIT@public_olegDb = 'ФЭ';


-- drop public database link public_olegDb;
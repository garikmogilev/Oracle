-- create SIA_temp (task 9)
create table SIA_temp( ID number(3) not null, name VARCHAR2(20) not null, CONSTRAINT  ID_PK primary key (ID) );

-- insert data to DataBase (task 11)
insert into SIA_temp(ID, name)
values(1, 'Henry');

insert into SIA_temp(ID, name)
values(2, 'John');

insert into SIA_temp(ID, name)
values(3, 'Scott');

commit;
-- test
select * from SIA_temp;

-- update SIA_temp (task 12)
update SIA_temp set ID = 10, name = 'Evan' where ID = 1;
update SIA_temp set ID = 11, name = 'Connor' where ID = 2;
commit;
--test
select * from SIA_temp;

-- task 13
select * from SIA_temp;
select * from SIA_temp where name = 'Evan';
select max(ID) from SIA_temp;

-- delete (task 14)
delete from SIA_temp where ID = 10;
commit;


-- create SIA_temp (task 15)
create table SIA_temp2( ID_t number(2), name_t VARCHAR2(20),
constraint connection foreign key (ID_t) REFERENCES SIA_temp(ID)
);

insert into SIA_temp2(ID_t, name_t)
values(1, 'Rain');

insert into SIA_temp2(ID_t, name_t)
values(3, 'Scott');

select * from SIA_temp2;
-- inner - left - right (task 16)
select * from SIA_TEMP t inner join SIA_TEMP2 t1 on t.ID = t1.ID_t;

select * from SIA_TEMP t left outer join SIA_TEMP2 t1 on t.ID = t1.ID_t;

select * from SIA_TEMP t right outer join SIA_TEMP2 t1 on t.ID = t1.ID_t;

drop table SIA_temp;
drop table SIA_temp2;
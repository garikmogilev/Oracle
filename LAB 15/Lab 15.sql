-- LAB 15

-- TASK 1 create table then has few fields and primary key
create table student(
    id int primary key,
    name varchar2(50),
    lastname varchar2(50)
    );

-- TASK 2 insert rows in the table
insert into student(id,name, lastname) values (1,'Иван', 'Северин');
insert into student(id,name, lastname) values (2,'Кирилл', 'Кабайло');
insert into student(id,name, lastname) values (3,'Дмитрий', 'Моргунов');
insert into student(id,name, lastname) values (4,'Аннф', 'Кордюкова');
insert into student(id,name, lastname) values (5,'Иван', 'Гурин');
insert into student(id,name, lastname) values (6,'Андрей', 'Акунович');
insert into student(id,name, lastname) values (7,'Анна', 'Колесникова');
insert into student(id,name, lastname) values (8,'Денис', 'Цуранов');
insert into student(id,name, lastname) values (9,'Виктор', 'Барановский');
insert into student(id,name, lastname) values (10,'Валера', 'Макелин');
commit;

-- TASK 3 create trigger before (insert, delete, update)
create or replace trigger student_before_dml
    before insert or update or delete on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('DML OPERATIONS ON THE TABLE STUDENT (BEFORE)');
end;

---------- TEST --------------
insert into student(id,name, lastname) values (15,'Денис', 'Макелин');
update student set name = 'Василий' where id = 15;
delete student WHERE id = 15;

select * from student;

drop trigger student_before_dml;

-- TASK 5
create or replace trigger student_before_each_rows_student
    before insert or update or delete
        on student for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('DML OPERATIONS FOR EACH ROWS ON THE TABLE STUDENT (BEFORE)');
end;

---------- TEST UPDATING EACH ROWS --------------
update student set name = 'Василий' where name = 'Денис';

select * from student;
rollback;

drop trigger student_before_each_rows_student;

-- TASK 6 trigger predicate
create or replace trigger student_before_predicate
    before insert or update or delete on student
begin
  if INSERTING then
    SYS.DBMS_OUTPUT.PUT_LINE('TRIGGER PREDICATE INSERTING ON THE TABLE STUDENT (BEFORE)');
  elsif UPDATING then
    SYS.DBMS_OUTPUT.PUT_LINE('TRIGGER PREDICATE UPDATING ON THE TABLE STUDENT (BEFORE)');
  elsif DELETING then
    SYS.DBMS_OUTPUT.PUT_LINE('TRIGGER PREDICATE DELETING ON THE TABLE STUDENT (BEFORE)');
  end if;
end;

---------- TEST --------------
insert into student(id,name, lastname) values (15,'Денис', 'Макелин');
update student set name = 'Василий' where id = 15;
delete student WHERE id = 15;

select * from student;

drop trigger student_before_predicate;

-- TASK 7 create triggers DML
create or replace trigger student_after_insert
    after insert on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('INSERT ON THE TABLE STUDENT (AFTER)');
end;

create or replace trigger student_after_update
    after update on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('UPDATE ON THE TABLE STUDENT (AFTER)');
end;

create or replace trigger student_after_delete
    after delete on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('DELETE ON THE TABLE STUDENT (AFTER)');
end;

---------- TEST --------------
insert into student(id,name, lastname) values (15,'Денис', 'Макелин');
update student set name = 'Василий' where id = 15;
delete student WHERE id = 15;

select * from student;

drop trigger student_after_insert;
drop trigger student_after_update;
drop trigger student_after_delete;

-- TASK 8 create triggers dml each rows
create or replace trigger student_after_insert_each_row
    after insert on student
        for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('INSERT ON THE TABLE STUDENT (AFTER EACH ROW)');
end;

create or replace trigger student_after_update_each_row
    after update on student
        for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('UPDATE ON THE TABLE STUDENT (AFTER EACH ROW)');
end;

create or replace trigger student_after_delete_each_row
    after delete on student
        for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('DELETE ON THE TABLE STUDENT (AFTER EACH ROW)');
end;

---------- TEST --------------
insert into student(id,name, lastname) values (15,'Денис', 'Макелин');
insert into student(id,name, lastname) values (16,'Денис', 'Макелин');
insert into student(id,name, lastname) values (17,'Денис', 'Макелин');

update student set name = 'Васютин' where lastname = 'Макелин';
delete student WHERE id >= 15;

select * from student;

drop trigger student_after_insert_each_row;
drop trigger student_after_update_each_row;
drop trigger student_after_delete_each_row;


-- TASK 9 create TABLE AUDIT
CREATE TABLE AUDIT_CUSTOM
(
    OperationDate date,
    OperationType varchar2(10 char),
    TriggerName varchar(50 char),
    DATA varchar2(200 char)
);



-- TASK 10 create trigger to log DML into inserting
create or replace trigger student_logger_predicate
    after insert or update or delete on student
        for each row
begin
    if inserting then
            insert into AUDIT_CUSTOM (OperationDate, OperationType, TriggerName, DATA)
                values (
                        sysdate,
                        'insert',
                        'student_logger_predicate',
                        'Old name: ' || :old.name || 'New name: ' || :new.name ||
                        'Old lastname: ' || :old.lastname || 'New lastname: ' || :new.lastname);
    elsif updating then
            insert into AUDIT_CUSTOM (OperationDate, OperationType, TriggerName, DATA)
                values (
                        sysdate,
                        'update',
                        'student_logger_predicate',
                        'Old name: ' || :old.name || 'New name: ' || :new.name ||
                        'Old lastname: ' || :old.lastname || 'New lastname: ' || :new.lastname);
    elsif deleting
        then
            insert into AUDIT_CUSTOM (OperationDate, OperationType, TriggerName, DATA)
                values (
                        sysdate,
                        'delete',
                        'student_logger_predicate',
                        'Old name: ' || :old.name || 'New name: ' || :new.name ||
                        'Old lastname: ' || :old.lastname || 'New lastname: ' || :new.lastname);
    end if;
end;

-- drop trigger student_logger_predicate;

insert into student values (21, 'Валентина', 'Маргунова');
update student set name = 'Екатерина' where name = 'Валентина';
delete from student where lastname = 'Маргунова';

select * from AUDIT_CUSTOM;


-- TASK 11
insert into student values (1, '', '');
select * from user_triggers;

-- TASK 12
drop table student;

create or replace trigger ban_drop_student
  before drop on database
begin
    if(ORA_DICT_OBJ_NAME  = 'STUDENT') THEN
    SYS.DBMS_OUTPUT.PUT_LINE('delete function: banned');
    RAISE_APPLICATION_ERROR(-20000,'Cant delete this table');
    END IF;
END;

-- TASK 13
drop table AUDIT_CUSTOM;
select * from user_triggers;

-- TASK 14
create or replace trigger trnewtab
instead of insert or update or delete on vnewtab
for each row
begin
  if inserting then dbms_output.put_line('insert:'||:new.x);
  else if updating then dbms_output.put_line('update:'||rtrim(:old.y) ||'->'||:new.y);
  else if deleting then dbms_output.put_line('delete:'||:old.x);
  end if;
end if;
end;
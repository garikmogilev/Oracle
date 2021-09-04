-- Task 11

create table student (
    name varchar2(20),
    course number(1),
    faculty varchar2(10)
)tablespace SIA_T1;


insert  into student(name, course, faculty) VALUES ('Mike', 2 , 'INJS');
insert  into student(name, course, faculty) VALUES ('Nick', 1 , 'HDJ');
insert  into student(name, course, faculty) VALUES ('Connor', 3 , 'TERT');
commit;

-- drop table student;

create view view_students (name, course, faculty) as select * from student;
select * from view_students;

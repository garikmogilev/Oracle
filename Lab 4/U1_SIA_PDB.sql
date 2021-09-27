-- Task 7
SELECT * FROM USER_SYS_PRIVS;

create table student (
    name varchar2(20),
    course number(1),
    faculty varchar2(10)
);

insert  into student(name, course, faculty) VALUES ('Mike', 2 , 'INJS');
insert  into student(name, course, faculty) VALUES ('Mike', 2 , 'INJS');
insert  into student(name, course, faculty) VALUES ('Mike', 2 , 'INJS');

--drop table student;
select * from student;
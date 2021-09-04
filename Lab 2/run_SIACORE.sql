-- Task 9
create table student (
    name varchar2(20),
    course number(1),
    faculty varchar2(10)
);

insert  into student(name, course, faculty) VALUES ('Mike', 2 , 'INJS');

drop table student;

create view view_students (name, course, faculty) as select * from student;
select * from view_students;

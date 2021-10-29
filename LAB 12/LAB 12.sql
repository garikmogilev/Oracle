-- LAB 12 DATABASE

-- TASK 1 add rows: salary and birthday
alter table SKVORTSOFF.TEACHER add BIRTHDAY date;
alter table SKVORTSOFF.TEACHER add SALARY number(6,2);

-- into data
DECLARE
    cursor c_teacher is select TEACHER, BIRTHDAY, SALARY from SKVORTSOFF.TEACHER;
    l_data SKVORTSOFF.TEACHER.BIRTHDAY % type;
    l_salary SKVORTSOFF.TEACHER.SALARY % type;
    BEGIN
      SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);


    for row_teacher in c_teacher
    loop
      l_data := TO_DATE(
              TRUNC(
                   DBMS_RANDOM.VALUE(TO_CHAR(DATE '1960-01-01','J')
                                    ,TO_CHAR(DATE '2000-12-31','J')
                                    )
                    ),'J'
               );
          SYS.DBMS_OUTPUT.PUT_LINE(l_data);

      l_salary := Round(DBMS_RANDOM.Value(20000, 200000)) / 100;
         SYS.DBMS_OUTPUT.PUT_LINE(l_salary);

    update TEACHER
        set SKVORTSOFF.TEACHER.BIRTHDAY = l_data, SKVORTSOFF.TEACHER.SALARY = l_salary
            where SKVORTSOFF.TEACHER.TEACHER = row_teacher.TEACHER;

      end loop;
END;

-- check
select * from SKVORTSOFF.TEACHER;

-- TASK 2 LASTNAME F. P.
DECLARE
    LastName   SKVORTSOFF.TEACHER.TEACHER_NAME % type;
    FirstName  SKVORTSOFF.TEACHER.TEACHER_NAME % type;
    Patronymic SKVORTSOFF.TEACHER.TEACHER_NAME % type;

    pos_name INT:= 0;
    pos_patronymic INT:= 0;
    CURSOR c_teacher IS SELECT TEACHER_NAME FROM TEACHER;
BEGIN
        SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
        for l_teachername in c_teacher
        loop
            pos_name := INSTR(l_teachername.TEACHER_NAME, ' ');
            pos_patronymic := INSTR(l_teachername.TEACHER_NAME, ' ', pos_name + 1);

            LastName := SUBSTR(l_teachername.TEACHER_NAME, 1, pos_name);

            FirstName := SUBSTR(l_teachername.TEACHER_NAME, pos_name, pos_patronymic-1);
            FirstName := SUBSTR(FirstName, 1, 2);

            Patronymic := SUBSTR(l_teachername.TEACHER_NAME, pos_patronymic);
            Patronymic := SUBSTR(Patronymic, 1, 2);

            SYS.DBMS_OUTPUT.PUT_LINE(LastName||' '||FirstName||'.'||Patronymic||'.');

        END LOOP;
END;

-- TASK 3 monday
create view V_BIRTHDAY_MONDAY as
    select * from TEACHER
        where extract(month from BIRTHDAY) = 2;

select * from V_BIRTHDAY_MONDAY;
-- drop view V_BIRTHDAY_MONDAY;

-- TASK 4
create view V_BIRTHDAY_ON_NEXT_MONTH as
    select * from TEACHER
        where to_char(BIRTHDAY,'Month') = to_char(sysdate + 30,'Month');

select * from V_BIRTHDAY_ON_NEXT_MONTH;
-- drop view V_BIRTHDAY_ON_NEXT_MONTH;

-- TASK 5
create view COUNT_BIRTHDAY_TEACHER as select
    sum(case when extract(month from BIRTHDAY) = 1  then 1 else 0 end) as "January",
    sum(case when extract(month from BIRTHDAY) = 2  then 1 else 0 END) as "February ",
    sum(case when extract(month from BIRTHDAY) = 3  then 1 else 0 END) as "March ",
    sum(case when extract(month from BIRTHDAY) = 4  then 1 else 0 END) as "April ",
    sum(case when extract(month from BIRTHDAY) = 5  then 1 else 0 END) as "May",
    sum(case when extract(month from BIRTHDAY) = 6  then 1 else 0 END) as "June",
    sum(case when extract(month from BIRTHDAY) = 7  then 1 else 0 END) as "Jule",
    sum(case when extract(month from BIRTHDAY) = 8  then 1 else 0 END) as "August",
    sum(case when extract(month from BIRTHDAY) = 9  then 1 else 0 END) as "September",
    sum(case when extract(month from BIRTHDAY) = 10 then 1 else 0 END) as "October",
    sum(case when extract(month from BIRTHDAY) = 11 then 1 else 0 END) as "November",
    sum(case when extract(month from BIRTHDAY) = 12 then 1 else 0 END) as "December"
from TEACHER;

select * from COUNT_BIRTHDAY_TEACHER;
-- drop view COUNT_BIRTHDAY_TEACHER;



-- TASK 6 mod(YEAR_BIRTHDAY,10) = 0
DECLARE
    YEAR_BIRTHDAY int;
    cursor c_teacher is select * from TEACHER;
    row_teacher TEACHER % rowtype;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    for row_teacher in c_teacher
        loop
            YEAR_BIRTHDAY := (to_number(to_char(sysdate, 'YYYY')) + 1) - to_number(to_char(row_teacher.BIRTHDAY, 'YYYY'));

            if (mod(YEAR_BIRTHDAY,10) = 0)
                then
                    SYS.DBMS_OUTPUT.PUT_LINE(row_teacher.TEACHER_NAME|| ' '|| row_teacher.BIRTHDAY|| ' years: '|| YEAR_BIRTHDAY);
            end if;
        end loop;
END;

-- TASK 7 AVG using cursors
DECLARE
    SUM_SALARY INT := 0;
    QUANTITY_IN_FACULTY INT := 0;
    cursor c_teacher is select * from TEACHER;
    cursor c_pulpit is select * from PULPIT;
    cursor c_faculty is select * from FACULTY;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('-------------------------------avg pulpit-------------------------------------');

    for row_pulpit in c_pulpit
        loop
            for row_teacher in c_teacher
            loop
                if row_teacher.PULPIT = row_pulpit.PULPIT
                        then
                        SUM_SALARY := SUM_SALARY + row_teacher.SALARY;
                        QUANTITY_IN_FACULTY := QUANTITY_IN_FACULTY + 1;
                end if;
                end loop;

            SYS.DBMS_OUTPUT.PUT_LINE(row_pulpit.PULPIT_NAME ||' '||'AVG SALARY = '|| floor(SUM_SALARY/QUANTITY_IN_FACULTY));
            QUANTITY_IN_FACULTY := 0;
            SUM_SALARY := 0;

        end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('-------------------------------avg faculty-------------------------------------');
    for row_faculty in c_faculty
        loop
            for row_pulpit in c_pulpit
                loop
                    if row_faculty.FACULTY = row_pulpit.FACULTY
                        then
                            for row_teacher in c_teacher
                                loop
                                    if row_teacher.PULPIT = row_pulpit.PULPIT
                                        then
                                            SUM_SALARY := SUM_SALARY + row_teacher.SALARY;
                                            QUANTITY_IN_FACULTY := QUANTITY_IN_FACULTY + 1;
                                    end if;
                            end loop;

                    end if;
            end loop;
        SYS.DBMS_OUTPUT.PUT_LINE(row_faculty.FACULTY_NAME ||' '||'AVG SALARY = '|| floor(SUM_SALARY/QUANTITY_IN_FACULTY));
        QUANTITY_IN_FACULTY := 0;
        SUM_SALARY := 0;
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('-------------------------------avg all faculty-------------------------------------');
    for row_teacher in c_teacher
        loop
            SUM_SALARY := SUM_SALARY +row_teacher.SALARY;
            QUANTITY_IN_FACULTY := QUANTITY_IN_FACULTY + 1;
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('ALL AVG FACULTY SALARY = '|| floor(SUM_SALARY/QUANTITY_IN_FACULTY));
END;


--TASK 8 RECORD
DECLARE

    TYPE DETAIL_STUDENT IS RECORD
    (
         FACULTY SKVORTSOFF.FACULTY.FACULTY % type,
         COURSE INT
    );

    TYPE STUDENT IS RECORD
    (
        NAME VARCHAR2(30),
        LASTNAME VARCHAR2(30),
        OLD INT,
        DETAIL DETAIL_STUDENT
    );
    student_1 STUDENT;
    student_2 STUDENT;
BEGIN
    student_1.NAME := 'David';
    student_1.LASTNAME := 'Hammerstein';
    student_1.OLD := 20;
    student_1.DETAIL.FACULTY := 'FIT';
    student_1.DETAIL.COURSE := 3;

    student_2 := student_1;

    SYS.DBMS_OUTPUT.PUT_LINE
        (
            'Name: ' || student_2.NAME ||' '||
            'Lastname: ' || student_2.LASTNAME ||' '||
            'Old: ' || student_2.OLD ||' '||
            'Faculty: ' || student_2.DETAIL.FACULTY ||' '||
            'Course: ' || student_2.DETAIL.COURSE
        );

END;

-- TESTS
BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE(rtrim(to_char(sysdate+30,'Month')));
    SYS.DBMS_OUTPUT.PUT_LINE(to_char(sysdate+30,'Month'));
END;
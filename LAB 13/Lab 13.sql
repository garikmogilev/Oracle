-- LAB 13 PROCEDURES AND FUNCTIONS
select * from USER_PROCEDURES;

---------------- IF USE DATAGRIP ----------------------
begin
        SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
end;
-------------------------------------------------------

-- TASK 1 GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE)

DECLARE
    procedure GET_TEACHERS (PCODE TEACHER.PULPIT % TYPE)
        is
            cursor c_teacher is select * from TEACHER;
        begin
            for row_teacher in c_teacher
                loop
                    if PCODE = row_teacher.PULPIT
                        then
                            SYS.DBMS_OUTPUT.PUT_LINE(
                                        'NAME: ' || row_teacher.TEACHER_NAME || ' ' ||
                                        'TEACHER: ' || row_teacher.TEACHER || ' ' ||
                                        'PULPIT: ' || row_teacher.PULPIT
                                );
                    end if;
                end loop;
        end;
BEGIN
    GET_TEACHERS('ИСиТ');
end;

-- TASK 2 function (any) get age teacher
DECLARE
    teacher_old number := 0;

    function GET_AGE_TEACHER (TCODE TEACHER.TEACHER % TYPE)
        return number
            is
                cursor c_teacher is select * from TEACHER;
        begin
            for row_teacher in c_teacher
                loop
                    if TCODE = row_teacher.TEACHER
                        then
                            teacher_old := to_number(to_char(sysdate, 'YYYY')) - to_number(to_char(row_teacher.BIRTHDAY, 'YYYY'));
                            return teacher_old;
                    end if;
                end loop;
            return teacher_old;
        end GET_AGE_TEACHER;
BEGIN
     SYS.DBMS_OUTPUT.PUT_LINE(GET_AGE_TEACHER('ПСТВЛВ'));
end;

-- TASK 3 get number of teachers at the faculty
create or replace function GET_NUM_TEACHERS(PCODE TEACHER.PULPIT % type)
    return NUMBER is
        cursor c_teacher is select * from TEACHER;
        COUNTER number := 0;
BEGIN
    for row_teacher in c_teacher
        loop
            if PCODE = row_teacher.PULPIT
                then
                    COUNTER := COUNTER + 1;
            end if;
        end loop;
    return COUNTER;
END;

---------------- TEST GET_NUM_TEACHERS ----------------
DECLARE
    l_pulpit TEACHER.PULPIT % TYPE;
BEGIN
    l_pulpit := 'ИСиТ';
    SYS.DBMS_OUTPUT.PUT_LINE('TEACHERS AT THE FACULTY OF ' || trim(l_pulpit) ||': ' || GET_NUM_TEACHERS(l_pulpit));
END;
-------------------------------------------------------
-- drop function GET_NUM_TEACHERS;
-------------------------------------------------------

-- TASK 4 GET_TEACHERS for FACULTY
create or replace procedure GET_TEACHERS(FCODE FACULTY.FACULTY % type)
as
    cursor c_teacher is select * from TEACHER
        inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
            inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                where FACULTY.FACULTY = FCODE;
BEGIN
    for row_teacer in c_teacher
        loop
            SYS.DBMS_OUTPUT.PUT_LINE
                (
                    row_teacer.TEACHER ||' '||
                    row_teacer.TEACHER_NAME ||' '||
                    row_teacer.SALARY || ' ' ||
                    row_teacer.BIRTHDAY
                );
        end loop;
END;

---------------- TEST GET_TEACHERS ----------------
DECLARE
    l_faculty FACULTY.FACULTY % TYPE;
BEGIN
    l_faculty := 'ИЭФ';
    GET_TEACHERS(l_faculty);
END;
-------------------------------------------------------
-- drop function GET_TEACHERS;
-------------------------------------------------------

create or replace procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT % type)
as
    cursor c_subject is select * from SUBJECT
        where SUBJECT.PULPIT = PCODE;
BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE('PULPIT : ' || PCODE);

    for row_subject in c_subject
        loop
            SYS.DBMS_OUTPUT.PUT_LINE
                (
                    'SUBJECT: ' || trim(row_subject.SUBJECT_NAME)
                );
        end loop;
END;
-------------------------------------------------------
-- procedure GET_SUBJECTS
-------------------------------------------------------

---------------- TEST GET_SUBJECTS ----------------
DECLARE
    l_pulpit SUBJECT.PULPIT % TYPE;
BEGIN
    l_pulpit := 'ИСиТ';
    GET_SUBJECTS(l_pulpit);
END;

-- TASK 5 get number of teachers at the faculty
DECLARE
    l_faculty FACULTY.FACULTY % TYPE;

        function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY % type)
            return number
                is
            COUNTER number := 0;
        begin
        select COUNT(*) into COUNTER from  TEACHER
            inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
                inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                    where FACULTY.FACULTY = FCODE;
        return COUNTER;
        end GET_NUM_TEACHERS;
    BEGIN
        ---------------- TEST GET_NUM_TEACHERS ----------------
    l_faculty := 'ТТЛП';
     SYS.DBMS_OUTPUT.PUT_LINE('NUMBER OF TEACHERS AT THE FACULTY '||
                              trim(l_faculty) ||' : '||
                              GET_NUM_TEACHERS(l_faculty));
END;


DECLARE
    l_pulpit SUBJECT.PULPIT % TYPE;

    function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT % type)
            return NUMBER as
            COUNTER number := 0;
    BEGIN
       select COUNT(*) into COUNTER from SUBJECT
            where SUBJECT.PULPIT = PCODE;
       return COUNTER;
    END GET_NUM_SUBJECTS;
BEGIN
        ---------------- TEST GET_NUM_SUBJECTS ----------------
    l_pulpit := 'ИСиТ';
    SYS.DBMS_OUTPUT.PUT_LINE('NUMBER OF SUBJECT AT THE FACULTY '||
                              trim(l_pulpit) ||' : '||
                             GET_NUM_SUBJECTS(l_pulpit));
END;

-- TASK 6
create or replace package TEACHERS
    as
    procedure  GET_TEACHERS(FCODE FACULTY.FACULTY % type);
    procedure  GET_SUBJECTS(PCODE SUBJECT.PULPIT % type);
    function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY % TYPE) return number;
    function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT % type) return number;
end TEACHERS;
-------------------------------------------------------
-- drop package TEACHERS;
-------------------------------------------------------

create or replace package body TEACHERS
        as
    procedure GET_TEACHERS(FCODE FACULTY.FACULTY % type)
        as
        cursor c_teacher is select * from TEACHER
            inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
                inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                    where FACULTY.FACULTY = FCODE;
    BEGIN
        for row_teacer in c_teacher
            loop
                SYS.DBMS_OUTPUT.PUT_LINE
                    (
                        row_teacer.TEACHER ||' '||
                        row_teacer.TEACHER_NAME ||' '||
                        row_teacer.SALARY || ' ' ||
                        row_teacer.BIRTHDAY
                    );
            end loop;
    END;

        procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT % type)
            as
            cursor c_subject is select * from SUBJECT
                where SUBJECT.PULPIT = PCODE;
        BEGIN
            SYS.DBMS_OUTPUT.PUT_LINE('PULPIT : ' || PCODE);

        for row_subject in c_subject
            loop
                SYS.DBMS_OUTPUT.PUT_LINE
                    (
                        'SUBJECT: ' || trim(row_subject.SUBJECT_NAME)
                    );
            end loop;
        END;

        function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY % TYPE)
            return number
                as
            COUNTER number := 0;
        BEGIN
            select COUNT(*) into COUNTER from  TEACHER
                inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
                    inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                        where FACULTY.FACULTY = FCODE;
            return COUNTER;
        END;

        function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT % type)
            return number as
        COUNTER number := 0;
            BEGIN
                select COUNT(*) into COUNTER from SUBJECT
                    where SUBJECT.PULPIT = PCODE;
                return COUNTER;
        END;
end;
-------------------------------------------------------
-- drop package body TEACHERS;
-------------------------------------------------------

-- TASK 7
DECLARE
    l_pulpit SUBJECT.PULPIT % type;
    l_faculty FACULTY.FACULTY % type;
BEGIN
    l_pulpit := 'ИСиТ';
    l_faculty := 'ТТЛП';

    SYS.DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    TEACHERS.GET_TEACHERS('ИЭФ');
    SYS.DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    TEACHERS.GET_SUBJECTS('ИСиТ');
    SYS.DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE('NUMBER OF SUBJECT AT THE FACULTY '||trim(l_pulpit) ||' : '|| TEACHERS.GET_NUM_SUBJECTS(l_pulpit));
    SYS.DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE('NUMBER OF TEACHERS AT THE FACULTY '||trim(l_faculty) ||' : '|| TEACHERS.GET_NUM_TEACHERS(l_faculty));
END;
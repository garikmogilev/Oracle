
create or replace procedure GetAllStudents(c_student out SYS_REFCURSOR)
    as
begin
    open c_student for select * from STUDENT;
end;

-- drop function GetAllStudents;

declare
    rc sys_refcursor;
begin
    GETALLSTUDENTS(rc);
    for student in rc
    loop
        SYS.DBMS_OUTPUT.PUT_LINE(student.LASTNAME);
        end loop;
end;
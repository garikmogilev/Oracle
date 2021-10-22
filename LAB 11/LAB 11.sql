-- LAB 11
---------------------- IMPLICIT CURSORS ----------------------
-- TASK 1 implicit cursor in anonymous block

DECLARE
    l_teacher TEACHER % rowtype;
BEGIN
    select * into l_teacher from TEACHER where TEACHER = 'СМЛВ';

    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE
        (l_teacher.TEACHER ||' | '||
            l_teacher.TEACHER_NAME ||' | '||
            l_teacher.PULPIT
        );
END;

-- TASK 2 implicit cursor in anonymous block with exceptions block
DECLARE
    l_teacher TEACHER % rowtype;
BEGIN
    select * into l_teacher from TEACHER where TEACHER = 'СМЛВ';

    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE
        (l_teacher.TEACHER ||' | '||
            l_teacher.TEACHER_NAME ||' | '||
            l_teacher.PULPIT
        );

EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || 'msg oracle: ' || sqlerrm);
END;

-- TASK 3 implicit cursor in anonymous block with exceptions block and concrete exceptions TOO_MANY_ROWS
DECLARE
    l_teacher TEACHER % rowtype;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    select * into l_teacher from TEACHER;

    SYS.DBMS_OUTPUT.PUT_LINE
        (l_teacher.TEACHER ||' | '||
            l_teacher.TEACHER_NAME ||' | '||
            l_teacher.PULPIT
        );

EXCEPTION

    when TOO_MANY_ROWS
        then
            SYS.DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS');

    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || 'msg oracle: ' || sqlerrm);
END;

-- TASK 4 implicit cursor in anonymous block with exceptions block and concrete exceptions NO_DATA_FOUND
DECLARE
    l_teacher TEACHER % rowtype;
    isFound boolean := false;
    isOpen boolean := false;
    counter integer := 0;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    select * into l_teacher from TEACHER where TEACHER = 'СМЛВa';

    isFound := sql % found;
    isOpen  := sql % isopen;
    counter   := sql % rowcount;

    ---------- IS FOUND ROW ----------
    if isFound
        then
            SYS.DBMS_OUTPUT.PUT_LINE('found row');
    else
            SYS.DBMS_OUTPUT.PUT_LINE('no found row');
    end if;

    ---------- IS OPEN ----------
        if isFound
        then
            SYS.DBMS_OUTPUT.PUT_LINE('cursor open');
    else
            SYS.DBMS_OUTPUT.PUT_LINE('cursor not open');
    end if;

    SYS.DBMS_OUTPUT.PUT_LINE('found rows: ' || counter);

    SYS.DBMS_OUTPUT.PUT_LINE
        (l_teacher.TEACHER ||' | '||
            l_teacher.TEACHER_NAME ||' | '||
            l_teacher.PULPIT
        );
EXCEPTION

    when NO_DATA_FOUND
        then
            SYS.DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');

    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;


-- TASK 5 update in anonymous block with operators COMMIT / ROLLBACK
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);

    update  TEACHER set
        TEACHER_NAME = 'Жаровский Иван Михайлович'
            where TEACHER = 'ЖРСК';

-- commit;
rollback;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 6 update in anonymous block with operators COMMIT / ROLLBACK
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);

    update  TEACHER set
        TEACHER = 'ЖРСКМЛАДАЫЫ'
            where TEACHER = 'ЖРСК';

-- commit;
rollback;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 7 insert in anonymous block with operators COMMIT / ROLLBACK
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);

    insert into SKVORTSOFF.TEACHER (TEACHER, TEACHER_NAME, PULPIT)
        values ('ДБОББ', 'Добробаба Валерия Николаевна', 'ОХ');

commit;
-- rollback;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 8 insert in anonymous block with operators COMMIT / ROLLBACK
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);

    insert into SKVORTSOFF.TEACHER (TEACHER, TEACHER_NAME, PULPIT)
        values ('ДБО', 'Добробаба Валерия Николаевна', 'ОХТ');        -- incorrect pulpit

commit;
-- rollback;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 9 delete in anonymous block with operators COMMIT / ROLLBACK
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);

    delete from SKVORTSOFF.TEACHER
        where TEACHER = 'ДБОББ';

commit;
-- rollback;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 10 delete in anonymous block with operators COMMIT / ROLLBACK
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);

    delete from SKVORTSOFF.TEACHER
        where TEACHER = 0;

commit;
-- rollback;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;





---------------------- EXPLICIT CURSORS ----------------------
-- TASK 11 anonymous block, then print table TEACHER using explicit cursor and loop cycle
DECLARE
    cursor c_teacher is select TEACHER, TEACHER_NAME, PULPIT from TEACHER;
    l_teacher       SKVORTSOFF.TEACHER.TEACHER % type;
    l_teacher_name  SKVORTSOFF.TEACHER.TEACHER_NAME % type;
    l_pulpit        SKVORTSOFF.TEACHER.PULPIT % type;
BEGIN
    open c_teacher;     -- open cursor
    SYS.DBMS_OUTPUT.PUT_LINE('rows read: ' || c_teacher % rowcount);

    loop
        fetch c_teacher into l_teacher, l_teacher_name, l_pulpit;
            exit when c_teacher % notfound;

        SYS.DBMS_OUTPUT.PUT_LINE(l_teacher ||' '|| l_teacher_name ||' '|| l_pulpit);
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('rows read: ' || c_teacher % rowcount);
    close c_teacher;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;


-- TASK 12 anonymous block, then print table TEACHER using explicit cursor and while cycle
DECLARE

    cursor c_teacher is select TEACHER, TEACHER_NAME, PULPIT from TEACHER;
    l_row_teacher SKVORTSOFF.TEACHER % rowtype;

BEGIN
    open c_teacher;     -- open cursor
    SYS.DBMS_OUTPUT.PUT_LINE('rows read: ' || c_teacher % rowcount);

    fetch c_teacher into l_row_teacher;         -- if don't get first row c_teacher will be empty and c_teacher % found returned false
    while c_teacher % found
    loop
        fetch c_teacher into l_row_teacher;

        SYS.DBMS_OUTPUT.PUT_LINE(l_row_teacher.TEACHER ||' '|| l_row_teacher.TEACHER_NAME ||' '|| l_row_teacher.PULPIT);
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('rows read: ' || c_teacher % rowcount);
    close c_teacher;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 13 anonymous block, then print join table TEACHER and PULPIT using explicit cursor and while cycle
DECLARE
    cursor c_teacher_pulpit is
        select *
            from PULPIT
    inner join TEACHER T on PULPIT.PULPIT = T.PULPIT;
    row_teacher_pulpit c_teacher_pulpit % rowtype;
BEGIN
    open c_teacher_pulpit;     -- open cursor
    SYS.DBMS_OUTPUT.PUT_LINE('rows read: ' || c_teacher_pulpit % rowcount);

    fetch c_teacher_pulpit into row_teacher_pulpit;         -- if don't get first row c_teacher will be empty and c_teacher % found returned false

    while c_teacher_pulpit % found
    loop
        fetch c_teacher_pulpit into row_teacher_pulpit;

        SYS.DBMS_OUTPUT.PUT_LINE(
            row_teacher_pulpit.TEACHER ||' '||
            row_teacher_pulpit.TEACHER_NAME ||' '||
            row_teacher_pulpit.FACULTY ||' '||
            row_teacher_pulpit.PULPIT_NAME
            );
    end loop;
    close c_teacher_pulpit;
    SYS.DBMS_OUTPUT.PUT_LINE('rows read: ' || c_teacher_pulpit % rowcount);
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 14 anonymous block, cursor with parameters
DECLARE

    cursor c_auditorium (min SKVORTSOFF.AUDITORIUM.AUDITORIUM % type, max SKVORTSOFF.AUDITORIUM.AUDITORIUM % type)
        is
            select * from AUDITORIUM
                where AUDITORIUM_CAPACITY >= min and  AUDITORIUM_CAPACITY <= max;
    row_auditorium c_auditorium % rowtype;

BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('capacity 0 - 20');

    ---------------------- for ----------------------
    for row_auditorium in c_auditorium(0,20)
    loop
        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE('capacity 21 - 30');

    ---------------------- while ----------------------
    open c_auditorium(21,30);
    fetch c_auditorium into row_auditorium;

    while (c_auditorium % found)
    loop
        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
        fetch c_auditorium into row_auditorium;
    end loop;
    close c_auditorium;

    SYS.DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE('capacity 31 - 60');

    open c_auditorium(31,60);

    loop
        fetch c_auditorium into row_auditorium;
        exit when c_auditorium % notfound;

        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
    end loop;
    close c_auditorium;

    SYS.DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE('capacity 61 - 80');

    for row_auditorium in c_auditorium(61,80)
    loop
        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    SYS.DBMS_OUTPUT.PUT_LINE('capacity 81 - ... ');

    for row_auditorium in c_auditorium(81,9999)
    loop
        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
    end loop;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 15 anonymous block, ref cursor
DECLARE
     type auditorium_cursor_type is ref cursor
         return AUDITORIUM % rowtype;
     c_auditorium  auditorium_cursor_type;
     row_auditorium c_auditorium % rowtype;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    open c_auditorium for select * from AUDITORIUM;

    fetch c_auditorium into row_auditorium;

    while (c_auditorium % found)
    loop
        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
           fetch c_auditorium into row_auditorium;
    end loop;

    close c_auditorium;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 16 under request in cursors
DECLARE
    cursor curs_aut
        is select auditorium_type, cursor
            (
                select AUDITORIUM
                from auditorium A
                where B.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE
            )
    from AUDITORIUM_TYPE B;
    c_auditorium sys_refcursor;
    aut auditorium_type.auditorium_type%type;
    txt varchar2(1000);
    aum auditorium.auditorium%type;
begin
    open curs_aut;
        fetch curs_aut into aut, c_auditorium;
        while(curs_aut % found)
        loop
            txt:=rtrim(aut)||':';

            loop
                fetch c_auditorium into aum;
                exit when c_auditorium%notfound;
                txt := txt||','||rtrim(aum);
            end loop;

            SYS.DBMS_OUTPUT.PUT_LINE(txt);
            fetch curs_aut into aut, c_auditorium;
        end loop;
    close curs_aut;
exception
    when others then
        SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
end;


-- TASK 17 anonymous block, cursor with parameters, UPDATE CURRENT OF, cycle FOR
DECLARE

    cursor c_auditorium (min SKVORTSOFF.AUDITORIUM.AUDITORIUM % type, max SKVORTSOFF.AUDITORIUM.AUDITORIUM % type)
        is
            select * from AUDITORIUM
                where AUDITORIUM_CAPACITY >= min and  AUDITORIUM_CAPACITY <= max
                    for update ;

BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('increase the capacity by 10% from 40 to 80');

    ---------------------- for --- current of ----------------------
    for row_auditorium in c_auditorium(40,80)
    loop
        update AUDITORIUM
            set AUDITORIUM_CAPACITY = row_auditorium.AUDITORIUM_CAPACITY * 1.1
                where current of c_auditorium;

        SYS.DBMS_OUTPUT.PUT_LINE(
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
    end loop;

EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 18 anonymous block, cursor with parameters, DELETE CURRENT OF, cycle WHILE
DECLARE

    cursor c_auditorium (min SKVORTSOFF.AUDITORIUM.AUDITORIUM % type, max SKVORTSOFF.AUDITORIUM.AUDITORIUM % type)
        is
            select * from AUDITORIUM
                where AUDITORIUM_CAPACITY >= min and  AUDITORIUM_CAPACITY <= max
                    for update ;
    row_auditorium c_auditorium % rowtype;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('delete rows from 0 to 20');

    ---------------------- while --- current of ----------------------
    open c_auditorium(0, 20);
    fetch c_auditorium into row_auditorium;

    while (c_auditorium % found)
    loop
        delete from AUDITORIUM
                where current of c_auditorium;

        SYS.DBMS_OUTPUT.PUT_LINE(
            'ROW DELETED: '||
            row_auditorium.AUDITORIUM ||' '||
            row_auditorium.AUDITORIUM_NAME ||' '||
            row_auditorium.AUDITORIUM_CAPACITY
            );
        fetch c_auditorium into row_auditorium;
    end loop;

EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 19 anonymous block, rowid with operators update, delete
DECLARE
    row_id_auditorium rowid;
BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('row id select');

    select ROWID into row_id_auditorium
        from AUDITORIUM
            where AUDITORIUM_NAME = '429-4';

    update AUDITORIUM set AUDITORIUM_CAPACITY = 99
        where ROWID = row_id_auditorium;

    delete AUDITORIUM where ROWID = row_id_auditorium;

    rollback ;
    SYS.DBMS_OUTPUT.PUT_LINE(row_id_auditorium);


EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;

-- TASK 20 printing a table by groups
DECLARE
    cursor c_teacher is select * from TEACHER;
    row_teacher c_teacher % rowtype;
BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE('Print table TEACHER');

    for row_teacher in c_teacher
    loop
        if MOD(c_teacher % rowcount, 3) = 0
            then
            SYS.DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        end if;
    SYS.DBMS_OUTPUT.PUT_LINE(row_teacher.TEACHER_NAME || ' ' ||
                             row_teacher.TEACHER || ' ' ||
                             row_teacher.PULPIT
        );
    end loop;
EXCEPTION
    when others
        then
            SYS.DBMS_OUTPUT.PUT_LINE('code error: ' || sqlcode || ' msg oracle: ' || sqlerrm);
END;
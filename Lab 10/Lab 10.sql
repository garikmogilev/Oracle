-- LAB 10
-- PREPARE
-- alter pluggable database orclpdb open ;

-- TASK 1
BEGIN
    null;
END;

-- TASK 2

BEGIN
    SYS.DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('Hello World');
END;

-- TASK 3
DECLARE
    a number(1) := 1;
    b number(1) := 0;
    result number(10, 2);

BEGIN
    result := a/b;

EXCEPTION

WHEN OTHERS
  THEN SYS.DBMS_OUTPUT.PUT_LINE
      (
      'ERROR SQLCODE: ' || sqlcode ||
      ', SQLERRM: ' || sqlerrm
      );

END;

-- TASK 4
DECLARE
    a number(2) := 2;
    b number(2) := 2;
    c number(3) := 100;
    d number(1) := 0;
    result number(2);
BEGIN
    result := a + b;                            -- no exception
    -- result := a/d;                           -- divide by zero
    SYS.DBMS_OUTPUT.PUT_LINE(result);
    BEGIN
        result := a + c;                        -- data type is large
        SYS.DBMS_OUTPUT.PUT_LINE(result);
        EXCEPTION

        WHEN VALUE_ERROR
            THEN SYS.DBMS_OUTPUT.PUT_LINE
            (
            'DATA TYPE IS LARGE'
            );

    END;

EXCEPTION

WHEN OTHERS
  THEN SYS.DBMS_OUTPUT.PUT_LINE
      (
      'ERROR SQLCODE: ' || sqlcode ||
      ', SQLERRM: ' || sqlerrm
      );
END;

-- TASK 5
-- show parameter plsql_warnings;       -- use to SQL+
select name, value from v$parameter where name = 'plsql_warnings';
select DBMS_WARNING.GET_WARNING_SETTING_STRING() from DUAL;

-- TASK 6 get all special symbols
select KEYWORD from V$RESERVED_WORDS where LENGTH = 1;

-- TASK 7 get all keywords
select KEYWORD from V$RESERVED_WORDS where  LENGTH != 1 order by KEYWORD;

-- TASK 8 show parameters
-- show PARAMETER;              -- use to SQL+
select * from v$parameter order by NAME;

-- TASK 9
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE('Hello World');
END;

-- TASK 10
DECLARE
    n1 BINARY_INTEGER := 123456.123456;
    n2 PLS_INTEGER := 123.123;
    n3 NATURAL := 0;
    n4 NATURALN :=0;
    n5 POSITIVE := 123;
    n6 POSITIVEN := 123;
    n7 SIGNTYPE := -.5;
BEGIN
    DBMS_OUTPUT.PUT_LINE('n1 = ' || n1);
    DBMS_OUTPUT.PUT_LINE('n2 = ' || n2);
    DBMS_OUTPUT.PUT_LINE('n3 = ' || n3);
    DBMS_OUTPUT.PUT_LINE('n4 = ' || n4);
    DBMS_OUTPUT.PUT_LINE('n5 = ' || n5);
    DBMS_OUTPUT.PUT_LINE('n6 = ' || n6);
    DBMS_OUTPUT.PUT_LINE('n7 = ' || n7);
END;

-- TASK 11 operations
DECLARE
    n1 number(1)  := 1;
    n2 numeric(1) := 2;
    n3 numeric(1) := 9;
    n4 numeric(1) := 4;
    result number(38,10);
BEGIN
    result := n1 + n2;
    DBMS_OUTPUT.PUT_LINE(TO_NCHAR(n1) || ' + ' || TO_NCHAR(n2) || ' = ' || result);
    result := MOD(n3, n2);
    DBMS_OUTPUT.PUT_LINE(TO_NCHAR(n3) || ' % ' || TO_NCHAR(n2) || ' = ' || result);
    result := n4 - n3;
    DBMS_OUTPUT.PUT_LINE(TO_NCHAR(n4) || ' - ' || TO_NCHAR(n3) || ' = ' || result);
    result := n3 / n4;
    DBMS_OUTPUT.PUT_LINE(TO_NCHAR(n3) || ' / ' || TO_NCHAR(n4) || ' = ' || result);
    result := n3 * n4;
    DBMS_OUTPUT.PUT_LINE(TO_NCHAR(n3) || ' * ' || TO_NCHAR(n4) || ' = ' || result);
END;

-- TASK 12 declare NUMBER
 DECLARE
    pi  number(38,37)  := 3.14159265358979323846264338327950288;
    e   number(38,37)  := 2.71828182845904523536028747135266250;
    fi  numeric(38,37) := 1.61803398874989484820458683436563812;
BEGIN
    DBMS_OUTPUT.PUT_LINE('pi: ' || pi);
    DBMS_OUTPUT.PUT_LINE('e: '  || e);
    DBMS_OUTPUT.PUT_LINE('fi: ' || fi);

END;

-- TASK 13 declare negative scale
 DECLARE
    n1  number(4,-3)  := 1234;
    n2   number(10,-2)  := 1234567890;
    n3  numeric(38,-37) := 123;
BEGIN
    DBMS_OUTPUT.PUT_LINE('n1: ' || n1);
    DBMS_OUTPUT.PUT_LINE('n2: ' || n2);
    DBMS_OUTPUT.PUT_LINE('n3: ' || n3);
END;

-- TASK 14 BINARY_FLOAT
DECLARE
    min_bf binary_float := 1.17549E-38F;
    max_bf binary_float := 3.40282E+38F;
BEGIN
     DBMS_OUTPUT.ENABLE (buffer_size => null);
     SYS.DBMS_OUTPUT.PUT_LINE('min binary_float: ' || min_bf);
     SYS.DBMS_OUTPUT.PUT_LINE('max binary_float: ' || max_bf);
END;

-- TASK 15 BINARY_DOUBLE
DECLARE
    min_bd binary_double := 2.22507485850720E-308D;
    max_bd binary_double := 1.79769313486231E+308D;
BEGIN
     DBMS_OUTPUT.ENABLE (buffer_size => null);
     SYS.DBMS_OUTPUT.PUT_LINE('min binary_double: ' || min_bd);
     SYS.DBMS_OUTPUT.PUT_LINE('max binary_double: ' || max_bd);
END;

-- TASK 16 NUMBER WITH SPECIAL SYMBOL "E"
DECLARE
    n1 number(34,20) := 117549.0123E-10;
    n2 number(34,20) := 1175.0123E+10;
BEGIN
     DBMS_OUTPUT.ENABLE (buffer_size => null);
     SYS.DBMS_OUTPUT.PUT_LINE('n1 : ' || n1);
     SYS.DBMS_OUTPUT.PUT_LINE('n2 : ' || n2);
END;

-- TASK 17 BOOL
DECLARE
    b1 boolean := true;
    b2 boolean := false;
BEGIN

    DBMS_OUTPUT.ENABLE (buffer_size => null);

    if b1 then
         SYS.DBMS_OUTPUT.PUT_LINE ('b1: true');
    else
         SYS.DBMS_OUTPUT.PUT_LINE ('b1: false');
    end if;

    if b2 then
         SYS.DBMS_OUTPUT.PUT_LINE ('b2: true');
    else
        SYS.DBMS_OUTPUT.PUT_LINE ('b2: false');
    end if;
END;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- CHECK

-- TASK 18 constants
DECLARE
    v1 constant varchar2(5) := 'Hello';
    c1 constant char(5) := '123';
    n1 constant number := 0;
    length integer;
BEGIN
     DBMS_OUTPUT.ENABLE (buffer_size => null);
     SYS.DBMS_OUTPUT.PUT_LINE(v1 || c1 || n1);
     SYS.DBMS_OUTPUT.PUT_LINE( CONCAT(v1, c1));
     SYS.DBMS_OUTPUT.PUT_LINE('length c1: ' || 10);
     --select TO_NUMBER(c1) from SYS.DUAL;
 END;

-- TASK 19  %TYPE
DECLARE
    faculty_local SKVORTSOFF.FACULTY.FACULTY % type;
    teacher_local SKVORTSOFF.TEACHER.TEACHER % type;
    subject_local SKVORTSOFF.SUBJECT.SUBJECT % type;
BEGIN
    faculty_local := 'ИСИТ';
    teacher_local := 'Смелов';
    subject_local := 'ОСиСП';

    DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE
        (
        'faculty: ' || faculty_local ||
        'teacher: ' || teacher_local ||
        'subject: ' || subject_local
        );
END;

-- TASK 20  %ROWTYPE
DECLARE
    table_teacher SKVORTSOFF.TEACHER % rowtype;
BEGIN
    table_teacher.TEACHER := 'СМЛВ';
    table_teacher.PULPIT := 'ИСиТ';
    table_teacher.TEACHER_NAME := 'Смелов';

    DBMS_OUTPUT.ENABLE (buffer_size => null);
    SYS.DBMS_OUTPUT.PUT_LINE
        (
        ' TEACHER: ' || table_teacher.TEACHER ||
        ' TEACHER_NAME: ' || table_teacher.TEACHER_NAME ||
        ' PULPIT: ' || table_teacher.PULPIT
        );
END;

-- TASK 21 IF, ELSE IF, ELSE            21 = 22 ERROR (task list)
DECLARE
    b1 constant boolean := true;
    b2 constant boolean := false;
    b3 constant boolean := true;
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => null);

-------------------------------------- IF --------------------------------------
    if not b2
        then
            SYS.DBMS_OUTPUT.PUT_LINE('b2 == false' );
    end if;

------------------------------------ IF/ELSE -----------------------------------
    if b1
        then
            SYS.DBMS_OUTPUT.PUT_LINE('b1 == true' );
    else
            SYS.DBMS_OUTPUT.PUT_LINE('b1 == false' );
    end if;

-------------------------------- IF/ELSE IF/ELSE -------------------------------
    if b1 and b3
        then
            SYS.DBMS_OUTPUT.PUT_LINE('b1 == true ' || ' b3 == true');
    elsif b1 and not b3
        then
            SYS.DBMS_OUTPUT.PUT_LINE('b1 == true ' || ' b3 == false');
    elsif not b1 and b3
        then
            SYS.DBMS_OUTPUT.PUT_LINE('b1 == false ' || ' b3 == true');
    else
            SYS.DBMS_OUTPUT.PUT_LINE('b1 == false ' || ' b3 == false');
    end if;

END;

-- TASK 21 IF, ELSE IF, ELSE            21 = 22 ERROR (task list)
DECLARE
    operator constant char := '*';
    operand1 number(10,5) := 15;
    operand2 number(10,5) := 3;
BEGIN
    DBMS_OUTPUT.ENABLE (buffer_size => null);

    case operator
        when '+'
            then
                SYS.DBMS_OUTPUT.PUT_LINE(operand1 || ' + ' || operand2 || ' = ' || (operand1 + operand2) );
        when '-'
            then
                SYS.DBMS_OUTPUT.PUT_LINE(operand1 || ' - ' || operand2 || ' = ' || (operand1 - operand2) );
        when '*'
            then
                SYS.DBMS_OUTPUT.PUT_LINE(operand1 || ' * ' || operand2 || ' = ' || (operand1 * operand2) );
        when '/'
            then
                SYS.DBMS_OUTPUT.PUT_LINE(operand1 || ' / ' || operand2 || ' = ' || (operand1 / operand2) );

    else
        SYS.DBMS_OUTPUT.PUT_LINE('ERROR');
    end case;
END;

-- 24 TASK LOOP
DECLARE
    iterator integer :=0;
BEGIN
        DBMS_OUTPUT.ENABLE (buffer_size => null);
    loop
            iterator := iterator + 1;
            SYS.DBMS_OUTPUT.PUT_LINE('iterator: ' || iterator);
        exit when iterator > 10;
    end loop;
END;

-- 25 TASK WHILE
DECLARE
    iterator integer :=0;
BEGIN
        DBMS_OUTPUT.ENABLE (buffer_size => null);
    while(iterator < 10)
        loop
            iterator := iterator + 1;
            SYS.DBMS_OUTPUT.PUT_LINE('iterator: ' || iterator);
    end loop;
END;

-- 25 TASK FOR
DECLARE
    iterator integer :=0;
BEGIN
        DBMS_OUTPUT.ENABLE (buffer_size => null);
    for i in 1..10
        loop
            iterator := iterator + 1;
            SYS.DBMS_OUTPUT.PUT_LINE('iterator: ' || iterator);
    end loop;
END;

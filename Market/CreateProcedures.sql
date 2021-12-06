CREATE OR REPLACE PROCEDURE SKVORTSOFF6.FETCH_PERSON_HISTORY(post_cursor OUT SYS_REFCURSOR)
    IS
BEGIN
    OPEN post_cursor FOR SELECT * FROM CUSTUMERS;
END;

declare
    rc sys_refcursor;
    ch SKVORTSOFF3.CUSTUMERS % rowtype;
begin
    SKVORTSOFF3.FETCH_PERSON_HISTORY(rc);
 loop
     fetch rc
         INTO  ch;
     SYS.DBMS_OUTPUT.PUT_LINE(ch.NAME);
     EXIT WHEN rc%NOTFOUND;
 end loop;
end;

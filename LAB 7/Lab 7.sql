-- LAB 7

-- TASK 1 all background process
select NAME, DESCRIPTION, PRIORITY from V_$BGPROCESS;

-- TASK 2 active background process
select NAME, DESCRIPTION, PRIORITY from V_$BGPROCESS
    WHERE PADDR != hextoraw('00')
        order by NAME;

-- TASK 3 -- processes DBWn, when is active
select NAME, DESCRIPTION, PRIORITY from V_$BGPROCESS
    WHERE PADDR != hextoraw('00') and  NAME like 'DBW%';

-- TASK 4 get current sessions
select paddr, username, service_name, status, server
    from v$session
    where username is not null;


-- check privileges
SELECT * FROM USER_SYS_PRIVS;

create table person (
    ID NUMBER  primary key,
    name varchar2(20)
);


insert  into person(ID, name) VALUES (1,'person1');
insert  into person(ID, name) VALUES (2, 'person2');
insert  into person(ID, name) VALUES (3, 'person3');

-- TASK 4 drop and select RECYCLEBIN

select * from person;
drop table person;
SELECT * FROM RECYCLEBIN;

-- TASK 5 FLASHBACK/PURGE
-- PURGE RECYCLEBIN;
-- FLASHBACK TABLE student TO BEFORE DROP ;

-- TASK 6

DECLARE
	i NUMBER := 0;
BEGIN

	LOOP
	i := i + 1;
	insert  into person(ID, name) VALUES (i, 'person' || i);
	IF (i >= 10000) THEN
		i := 0;
		EXIT;
	END IF;
	END LOOP;
END;

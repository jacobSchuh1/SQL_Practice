drop table coursesDescription cascade constraints;
drop table coursesSpring2021 cascade constraints;

create table coursesDescription (
 cno char(6) primary key,
 title varchar2(50) default 'NA',
 dept char(3),
 credits number(1),
 prerequisite char(6) default 'NA',
 constraint creditCheck check(credits in (0, 1, 2, 3, 4, 5))
);

create table coursesSpring2021 (
    crn char(5) primary key,
    semesterCno char(6),
    seatCapacity number default 24,
    seatTaken number(2),
    --constraint cnoFK foreign key (semesterCno) references coursesDescription(cno),
    constraint seatsCheck check(seatTaken <= seatCapacity)
);



insert into coursesDescription values ('aso110', 'Academic Orientation', 'CSC', 1, null);
insert into coursesDescription values ('mat307', 'Linear Algebra', 'MAT', 3, null);
insert into coursesDescription values ('che120', 'Introduction to Chemistry', 'CHE', 4, null);
insert into coursesDescription values ('inf100', 'MS Office', 'CSC', 2, null);
insert into coursesDescription values ('csc185', 'Discrete Structures I', 'CSC', 3, null);
insert into coursesDescription values ('csc190', 'Java I', 'CSC', 3, 'csc185');
insert into coursesDescription values ('csc191', 'Java II', 'CSC', 4, 'csc190');
insert into coursesDescription values ('csc195', 'Discrete Structures II', 'CSC', 4, 'csc190');

insert into coursesSpring2021 values ('11111', 'csc190', 24, 17);
insert into coursesSpring2021 values ('12222', 'csc191', 24, 13);
insert into coursesSpring2021 values ('13333', 'aso110', 24, 10);
insert into coursesSpring2021 values ('14444', 'csc185', 24, 20);
insert into coursesSpring2021 values ('15555', 'csc190', 24, 15);
insert into coursesSpring2021 values ('10000', 'mat307', 24, 18);

select * from coursesDescription;
select * from coursesSpring2021;

--2
select cno, credits
from coursesDescription
where prerequisite is not null;

--3
select count(*)
from coursesDescription
where cno LIKE 'csc%';

--4
select crn, semesterCno, seatTaken
from coursesSpring2021
order by semesterCno DESC, seatTaken;

--5
select semesterCno, seatTaken
from coursesSpring2021
where semesterCno = 'csc190' and seatTaken <= ALL(select seatTaken from coursesSpring2021 where semesterCno = 'csc190');

--6
select sum(seatTaken)
from coursesSpring2021
where semesterCno Like 'csc%';

--7
create or replace function avgAndIncrease (cap number)
return number
is
    avgTaken number(2);
begin
    update coursesSpring2021 set seatCapacity = 50 where semesterCno like '%1__';
    select avg(seatTaken) into avgTaken from coursesSpring2021 where semesterCno like '%1__';
    return avgTaken;
end;
/

set serveroutput on;

-- Use an anonymous PL/SQL block to call the function
begin
    dbms_output.put_line(avgAndIncrease(50));
end;
/

select * from coursesSpring2021;
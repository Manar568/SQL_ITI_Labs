--UNION Operations (Use ITI database) 
--3.1. Combine the names of all students and instructors into a single list.

use ITI_new

select s.St_Fname
from Student s
union all
select i.Ins_Name
from Instructor i

--3.2. Create a list of courses that either have a duration longer than 50 hours or are taught 
--by an instructor named 'Ahmed'. 

select c.Crs_Name ,c.Crs_Duration
from Course c
where c.Crs_Duration>50
union
select  c.Crs_Name ,c.Crs_Duration
from Course c inner join Ins_Course ic
on c.Crs_Id =ic.Crs_Id
inner join Instructor i
on ic.Ins_Id=i.Ins_Id and  i.Ins_Name ='Ahmed'







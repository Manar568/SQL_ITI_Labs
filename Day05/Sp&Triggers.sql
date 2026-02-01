/*SQL Server  
stored procedure, trigger, index 
1. [use ITI DB] */
--1.1. Create a stored procedure to show the number of students per department. 

use ITI_new
create or alter procedure sp_NumStudents
as 
begin 

select count(s.St_Id),s.Dept_Id
from Student s
group by s.Dept_Id
end 

exec sp_NumStudents

/*1.2. Create a trigger to prevent anyone from inserting a new record in the department. 
Print a message for the user to tell him that he can’t insert a new record in that table. */

create or alter trigger tri_PreventInsert
on Department
instead of insert 
as 
begin 
   
   print 'you can’t insert a new record in that table '

end 

insert into Department(Dept_Id,Dept_Name)
values(50,'dep50')





/*1.3. Create a trigger on student table after insert to add Row in Student Audit table 
(Server User Name, Date, Note) 
Server User Name 
Desktop/M987 
Date 
2021-12-02 
Note  
Desktop/M987 inserted new row with 
key=500 in table student */


create table History 
(
id int identity(1,1) primary key,
Curuser varchar(20),
DateHis datetime,
Note varchar(50)
)

create or alter trigger tri_AuditStudent
on Student
after insert 
as 
begin 
declare @key varchar(30)
select @key = St_Id
from inserted
declare @note varchar(50)
set @note =concat(USER_NAME() ,' inserted new row with key :' ,@key)

insert into History (Curuser,DateHis,Note)
values (USER_NAME(),GETDATE(),@note)


end


insert into Student(St_id,St_Fname)
values(21,'manar')

select *
from History 


/*2. [Company DB] 
2.1. Create a stored procedure that will check for the number of employees in the project 
100 If they are more than 3, print a message to the user, 'The number of employees 
in the project 100 is 3 or more.' If they are less, display a message to the user, 'The 
following employees work for project 100, in addition to the first name and last 
name of each one.  */
use Company_SD


create or alter procedure sp_EmpNumber
as
begin 

declare @countt int 
select @countt= count(e.SSN)
from Employee e ,Works_for wf
where e.SSN =wf.ESSn and wf.Pno=100
group by wf.Pno

if @countt >=3
print ' the number of employees in the project 100 If they are more than 3'

else 
  begin 
  select e.Fname , e.Lname
from Employee e ,Works_for wf
where e.SSN =wf.ESSn and wf.Pno=100

   end 

end 


exec sp_EmpNumber



/*2.2. Create a stored procedure that will be used in case an old employee has left the 
project and a new one becomes instead of him. The procedure should take 3 
parameters (old employee number, new employee number, and the project number), 
and it will be used to update the works_for table. */

create or alter procedure sp_UpdateEmployee
@OldEmployee int ,
@NewEmployee int ,
@ProjectNum int 
as
begin


/*update Employee 
set SSN = @NewEmployee 
where SSN =@OldEmployee*/

update Works_for 
set Pno =@ProjectNum ,ESSn=@NewEmployee 
where ESSn =@OldEmployee


end

exec sp_UpdateEmployee @OldEmployee=112233,@NewEmployee=669955,@ProjectNum=100

select *
from Employee

select *
from Works_for

/*2.3. Create a trigger that prevents the insertion process for the employee table in 
February and test it.  */


create or alter trigger tri_InseEmpFbur
on Employee
instead of insert
as 
begin 

declare @BD datetime
select  @BD = Bdate from Employee

	IF DATEPART(MONTH, @BD) IN (2)
	begin
		print 'can not insert in Fubrary'
		return
	end
	else


	begin 
	insert into Employee
	select * from inserted 
	end

end 

insert into Employee(SSN ,Bdate)
values (2099363,'2026-02-02')

select *
from Employee






--2.4. Create a trigger that prevents users from altering any table. 

create or alter trigger tri_prevntAlter
on Database
for Alter_Table

as 
begin 
print 'can not alter on this Database'

end 

alter table employee
add ammm int

/*2.5. Create an Audit table with the following structure  
ProjectNo  
UserName  
ModifiedDate  
Hours_Old  
200  
Desktop/M987 2021-12-02 
20  
Hours _New  
22 
This table will be used to audit the update trials on the Hours column (Works_for 
table, Company DB) 
Example: 
If a user updated the Hours column, then the project no., the user name that 
made that update, the date of the modification, and the value of the old and the 
new Hours will be inserted into the Audit table  
Note: This process will take place only if the user updated the Hours column*/

create table History(

ProjectNo  int,
UserName  varchar(30),
ModifiedDate  datetime,
Hours_Old  int ,
)
alter table History
add Hours_New  int


create or alter trigger tri_AuditCompany
on Works_for
after update
as
begin 

 declare @pnum int 
 declare @oldHour int
 declare @newHour int 

 select @pnum =Pno
 from Works_for

 select @oldHour= Hours
 from deleted

 select @newHour= Hours
 from inserted


if UPDATE(Hours)
begin
insert into History(projectNo,UserName,ModifiedDate,Hours_Old,Hours_New)
values(@pnum,system_user,getdate(),@oldHour,@newHour)

end
end 


update Works_for 
set Hours=50
where pno=100

select * 
from History 

select *
from Works_for
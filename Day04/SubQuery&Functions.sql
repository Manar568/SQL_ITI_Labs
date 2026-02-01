--* Try to create the following queries. ☺ 
--1. Subquery (Use ITI database)  */
/*1.1. Simple Subquery: Write a query to find all courses with a duration longer than the 
average course duration.  */




use ITI_new

select c.*
from Course c
where c.Crs_Duration > (select AVG(c.Crs_Duration)from Course c)




/*1.2. Correlated Subquery: Find the names of students who are older than the average age 
of students in their department.   */

select ss.St_Fname , ss.St_Age
from Student ss
where ss.St_Age >
(
select AVG(s.St_Age)
from Student s
where ss.Dept_Id=s.Dept_Id
group by s.Dept_Id
)

/*1.3. Subquery in SELECT Clause: For each student, display their name and the number 
of courses they are enrolled in.   */

select (
select COUNT(sc.Crs_Id) 
from Stud_Course sc
where sc.St_Id=s.St_Id
--oup by sc.St_Id
 ) as xx ,s.St_Fname
from Student s




/*1.4. Find the name and salary of the instructor who earns more than the average salary 
of their department.   */

select ii.Ins_Name,ii.Salary
from Instructor ii
where ii.Salary>(
select AVG(i.Salary)
from Instructor i
where ii.Dept_Id =i.Dept_Id
--group by i.Dept_Id 
)


/*1.5. Subquery with IN: Find all students who are enrolled in 'C Programming' or 'Java'. */


select s.St_Fname,s.St_Id
from Student s
where s.St_Id in (
select sc.St_Id
from Stud_Course sc
where sc.Crs_Id in 
(
select c.Crs_Id
from Course c 
where c.Crs_Name='C Progamming'or c.Crs_Name= 'Java'
)
)










/*2. (Use the CompanyDB database.) 





2.1. Create Scalar function named GetEmployeeSupervisor Type: Scalar Description: Returns the 
name of an employee's supervisor based on their SSN.  */

use Company_SD

create or alter function  GetEmployeeSupervisor(@ssn int)
returns varchar(20)
as
begin

declare @name varchar(20)

select @name =s.Fname
from Employee e,Employee s
where s.SSN = e.Superssn and e.SSN=@ssn

/*select @name = e.Fname
from Employee e
where e.Superssn= @ssn*/

return @name

end

select [dbo].[GetEmployeeSupervisor](112233)

select *
from Employee

/*2.2. Create an inline table-Valued Function GetHighSalaryEmployees  
Description: Returns a table of employees with salaries higher than a specified amount.   */


create or alter function GetHighSalaryEmployees(@amount int)
returns table 
as 
return 
(
select *
from Employee e
where e.Salary >@amount
)

select * from [dbo].[GetHighSalaryEmployees](2000)



/*2.3. Multi-Statement Table-Valued Function: GetProjectAverageHours Type: Multi-Statement 
Description: Returns the average hours worked by employees on a specific project as a table.   */

create or alter function GetProjectAverageHours(@projectIDD int)
returns @empHours table (
avgH decimal(10,3),
projectId int 
)
as
begin 
	declare @avgH decimal(10,3);
	declare @projectId int ;

	insert into @empHours(avgH,projectId)
	select avg(wf.Hours) ,wf.Pno
	from Works_for wf
	where wf.Pno =@projectIDD
	group by wf.Pno
	return ;
end 

--drop function [dbo].[GetProjectAverageHours]
select * from [dbo].[GetProjectAverageHours](100)


select * 
from Works_for

/*
insert into
projectReport

select name , counter from p,w

*/
/*2.4. Create function with name GetTotalSalary Type: Scalar Function Description: Calculates and 
returns the total salary of all employees in the specified department.   */

create or alter function GetTotalSalary(@deptID int )
returns decimal(10,2)
as
begin

declare @total decimal(10,2)

select @total= SUM(e.Salary)
from Employee e 
where e.Dno =@deptID

return @total

end

select [dbo].[GetTotalSalary](30)

select *
from Employee


/*2.5. Create a function with GetDepartmentManager Type: Inline Table-Valued Function Description: 
Returns the manager's name and details for a specific department.  */


create or alter function GetDepartmentManager(@deptID int )
returns table
as 
return
(

select e.*
from Employee e
where e.SSN = (select d.MGRSSN
from Departments d
where d.Dnum= @deptID)

)

select * from [dbo].[GetDepartmentManager](30)
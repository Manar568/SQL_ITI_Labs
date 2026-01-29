--1. Views (Use CompanyDB database) 
/*1.1. Create a view that shows the project number and name along with the total number of hours 
worked on each project. */



use Company_SD


create or alter view PorjectHours_view
as  
select p.Pname , p.Pnumber,wf.Hours
from Project p inner join Works_for wf
on p.Pnumber = wf.Pno

select * 
from PorjectHours_view

/*1.2. Create a view that displays the project number and name along with the name of the department 
managing the project. */

create or alter view ProjectDepart_view
as
select p.Pnumber,p.Pname,d.Dname
from Project p, Departments d
where p.Dnum =d.Dnum

select * 
from ProjectDepart_view

/*1.3. Create a view that displays the names and salaries of employees who earn more than their 
managers. */


create or alter view HighSalaryEmployee_View
as
select e.Fname ,e.Salary ,m.Fname mangerName ,m.Salary mangerSalary
from Employee e, Employee m
where e.SSN=m.Superssn
and e.Salary>m.Salary

select * 
from HighSalaryEmployee_View







/*1.4. Create a view that displays the department number, name, and the number of employees in each 
department. */ 


create or alter view DepartEmployee_view
as
select COUNT(e.SSN) [number employees],d.Dname ,d.Dnum
from Employee e   left join Departments d
on e.Dno =d.Dnum 
group by d.Dname ,d.Dnum

select * 
from DepartEmployee_view




/*1.5. Create a view that lists the project name, location, and the name of the department managing the 
project, but exclude projects without a department. */ 

create or alter view DepartProjectExclude_view
as
select p.Pnumber,p.Pname,p.Plocation,d.Dname
from Project p, Departments d
where p.Dnum =d.Dnum and p.Dnum is not null

select * 
from DepartProjectExclude_view

/*1.6. Create a view that displays the average salary of employees in each department, along with the 
department name.  */


create or alter view AvgSalary_view 
as
select AVG(e.Salary) avgSalary,d.Dname
from Employee e inner join Departments d 
on e.Dno =d.Dnum
group by d.Dname

select * 
from AvgSalary_view


/*1.7. Create a view that displays the names of employees who have dependents, along with the number 
of dependents each employee has.  */

create or alter view EmployeeDepandent_view
as
select e.Fname 
from Employee e left join Dependent d 
on e.SSN=d.ESSN and d.ESSN is not null

select * 
from EmployeeDepandent_view

/*1.8. Create a view that shows the project name and location along with the name of the department 
managing the project, ordered by project number.  */



create or alter view OrderedProjectDepart_view
as
select p.Pnumber,p.Pname,d.Dname
from Project p, Departments d
where p.Dnum =d.Dnum

select *
from OrderedProjectDepart_view
order by Pnumber


/*1.9. Create a view that lists the names and ages of employees and their dependents (if any) in a single 
result set. The age should be calculated based on the current date.  */

create or alter view EmployeeDepandentAge_view
as
select e.Fname ,d.Dependent_name,DATEDIFF(YEAR,e.Bdate,GETDATE()) Age
from Employee e left join Dependent d 
on e.SSN=d.ESSN 

select *
from EmployeeDepandentAge_view



/*1.10. Create a view that shows the project number, name, location, and the number of employees 
working on each project, but exclude projects with no employees.  */

create or alter view EmployeeProject_view
as

select p.Pnumber,p.Pname,p.Plocation,e.SSN,e.Fname
from Employee e inner join Works_for wf
on e.SSN =wf.ESSn
inner join Project p
on p.Pnumber=wf.Pno

select *
from EmployeeProject_view

/*1.11. Create a view that displays the names and salaries of employees who have dependents, along 
with the number of dependents each employee has.*/


create or alter view EmployeeDepandent22_view
as
select e.Fname ,d.Dependent_name
from Employee e left join Dependent d 
on e.SSN=d.ESSN and d.ESSN is not null

select *
from EmployeeDepandent22_view


/*1.11. Create a view that displays the names and salaries of employees who earn more than the 
average salary of their department.  


create or alter view HighSalaryEmployee_View
as
select e.Fname ,e.Salary 
from Employee e, Departments d
where e.Dno=d.Dnum
group by d.Dnum
having e.Salary >avg(e.Salary)





/*1.12. Create a view that displays the names and salaries of employees who have dependents, along 
with the number of dependents each employee has.*/
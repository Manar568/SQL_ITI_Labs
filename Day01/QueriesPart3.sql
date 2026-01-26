--part33333333333333333333333333333333333333333


/*DQL (Use Company_SD database) 
3.1. Display all the employee data. */



select *
from Employee


--3.2. Display the employee's first name, last name, salary, and department number. 

select e.Fname,e.Lname,e.Salary,e.Dno
from Employee e


--3.3. Display all the project names, locations, and the department ID that is responsible for it. 


select p.Pname,p.Plocation,p.Dnum
from Project p

/*3.4. Display each employee's full name and his annual commission in an ANNUALCOMMISSION, 
which equals 10% of his/her annual salary (use alias). */


select e.Fname +' '+e.Lname as [Full name] ,(e.Salary*12*0.1) as NNUALCOMMISSION
from Employee e


--3.5. Display the employee ID and name who earn more than 5000 LE monthly. 

select e.SSN,e.Fname+' '+e.Lname as [Full name]
from Employee e
where Salary >5000



--3.6. Display the names and salaries of the female employees  

select  e.Fname ,Salary ,Sex
from Employee e 
where e.Sex='F'

--3.7. Display each department ID and name that is managed by a manager with an ID = 968574. 

select d.Dnum,d.Dname
from Departments d
where d.MGRSSN=968574

--3.8. Display the IDs, names, and locations of the projects that were controlled with department 10.

select p.Pnumber,p.Pname,p.Plocation
from Project p
where p.Dnum =10

--3.9. Display the ID, name, and location of the projects in Cairo or Alex City. 

select p.Pnumber,p.Pname,p.Plocation
from Project p
where p.Plocation = 'Alex' or p.Plocation = 'Cairo'

--3.10. Display the full data of the projects with a name that starts with the letter a. 

select *
from Project p
where p.Pname like 'a%'


/*3.11. Display all the employees in department 30 whose salaries range from 1000 to 2000 LE 
monthly.*/

select *
from Employee e 
where e.Dno=30 and e.Salary between 1000 and 2000 

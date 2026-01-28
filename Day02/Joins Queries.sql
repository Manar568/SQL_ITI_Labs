 --Joins (Use Company_SD database) 
--1.1. Display the department ID, name, ID, and name of its manager. 

use Company_SD

select d.Dnum,d.Dname ,e.Fname ,e.SSN
from Departments d inner join Employee e
on d.MGRSSN = e.SSN




--1.2. Retrieve the names of all employees in department 10 who work more than or equal to 10 hours 
--per week on the "AL Rabwah" project. 


select e.Fname ,p.Pname,e.Dno
from Employee e inner join  Works_for w
on e.SSN = w.ESSn and e.Dno=10
inner join Project p
on w.Pno =p.Pnumber and w.Hours =10
where p.Pname='AL Rabwah'




--1.3. Find the names of the employees who were directly supervised by Kamel Mohamed. 

select concat(e.Fname ,' ',e.Lname)as employee, concat(s.Fname,' ',s.Lname) as supervise
from Employee e left join Employee s
on e.SSN = s.Superssn
where s.Fname ='Kamel' and s.Lname='Mohamed'

--1.4. Retrieve the names of all employees and the names of the projects they are working on, sorted by 
--the project name. 

select  concat(e.Fname ,' ',e.Lname) as [full name employee] ,p.Pname
from Employee e inner join  Works_for w
on e.SSN = w.ESSn 
inner join Project p
on w.Pno =p.Pnumber



--1.5. For each project located in Cairo City, find the project number, the controlling department name, 
--the department manager's last name, the address, and the birthdate. 

select p.Pname,p.Plocation,d.Dname , e.Lname,e.Address,e.Bdate
from Project p inner join Departments d
on p.Dnum =d.Dnum and p.City ='Cairo'
inner join Employee e
on d.MGRSSN =e.SSN




--1.6. Display All Employees data and the data of their dependents, even if they have no dependents

select concat(e.Fname ,' ',e.Lname) as [full name] ,d.Dependent_name
from Employee e left join Dependent d
on e.SSN = d.ESSN
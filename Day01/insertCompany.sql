
--part222222222222222222222222222
use Company_SD


select *
from Employee


insert into Employee(Fname,Lname,SSN,Superssn,Salary)
values('New','Employee',102672,112233,3000)


insert into Employee(Fname,Lname,SSN,Dno)
values('Nada','Ahmed',102660,30)

select *
from Employee


update Employee
set Salary += (Salary*0.2)

select *
from Employee

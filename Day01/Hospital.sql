--part111111111111111111111111111111111111111


create Database Hospital

use Hospital

create table Patient (
patId int primary key ,
patName varchar(20),
dateOfBirth date,
)

create table Nurse (
nurId int primary key,
nurName varchar(20),
nurAddress varchar(50),
)
create table Ward(
warId int primary key ,
warName varchar (20),

)

create table Consltant
(
conId int primary key, 
conName varchar(20),

)

create table Drug(
druCode int primary key ,
)

create table ExminePatient(
consId int foreign key references Consltant(conId),
patId int foreign key references Patient(patId)

)

create Table GivenDrug(
patId int foreign key references Patient(patId),
nurId int foreign key references Nurse(nurId),
druCode int foreign key references Drug(druCode),
drugDate date,
)



alter table Ward 
add nurId int 
foreign key 
references Nurse(nurId)


alter table Patient
add FK_Ward int 
foreign key
references Ward(warId)

alter table Patient
add  consLeadId int
foreign key 
references Consltant(conId)



alter table Nurse
add warId int
foreign key 
references Ward(warId)
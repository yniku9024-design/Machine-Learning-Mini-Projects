-- DDL Commands are CREATE,ALTER,DROP,TRUNCATE,RENAME (and neither of them will rollback)
-- Creating table
--  Main Domain types - INT,CHAR(N),VARCHAR(N),FLOAT,BOOL,DATETIME
-- Entity Constraints(Uniquely Identifying) - PRIMARY KEY,UNIQUE,NOT NULL
-- Referential Integrity(For Maintaining relationships between tables) - FOREIGN KEY
-- Key constraint(Ensure key uniqueness) - UNIQUE,PRIMARY KEY,CANDIDATE KEY
-- NOT NULL, CHECK , DEFAULT Constraints
-- Alter is used to modify the structure of existing table (ALTER,ADD),(ALTER MODIFY)

CREATE TABLE Doctors(
doctor_id INT PRIMARY KEY,
doctor_name VARCHAR(100) NOT NULL,
speciality VARCHAR(50) NOT NULL,
experience INT,
salary INT
);

CREATE TABLE Patients(
patient_id INT PRIMARY KEY,
patient_name VARCHAR(100) NOT NULL,
age INT CHECK(age > 0),
gender CHAR(1) CHECK(gender in ('M','F','O')),
city varchar(100)
);

CREATE TABLE Appointments(
app_id INT PRIMARY KEY,
doctor_id INT NOT NULL,
patient_id INT NOT NULL,
app_date DATE NOT NULL,
FOREIGN KEY(doctor_id) references Doctors(doctor_id),
FOREIGN KEY(patient_id) references Patients(patient_id)
);


ALTER TABLE Patients ADD COLUMN blood_type VARCHAR(5);
ALTER TABLE Doctors RENAME COLUMN speciality To department;
ALTER TABLE Doctors DROP COLUMN experience;

-- DML commands used for data manipulation - INSERT,UPDATE,DELETE,SELECT(Used to reterive data)

INSERT INTO Doctors(doctor_id,doctor_name,department,salary) VALUES
(1,'Dr. Sharma','Neurology',105000),
(2,'Dr. Kapoor','Orthopedics',75000),
(3,'Dr. Verma', 'Dermatologist',80000),
(4,'Dr. Malhotra','Cardiology',50000);


INSERT INTO Patients(patient_id,patient_name,age,gender,city,blood_type) VALUES
(1,'Ravi',45,'M','Delhi','A'),
(2,'Sunita',55,'F','Jaipur','O'),
(3,'Rakesh',43,'M','Agra','B'),
(4,'Harish',23,'F','Pune','AB');


INSERT INTO Appointments(app_id,doctor_id,patient_id,app_date) VALUES
(1,1,1,'2026-02-01'),
(2,2,3,'2026-02-03'),
(3,1,4,'2026-02-05'),
(4,2,1,'2026-02-06');

Select patient_id,patient_name from Patients where age > 20;
Select doctor_id,doctor_name from Doctors where department in ('Neurology','Cardiology','Dentist');

Update Doctors Set salary = 98000 where doctor_id = 4;
Update Patients Set age = 42 where age < 25;

Delete from Patients where age < 20;

Group by is used for grouping of columns for perform group analysis

Select doctor_id, count(*) as total_appointments from Appointments Group By doctor_id;
Select doctor_name, count(*) as total_appointments from Appointments Group By doctor_id 
Having count(*) > 1;

Select * from doctors ORDER BY salary desc;
Select * from doctors order by salary desc limit 2;
Select sum(salary) as total_income from doctors;

Select patient_name as Names from Patients union Select doctor_name from doctors;
Select patient_id from Patients where patient_id in (Select patient_id from Appointments); 
Select D.doctor_name,A.app_date,A.patient_id from Doctors D INNER JOIN Appointments A where D.doctor_id = A.doctor_id;

Select D.doctor_name,P.patient_name,A.app_date,D.department,P.city from Appointments A INNER JOIN Patients P on P.patient_id = A.patient_id INNER JOIN Doctors D on D.doctor_id = A.doctor_id;























create database dailytasks;
use dailytasks;
-- creating Departments table --
create table Departments(Deptid int PRIMARY KEY,deptName varchar(10));

-- Creating Employees table --
create table employees(empid int PRIMARY KEY,EMPNAME VARCHAR(10),DeptID int,salary int,HireDate date,FOREIGN KEY (DeptID) references Departments(DeptID));

-- inserting values into departments --
insert into Departments values(1,'HR'),(2,'IT'),(3,'SALES');

-- inserting values into Employees --
insert into employees values(101,'JOHN',1,50000,'2018-02-12'),(102,'ALICE',2,60000,'2019-07-10'),(103,'BOB',1,55000,'2020-05-05'),(104,'CAROL',3,45000,'2017-09-20');

-- Display employees in descending order of salary --
select * from employees order by salary desc;

-- Count total number of employees --
select count(*) AS total_noof_empls from employees;

-- Find the average salary of all employees --
select AVG(salary) from employees;

-- Find the maximum salary in each department --
select deptid, MAX(salary) from employees GROUP BY Deptid;

-- Find departments having more than 1 employee --
select Deptid FROM employees GROUP BY Deptid HAVING COUNT(Empid)>1;

--  Display employees whose names start with 'A' --
select * from employees where Empname LIKE 'A%';

-- Find employees whose salary is between 45,000 and 60,000 --
select * from employees where salary BETWEEN 45000 AND 60000;

-- Show the department name of each employee (JOIN query) --
SELECT Empname,DeptName FROM Employees JOIN Departments ON Employees.DeptID=departments.DeptID;

-- Find the number of employees in each department --
select deptid,COUNT(*) FROM employees GROUP BY DeptID;

-- Display all employees, including those without a department (LEFT JOIN) --
SELECT Empname,Deptname FROM Employees LEFT JOIN Departments ON employees.DeptID=Departments.DeptID;
create database dailytasks;
use dailytasks;
-- creating Departments table --
create table Departments(Deptid int PRIMARY KEY,deptName varchar(10));
-- Creating Employees table --
create table employees(empid int PRIMARY KEY,EMPNAME VARCHAR(10),DeptID int,salary int,HireDate date,FOREIGN KEY (DeptID) references Departments(DeptID));
-- inserting values into departments --
insert into Departments values(1,'HR'),(2,'IT'),(3,'SALES');
SELECT * FROM departments;
-- inserting values into Employees --
insert into employees values(101,'JOHN',1,50000,'2018-02-12'),(102,'ALICE',2,60000,'2019-07-10'),(103,'BOB',1,55000,'2020-05-05'),(104,'CAROL',3,45000,'2017-09-20');
-- Display all records from the Employees table--
select * from employees;
-- Display only EmpName and Salary of all employees --
select empname,salary from employees;
-- Find all employees who belong to the IT department --
select * from employees JOIN Departments ON employees.DeptId=Departments.DeptId where Departments.Deptname='IT';
-- List employees whose salary is greater than 50,000 --
SELECT * FROM employees where salary>50000;
--  Find employees hired before 2020-01-01 --
SELECT * FROM employees where HireDate < '2020-01-01'
-- Display employees in descending order of salary --
SELECT * FROM employees order by salary desc;
-- Count total number of employees --
SELECT COUNT(*) AS tol_cnt_emp FROM EMPLOYEES;
-- Find the average salary of all employees --
SELECT  AVG(SALARY) AS AVG_SAL_OF_ALL_EMP FROM EMPLOYEES;
--  Find the maximum salary in each department --
select deptname,max(salary) FROM employees JOIN Departments ON employees.DeptId=Departments.DeptId GROUP BY Departments.deptname;
select Deptid,MAX(salary) FROM employees GROUP BY Deptid;
-- Find departments having more than 1 employee --
select DeptID FROM employees GROUP BY DeptId HAVING COUNT(EMPID)>1;


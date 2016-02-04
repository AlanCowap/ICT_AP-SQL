#Alan Cowap 2016
#City & Guilds Module 7540 Unit 389 SQL Programming Assignment_A_V2

#1
/*
List the last name, first name and employee number of all programmers who
were hired on or before 21 May 1991 sorted in ascending order of last name.
*/
SELECT Last_Name, First_Name, Employee_No #, Hire_Date
	FROM EMPLOYEES
	WHERE Job_ID = "IT_PROG" AND Hire_Date <= '1991-05-21'
    ORDER BY Last_Name ASC;
#2
/*
List the department number, last name and salary of all employees who were
hired between 16/09/87 and 12/05/96 sorted in ascending order of
 last name within department number.
*/
SELECT Department_No, Last_Name, Annual_Salary
	FROM employees
    WHERE Hire_Date BETWEEN '1987-09-16' AND '1996-12-05'
    ORDER BY Department_No ASC, Last_Name ASC;
#3
/*
List all the data for all jobs where the maximum salary is greater than 15000
sorted in descending order of the maximum salary.
*/
SELECT * FROM jobs WHERE Max_Salary > 15000
	ORDER BY Max_Salary DESC;

#4
/*
List the last name, first name, job id and commission of employees who earn
commission sorted in ascending order of first name within last name.
*/
SELECT Last_Name, First_Name, Job_ID, Commission_Percent FROM employees
	WHERE Commission_Percent IS NOT NULL
    ORDER BY Last_Name ASC, First_Name ASC;

#5
/*
Which jobs are found in the IT and Sales departments?
*/
SELECT DISTINCT Job_ID FROM employees
	WHERE Department_No IN (50, 60);

#Or to show the actual Job Title, rather than the Job_ID
SELECT DISTINCT jobs.Job_Title FROM employees
    INNER JOIN (jobs) ON (jobs.Job_ID = employees.Job_ID)
	WHERE Department_No IN (50, 60);

#6
/*
List the last name of all employees in departments 50 and 90 together with their
monthly salaries (rounded to 2 decimal places), sorted in ascending order of last name.
*/
SELECT Last_Name, ROUND(Annual_Salary/12, 2) AS 'Monthly_Salary' FROM employees
	WHERE Department_No IN (50, 90)
    ORDER BY Last_Name ASC;

#7
/*
Show the total salaries figure for one month displayed with no decimal places.
*/
SELECT ROUND(SUM(Annual_Salary)/12,0) AS 'Monthly_Salary' FROM employees;

#8
/*
Show the total number of employees.
*/
SELECT COUNT(DISTINCT(Employee_No)) FROM employees;
#Don't need distinct here since Employee_No is Unique, but including it for clarity

#9
/*
List the department number, department name and the number of
employees for each department that has more than 2 employees grouping by
department number and department name.
*/
SELECT departments.Department_No, departments.Department_Name, COUNT(*) AS 'NUM EMPLOYEES'
	FROM departments
	INNER JOIN(employees) ON (departments.Department_No = employees.Department_No)
    GROUP BY departments.Department_No, departments.Department_Name
    HAVING COUNT(*) > 2;

#10
/*
List the department number, department name and the number of
employees for the department that has the highest number of employees
using appropriate grouping.
*/
SELECT employees.Department_No, departments.Department_Name, COUNT(*)
FROM   employees
#WHERE  Department_No IS Not NULL
INNER JOIN (departments) ON (departments.Department_No = employees.Department_No)
GROUP  BY employees.Department_No
ORDER  BY COUNT(*) DESC
LIMIT 1;

#11
/*
List the department number and name for all departments where no
programmers work.
*/
#Now you try...


#17
/*
Create a new view for manager’s details only using all the fields from the
employee table. Apply a CHECK constraint.
*/
DROP VIEW IF EXISTS ManagersDetails;
CREATE OR REPLACE VIEW ManagersDetails AS
SELECT * FROM employees
WHERE Job_ID IN (SELECT Job_Id FROM jobs WHERE Job_Id LIKE '%MGR' )
#WHERE Job_ID LIKE '%MGR';
WITH CHECK OPTION; #Parsed but not supported by MySQL
SELECT * FROM ManagersDetails;

#18
/*
Show all the fields and all the managers using the view for managers sorted
in ascending order of employee number.
*/
SELECT * FROM ManagersDetails
ORDER BY Employee_No ASC;

#19
/*
Grant the authority to all other users to access the view for managers for
SELECT statements only.
*/
DROP USER IF EXISTS 'alan'@'localhost';
CREATE USER 'alan'@'localhost' IDENTIFIED BY 'passmysql';
GRANT SELECT ON ManagersDetails TO 'alan'@'localhost';

#20
/*
Create an index named LOC_POSTAL_CODE on the Postal Code in the
locations table.
Provide a printout showing that the index has been created.
*/
#DROP INDEX LOC_POSTAL_CODE ON locations;
#Create Index LOC_POSTAL_CODE On locations(Postal_Code);
SHOW INDEX FROM locations WHERE KEY_NAME = 'LOC_POSTAL_CODE';

use classicmodels;

-- Select all records (Columns)
select * from customers;

-- Select few records (Columns)
select customerNumber, CustomerName, phone from customers;

-- Merge columns contactFirstName, contactLastName
select concat(contactFirstName,' ', contactLastName)as ContactName from customers;

-- Alias
-- alias Column
select contactFirstName, ContactLastName, concat(contactFirstName, ContactLastName) as ContactName  from customers;
-- alias Table
select contactFirstName, ContactLastName, concat(contactFirstName, ContactLastName) as ContactName  from customers as a;
-- alias Script
select concat(b.contactFirstName, b.ContactLastName) as ContactName   from (select contactFirstName, ContactLastName from customers) b;

--  17/01/2022
-- Selecting few records (10 Rows from customer table)
select * from customers
limit 10;

-- Distinct records in SQL
-- Our customers are from how many countries
select count(country) from customers;
select count(distinct(country)) from customers;

-- Ordering in SQL asc/desc
select distinct(country) from customers
order by country desc;

-- Customer Name while ordering by Contactfirstname asc and contactlastname desc
select customername,Contactfirstname,contactlastname from customers 
order by Contactfirstname asc, contactlastname desc;

-- 1st and 10th customername by credit limit
select customername, creditlimit from customers
order by creditlimit desc
limit 10;

-- Where Mainly for setting filtering condition on extracted data
-- Select col1, col2
-- from table
-- Where Condition

-- Operators =,!=,<,>,Between,>=,<=, Like,in,Not 
-- Find total records of Female customers---What db,table,column
Select * from customers
where gender= 'F';

-- Find records of Male customers from France 
select * from customers
where gender= 'M' and country='France';

-- Find customernumbers between 250 to 360
select * from customers
where customerNumber between 250 and 360;


-- Where For Update
-- Update table 
 -- set column=value 
 -- where condition
 -- Update record 350 state to London
 select * from customers where customerNumber = 350;
 update customers
 set state= 'London'
 where customerNumber = 350;
 
 -- Where in Deleting records
 -- Delete from table
-- where condition
 insert  into customers(customerNumber,customerName,contactLastName,contactFirstName,gender,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit) values 
(8955678,'Atelier graphique','Schmitt','Carine ','F','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,'21000.00');
select * from customers where customerNumber=8955678;

delete from customers
where customerNumber=8955678;

-- Customers from France,USA and Australia
 
   select * from customers
where country = 'France''USA' and 'Australia';-- wrong

  select * from customers
where country = 'France'or'USA' or 'Australia';
  select * from customers
where country = 'France'and'USA' and 'Australia';
  select * from customers
where country = ('France','USA','Australia'); -- wrong

  select * from customers
where country = 'France'or country ='USA' or country ='Australia';
  select * from customers
where country in ('France','USA','Australia');

-- Customer with maximum credit limit
-- Maximum credit limit-- Part 1
select max(creditlimit) from customers; 
-- Who owns max(creditlimit)  10-- Part 2
select * from customers
where creditlimit= (select max(creditlimit) from customers);

-- CTE
with maxcredit as (select max(creditlimit) from customers)
select * from customers
where creditlimit= (select * from maxcredit);


-- Like Function
-- Look for customers with names starting with A
select customerName from customers
where customerName like 'A%';

select customerName from customers
where customerName like 'Au%';

-- Look for customers from country names that ends with A
select * from customers
where country like '%A';

-- Look for customer with name starting with S but ends with E.
select customerName from customers
where customerName like 'S%E';

-- Look for customer with number like _03.
select *from customers
where customerNumber like '_03';

-- 24/01/2023
use classicmodels;
-- How many employees have the firstname Leslie.
select * from employees 
where firstname = 'Leslie'; -- count(*)

-- Which employee has the highest counts of people reporting to him l her, the employee name and count of reporters.
select reportsTo,count(*) reporters from employees
group by reportsTo; -- 1102,1143;
select * from employees
where employeeNumber in (1102,1143);

-- Write a script that shows all employees with officeCode 6 and 5.
select * from employees where officecode between 5 and 6; --
select * from employees where officecode = 6 or officecode = 5; --
select * from employees where officecode in (6,5); --

-- Update employees office code of Lastname (Vanauf) and Firstname(George) to 5.
select * from employees where Lastname ='Vanauf';
update employees
set officecode=5
where employeenumber=1323;

-- Which checknumber has the least payment amount and what is the payment date.
select checknumber, paymentdate, amount from payments
where amount= (select min(amount) from payments);


-- Operators And, Or and Not

-- And & The two conditions must be true
-- Return a list of customers form USA and Stays in NYC
select *  from customers
where country= 'USA' and city= 'NYC';

-- Return a list of customers who stays in Brickhaven with creditLimit above 25000
select *  from customers
where city= 'Brickhaven' and creditlimit> 25000;


-- OR at least one conditions must be true
-- Return a list of customers form USA or Stays in NYC
select * from customers
WHERE City='NYC' or country='USA';

-- Not Negate values
-- Countries where Country in USA or France but not Australia
select distinct(country) from customers;

select distinct(country) from customers
where country = 'USA' or country = 'France' and not country ='Australia';

select distinct(country) from customers
where country in ('USA','France') and country != 'Australia';

select distinct(country) from customers
where country in ('USA','France') and country not in ('Australia');

-- Return a list of customers who stays in Brickhaven with creditLimit below 25000
select * from customers
where city = 'Brickhaven' and not creditLimit > 25000;

--  IN/Not IN and Between/ Not Between
-- In
-- Return a list of customers with customer numbers 125,128,146,145,186.
select * from customers
where customerNumber in (125,128,146,145,186);

 -- Between Range of values
-- Return a list of customers with customer numbers between 125 and 186.
select * from customers
where customerNumber between 125 and 186;

-- Between and not IN
-- Return a list of customers with customer numbers between 125 and 186 but not 125,128,146,145,186.
select * from customers
where customernumber between 125 and 186 and customernumber not in (125,128,146,145,186);

select * from customers
where customernumber between 125 and 186 or customernumber not in (125,128,146,145,186);-- Wrong

select * from customers
where customerNumber between 125 and 186 and customerNumber NOT in (125,128,146,145,186);

-- Union and Join
-- Union
-- 1st Table and second table arrangement must be thesame

-- 1 Finance
-- 2 Hr


-- Exercise: Union result of Table 1 and table 2 with column names PersonNumber, PersonName, PersonContact
-- Customers 129, 131,141 customernumber,CustomerName, phone -- Table 1
-- Employee 1002,1056,1076 employeeNumber, Employeename, officecode  -- Table 2

-- Table 1
select customernumber PersonNumber,CustomerName as PersonName, phone PersonContact from customers
where customernumber in (129, 131,141)
union
-- Table 2
select  employeeNumber, concat(firstName,' ',lastname) Employeename, officecode from employees
where employeenumber in (1002,1056,1076);
-- Both tables must have same number of columns


-- 26/1/2023

-- Join
-- Used in consolidating (Merging) tables based on matching column values (Primary Key to foreign key)
-- Provide the list of employees (By FirstName and LastName) and counts of customers owned, 
-- sort descending by count of customers

-- METHOD 1
-- Table 1
SELECT a.*,b.customerowned FROM (SELECT employeeNumber,firstName,lastName from employees) a
JOIN
-- Table 2
(SELECT salesRepEmployeeNumber,count(*) customerowned from customers
WHERE salesRepEmployeeNumber is not null
GROUP BY salesRepEmployeeNumber
ORDER BY customerowned desc) b
on a.employeeNumber=b.salesRepEmployeeNumber;

-- OPTION 2

-- METHOD 2
-- Table 1
SELECT a.*,b.customerowned from (SELECT employeeNumber,firstName,lastName from employees) a,
-- Table 2
(SELECT salesRepEmployeeNumber,count(*) customerowned from customers
WHERE salesRepEmployeeNumber is not null
GROUP BY salesRepEmployeeNumber
ORDER BY customerowned desc) b
WHERE a.employeeNumber=b.salesRepEmployeeNumber;

-- HAVING STATEMENT
-- It is used to return aggregated function within our script
-- Syntax
-- Select agg(column1), Column2,...... from table
-- Group by column2
-- Having agg(Column1) condition

-- Get the list of countries with more than 5 customers
-- WHERE cannot come after group by
SELECT * FROM customers;
SELECT country,count(*) customerowned from customers
GROUP BY country
HAVING count(*)>5
ORDER BY count(*);


-- Syntac
-- Select Column, agg(column)
-- From tables
-- Where column condition
-- Group by column
-- Having agg(column) condition
-- Order by agg(column)


-- 28/01/23
-- GET A LIST OF STATES, STATES WITH MORE THAN 5 CUSTOMERS ORDERING BY COUNT OF CUSTOMERS. NOTE DO NOT REPORT BLANK 

SELECT state, count(*)customercnt
FROM customers
WHERE state is not null
GROUP BY state
HAVING count(*)
ORDER BY count(*);

-- Null Values
-- is null/ is not null
-- Return the list of customers with null/blank states
SELECT * FROM customers
WHERE addressline2 is null;

SELECT country,count(*) FROM customers
WHERE state is null
GROUP BY country
ORDER BY count(*);

-- Update states to Lagos where state is null for Hong Kong and Ireland
SELECT * FROM customers WHERE state is null and country in ('Hong Kong','Ireland')
UPDATE customers
SET state 'Lagos'
WHERE state is null and country in ('Hong Kong', 'Ireland')


28/1/23
-- ASSIGNMENT 2
USE classicmodels;

SELECT * FROM customers;
UNION
SELECT * FROM orders;

WHERE customerNumber,customerName,phoneNumber,salesRepEmployeeNumber

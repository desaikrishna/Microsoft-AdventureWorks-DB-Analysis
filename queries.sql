'1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. 
Sort the result set in ascending order on jobtitle.'

select * from HumanResources.Employee as emp
order by emp.jobtitle

'2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. 
Sort the output in ascending order on lastname.'

select p.* from Person.Person as p
order by p.lastname

'3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. 
The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.'

select firstname, lastname, businessentityid as employee_id 
from Person.Person
order by p.lastname

'4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. 
Return productid, productnumber, and name. Arranged the output in ascending order on name.'

select productid, productnumber,name
from production.Product p
where p.sellstartdate is not null
and p.productline = 'T'
order by p.name


'5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. 
Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.'

select salesorderid, customerid,orderdate,subtotal,(taxamt/subtotal)*100 as percentage_tax from sales.salesorderheader s
order by s.subtotal desc

'6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. 
Return jobtitle column and arranged the resultset in ascending order.'

select distinct(jobtitle) from HumanResources.Employee
order by jobtitle

'7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. 
Sort the output in ascending order on customerid.'

select customerid, sum(freight)
from sales.salesorderheader
group by customerid
order by customerid

'8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.'

select customerid, salespersonid, sum(subtotal), avg(subtotal)
from sales.salesorderheader
group by customerid, salespersonid
order by customerid desc

'9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. 
Return productid and sum of the quantity. Sort the results according to the productid in ascending order.'

select productid, sum(quantity)
from production.productinventory
where shelf in ('A','C','H')
group by productid
having sum(quantity) > 500
order by productid

'10. From the following table write a query in SQL to find the total quantity for a group of locationid multiplied by 10.(Solution is wrong)'

select sum(quantity)
from production.productinventory
group by locationid*10

select sum(quantity)*10
from production.productinventory
group by locationid


'11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. 
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.'


select businessentityid, firstname, lastname, phonenumber
from Person.PersonPhone
where lastname like 'L%'
order by lastname, firstname

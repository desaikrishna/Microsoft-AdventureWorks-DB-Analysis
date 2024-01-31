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

select pp.businessentityid, p.firstname, p.lastname, pp.phonenumber
from Person.PersonPhone pp
join person.person p
using (businessentityid)
where p.lastname like 'L%'

'12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. 
Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
(New Concept Rollup,Cube and sets)'

select customerid, salespersonid, sum(subtotal) as sum_subtotal
from sales.salesorderheader
group by rollup (customerid, salespersonid)
order by salespersonid

'13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. 
Return locationid, shelf and sum of quantity as TotalQuantity.'

select locationid, shelf, sum(quantity) as totalquantity
from production.productinventory
group by cube  (locationid, shelf)
order by locationid

'14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. 
Return locationid, shelf and sum of quantity as TotalQuantity.
(Check chatgpt to understand)'

select locationid, shelf, sum(quantity) as totalquantity
from production.productinventory
group by rollup  (locationid, shelf)
order by locationid

'15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid.'

select locationid, sum(quantity) as totalquantity
from production.productinventory
group by rollup (locationid)

'16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.'

select a.city,count(b.businessentityid)
from person.businessentityaddress b
join person.address a using (addressid)
group by a.city
order by a.city

'17. From the following table write a query in SQL to retrieve the total sales for each year. 
Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.'

select extract(year from orderdate) as year, count(salesorderid) as total_sales,sum(totaldue) as total_due
from sales.Salesorderheader
group by year

'18. From the following table write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.'

select extract(year from orderdate) as year, count(salesorderid) as total_sales,sum(totaldue) as total_due
from sales.Salesorderheader
group by year
having extract(year from orderdate) <= '2012'

'18. From the following table write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.'

select contacttypeid, name
from person.contacttype
where name like '%Manager%'


'20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.'


SELECT pp.BusinessEntityID, LastName, FirstName
    FROM Person.BusinessEntityContact AS pb 
        INNER JOIN Person.ContactType AS pc
            ON pc.ContactTypeID = pb.ContactTypeID
        INNER JOIN Person.Person AS pp
            ON pp.BusinessEntityID = pb.PersonID
    WHERE pc.Name = 'Purchasing Manager'
    ORDER BY LastName, FirstName;


select p.businessentityid,p.lastname,p.firstname
from person.contacttype c
inner join person.businessentitycontact b 
on c.contactypeid = b.contactypeid
inner join person.person p
on p.businessEntityId = b.personid
'Check why the above query is not working'


'rollup
state,city
state
()
cube
state,city
state
city
()
sets'

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


'21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. 
Shorts the postalcode in ascending order.'


'22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. 
Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.'

select c.contacttypeid, count(b.personid)
from person.contacttype c
join Person.BusinessEntityContact b using (contacttypeid)
group by c.contacttypeid
having count(b.personid)>100
order by c.contacttypeid

'23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. 
In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.'

SELECT CAST(ratechangedate AS DATE) AS extracted_date, concat(p.lastname,' ',p.firstname) as fullName, 40*rate as weekly_salary
from HumanResources.EmployeePayHistory e
join person.person p using(businessentityid)
order by fullName

'24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. 
Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.'

SELECT CAST(ratechangedate AS DATE) AS extracted_date, concat(p.lastname,' ',p.firstname) as fullName, 40*rate as weekly_salary
from HumanResources.EmployeePayHistory e
join person.person p using(businessentityid)
where e.ratechangedate = (select max(ratechangedate) from HumanResources.EmployeePayHistory
                            where businessentityid = e.businessEntityId)
order by fullName


'25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.'

select salesorderid,productid,orderqty,
sum(orderqty) over win as "Total Quantity",
avg(orderqty) over win as "Avg Quantity",
count(orderqty) over win as "No of order",
min(orderqty) over win as "Min Quantity",
max(orderqty) over win as "Max Quantity"
from sales.salesorderdetail
where salesorderid in (43659,43664)
window win as (partition by salesorderid)

'26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. 
Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.'

select salesorderid,productid,orderqty,
sum(orderqty) over win as "Total Quantity",
avg(orderqty) over win as "Avg Quantity",
count(orderqty) over win as "No of order",
min(orderqty) over win as "Min Quantity",
max(orderqty) over win as "Max Quantity"
from sales.salesorderdetail
where salesorderid in (43659,43664)
and CAST(ProductID AS TEXT) LIKE '71%'
window win as (partition by salesorderid)

'27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.'

select salesorderid, sum(orderqty*unitprice)
from Sales.SalesOrderDetail
group by salesorderid
having sum(orderqty*unitprice) >100000
order by salesorderid

'28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. 
Return product ID, and name and order the result set in ascending order on product ID column.'

select productid,name
from Production.Product
where name like 'Lock Washer%'
order by productid

'29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product.'

select productid,name,color
from Production.Product
order by listprice


'30. From the following table write a query in SQL to retrieve records of employees. 
Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.'

SELECT BusinessEntityID, JobTitle, HireDate  
FROM HumanResources.Employee  
ORDER BY DATE_PART('year',HireDate);


'31. From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.'

select firstname, lastname
from person.person
where lastname like 'R%'
order by firstname, lastname desc


'32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. 
Return BusinessEntityID, SalariedFlag columns.(Did not work check)'

select businessentityid, salariedflag
from HumanResources.Employee
order by (case when salariedflag = 'true' then businessentityid desc
else businessentityid end);

SELECT BusinessEntityID, SalariedFlag  
FROM HumanResources.Employee  
ORDER BY CASE SalariedFlag WHEN 'true' THEN BusinessEntityID END DESC  
        ,CASE WHEN SalariedFlag ='false' THEN BusinessEntityID END;


'33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName 
is equal to 'United States' and by CountryRegionName for all other rows.'

select *
from sales.vSalesPerson
order by case when countryregionname ='United States' then territoryname
else countryregionname end;

'34. From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. 
Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.'

select p.firstname,p.lastname, s.salesytd,a.postalcode,
row_number() over (order  by a.postalcode) as rownumber,
rank() over (order  by a.postalcode) as rank,
dense_rank() over (order  by a.postalcode) as denserank,
ntile(4) over (order  by a.postalcode) as ntilee
from person.person p
join sales.salesperson s using (businessentityid)
join person.businessentityaddress b using (businessentityid)
join person.address a
on b.addressid = a.addressid
where s.salesytd <> 0
and territoryid is not null


'35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.'

select * from humanresources.department
order by departmentid offset 10


'36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.'

select * from humanresources.department
order by departmentid offset 5 limit 5

'37. From the following table write a query in SQL to list all the products that are Red or Blue in color. 
Return name, color and listprice.Sorts this result by the column listprice.'

select name, color, listprice
from production.product
where color='Red' or color='Blue'
order by listprice

'38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. Additionally, it returns any sales orders that dont have any 
items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. 
Return product name, salesorderid. Sort the result set on product name column.'

select p.name, s.salesorderid
from production.product p
full outer join sales.salesorderdetail s using (productid)
order by p.name, salesorderid desc

'39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.'

select p.name, s.salesorderid
from production.product p 
left join sales.salesorderdetail s using (productid)
order by p.name


'40. From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column.'

select p.name, s.salesorderid
from production.product p 
join sales.salesorderdetail s using (productid)
order by p.name


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

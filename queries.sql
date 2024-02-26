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


'41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. 
The result set includes all salespeople, regardless of whether or not they are assigned a territory.'

select name, businessentityid
from sales.salesterritory
right join sales.salesperson using(territoryid)

'42. Write a query in SQL to find the employees full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname.'

select concat(firstname, ' ', lastname) as fullname,city
from person.person
join person.businessentityaddress
using (businessentityid)
join person.address
using (addressid)
order by lastname,firstname

'43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. 
Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table.'


select businessentityid, firstname,lastname
from person.person
where persontype = 'IN'
and lastname = 'Adams'
order by firstname

'44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.'


select businessentityid, lastname, firstname
from person.person
where businessentityid <= 1500
and lastname like 'Al%'
and firstname like 'M%'


'45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.'

select productid,name,color
from 
(select * 
from production.product
where name in ('Blade','Crown Race','AWC Logo Cap')) 
as derviedtable

'46. Create a SQL query to display the total number of sales orders each sales representative receives annually. 
Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.'
'Used CTE in solution but not working when i do it'

select salespersonid, count(salesorderid), extract(year from orderdate) as year
from sales.salesorderheader
where salespersonid is not null
group by salespersonid,extract(year from orderdate)
order by salespersonid,year


'47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.'

select avg(xyz)
from
(select salespersonid,count(salesorderid) as xyz
from sales.salesorderheader
where salespersonid is not null
group by salespersonid) as abc

'48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table\'s columns must all be returned.'

select * from
production.productphoto
where largephotofilename like \'%green_%'

'49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. 
Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.'

select a.addressline1, a.addressline2, a.city, a.postalcode, s.countryregioncode from person.address a
join person.stateprovince s
using (stateprovinceid)
where countryregioncode <> 'US'

'50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.'

select jobtitle,hiredate
from HumanResources.Employee 
order by hiredate desc
limit 10 offset 0

'51. From the following tables write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100. 
Return all the columns from the tables.'

select *
from sales.salesorderheader a
join sales.salesorderdetail b
using (salesorderid)
where a.totaldue > 100
and (b.orderqty > 5 or
b.unitpricediscount < 1000)

'52. From the following table write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table.'

select name, color
from production.product
where name like '%Red%'

'53. From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain. Return name, and listprice columns from the table.'

select name, listprice 
from production.product
where listprice = '80.99'
and name like '%Mountain%'

'54. From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. Return name, and color columns.'

select name, color 
from production.product
where name like '%Mountain%'
or name like '%Road%'

'55. From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. Return Name and color.'

select name, color 
from production.product
where name like '%Mountain%'
and name like '%Black%'

'56. From the following table write a query in SQL to return all the product names with at least one word starting with the prefix chain in the Name column.'
'Not sorted yet'

select name 
from production.product
where name like 'Chain %'

'57. From the following table write a query in SQL to return all category descriptions containing strings with prefixes of either chain or full.'
'Not sorted learn to use regex in postgres for previous and this question'

select name,color
from production.product
where name like 'Chain%'
or name like 'Full%'


'58. From the following table write a SQL query to output an employees name and email address, separated by a new line character.'

select concat(p.firstname, ' ', p.lastname) || ' ' || chr(10) || e.emailaddress
from person.person p
join person.emailaddress e
using(businessentityid)

'59. From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.'

select name, position('Yellow' in name)
from production.product
where name like '%Yellow%'

'60 From the following table write a query in SQL to concatenate the name, color, and productnumber columns.'

select concat(name,' ', color, ' ', productnumber)
from production.product


'61 Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following table, each separated by a specified character.'

select concat(name,',', color, ',', productnumber)
from production.product

'62 From the following table write a query in SQL to return the five leftmost characters of each product name.'

select substring(name,1,5)
from production.product

'63 From the following table write a query in SQL to select the number of characters and the data in FirstName for people located in Australia.'

select firstname,char_length(firstname)
from sales.vindividualcustomer
where countryregionname='Australia'

'64 From the following tables write a query in SQL to return the number of characters in the column FirstName and the first and last name of contacts located in Australia.'

select firstname,lastname,char_length(firstname||''||lastname) as leng
from sales.vstorewithcontacts
join sales.vstorewithaddresses
using (businessentityid)
where countryregionname='Australia'

'65 From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00. Return product name as Lower, Upper, and also LowerUpper.'
'did not understand question properly'

SELECT LOWER(SUBSTRING(Name, 1, 25)) AS Lower,   
       UPPER(SUBSTRING(Name, 1, 25)) AS Upper,   
       LOWER(UPPER(SUBSTRING(Name, 1, 25))) As LowerUpper  
FROM production.Product  
WHERE standardcost between 1000.00 and 1220.00;

'66 Write a query in SQL to remove the spaces from the beginning of a string.'

SELECT TRIM('     SQL Tutorial!     ') AS TrimmedString;

'67 From the following table write a query in SQL to remove the substring 'HN' from the start of the column productnumber. 
Filter the results to only show those productnumbers that start with "HN". Return original productnumber column and 'TrimmedProductnumber'.'

select productnumber, substring(productnumber,4,7) as TrimmedProductNumber
from production.product
where substring(productnumber,1,2)='HN'


'68 From the following table write a query in SQL to repeat a 0 character four times in front of a production line for production line 'T'.'

select name, ('0000'||''||productline) as LineCode
from production.product
where productline = 'T'

'69 From the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6.'

select firstname, reverse(firstname) as inverted
from person.person
where businessentityid < 6


'70 From the following table write a query in SQL to return the eight rightmost characters of each name of the product. 
Also return name, productnumber column. Sort the result set in ascending order on productnumber.'

select name, productnumber,substring(name,8,length(name))
from production.product
order by productnumber

'71 Write a query in SQL to remove the spaces at the end of a string.'

SELECT TRIM('text then five spaces     after space') AS TrimmedString;

'72 From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. Return productnumber and name.'

select productnumber,name
from production.product
where name like '%M'
or name like '%S'
or name like '%L'

'73 From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row.'

select string_agg(coalesce(firstname,'N/A'),',') as test
from person.person

'74 From the following table write a query in SQL to return the names and modified date separated by commas in a single row.'

select string_agg((firstname||' '|| lastname||' ('||modifieddate)||')',',') as test
from person.person 

'75 From the following table write a query in SQL to find the email addresses of employees and groups them by city. Return top ten rows.'

select city,string_agg(emailaddress,':') as emails
from person.emailaddress p
join Person.BusinessEntityAddress b
using (businessentityid)
join person.address a
using(addressid)
group by city


'76 From the following table write a query in SQL to create a new job title called "Production Assistant" in place of "Production Supervisor".'

select jobtitle, overlay(jobtitle placing 'Assistant' from 12 for 10) as "New Jobtitle"
from  HumanResources.Employee
where jobtitle like 'Production Supervisor%'

'77 From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales". Return firstname, middlename, lastname and jobtitle column.'

select firstname, middlename, lastname, jobtitle
from person.person
join humanresources.employee
using(businessentityid)
where jobtitle like 'Sales%'

'78 From the following table write a query in SQL to return the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.'

select (upper(lastname)||','||firstname) as name
from person.person

'79 From the following table write a query in SQL to show a resulting expression that is too small to display. 
Return FirstName, LastName, Title, and SickLeaveHours. The SickLeaveHours will be shown as a small expression in text format.'
'Question is not clear check with chatgpt'

'80 From the following table write a query in SQL to retrieve the name of the products. Product, that have 33 as the first two digits of listprice.'

select substring(Name, 1, 30) AS ProductName, ListPrice  
from Production.Product  
where cast(ListPrice AS char(2)) LIKE '33%';


'81 From the following table write a query in SQL to calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT). 
Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.'

select salesytd, commissionpct, cast(round(salesytd/commissionpct,0) as int) as value
from sales.salesperson
where commissionpct != 0

'82 From the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. 
Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID.'

select firstname, lastname, s.businessentityid,salesytd
from sales.salesperson s
join person.person p
using(businessentityid)
where cast(salesytd as char(1)) like '2%'

'83 From the following table write a query in SQL to convert the Name column to a char(16) column. 
Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.'

select cast(name as char(16)),listprice
from production.product
where name like 'Long-Sleeve Logo Jersey%'

'84 From the following table write a SQL query to determine the discount price for the salesorderid 46672. 
Calculate only those orders with discounts of more than.02 percent. Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).'

select productid,unitprice,unitpricediscount,unitprice*unitpricediscount
from sales.salesorderdetail
where unitpricediscount > 0.2

'85 From the following table write a query in SQL to calculate the average vacation hours, and the sum of sick leave hours, that the vice presidents have used.'

select avg(vacationhours), sum(sickleavehours)
from humanresources.employee
where jobtitle like '%Vice President%' a

'86 From the following table write a query in SQL to calculate the average bonus received and the sum of year-to-date sales for each territory.
 Return territoryid, Average bonus, and YTD sales.'

select territoryid,avg(bonus), sum(salesytd)
from sales.salesperson
where territoryid is not null
group by territoryid
order by territoryid

'87 From the following table write a query in SQL to return the average list price of products. Consider the calculation only on unique values.'

select avg(distinct(listprice))
from production.product

'88 From the following table write a query in SQL to return a moving average of yearly sales for each territory. 
Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.'

select territoryid, extract(year from modifieddate),avg(salesytd) as movingavg, sum(salesytd) as cumulativeTotal
from sales.salesperson
where territoryid is not null
group by territoryid,extract(year from modifieddate)
order by extract(year from modifieddate)

'this query you can also use window function, since we need to display businessentityid and salesytd also'

select BusinessEntityID, TerritoryID   
   ,DATE_PART('year',ModifiedDate) AS SalesYear  
   ,cast(SalesYTD as VARCHAR(20)) AS  SalesYTD  
   ,avg(SalesYTD) OVER (partition by TerritoryID order by DATE_PART('year',ModifiedDate)) AS MovingAvg  
   ,sum(SalesYTD) OVER (partition by TerritoryID order by DATE_PART('year',ModifiedDate)) AS CumulativeTotal  
FROM Sales.SalesPerson  
WHERE TerritoryID IS NULL OR TerritoryID < 5  
ORDER BY TerritoryID,SalesYear;

'89 From the following table write a query in SQL to return a moving average of sales, by year, for all sales territories. 
Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.'

'Same as above'

'90 From the following table write a query in SQL to return the number of different titles that employees can hold.'

select count(distinct(jobtitle))
from HumanResources.Employee


'91 From the following table write a query in SQL to find the total number of employees.'

select count(businessentityid)
from HumanResources.Employee

'92 From the following table write a query in SQL to find the average bonus for the salespersons who achieved the sales quota above 25000. 
Return number of salespersons, and average bonus.'

select count(businessentityid),avg(bonus)
from Sales.SalesPerson
where salesquota > 25000

'93 From the following tables wirte a query in SQL to return aggregated values for each department. 
Return name, minimum salary, maximum salary, average salary, and number of employees in each department.'

select d.name,min(rate), max(rate), avg(rate), count(h.businessentityid)
from HumanResources.employeepayhistory e
join HumanResources.employeedepartmenthistory h
using(businessentityid)
join HumanResources.Department d
using(departmentid)
where h.enddate is null
group by d.departmentid
order by d.name

'94 From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.'

select jobtitle, count(businessentityid)
from humanresources.employee
group by jobtitle
having count(businessentityid) > 15

'95 From the following table write a query in SQL to find the number of products that ordered in each of the specified sales orders.'
'Check how to solve this solution written here and given is wrong'

select salesorderid, count(productid)
from sales.salesorderdetail
group by salesorderid
order by count(productid) desc


'96 From the following table write a query in SQL to compute the statistical variance of the sales quota values for each quarter in a calendar year for a sales person. 
Return year, quarter, salesquota and variance of salesquota.'

'work on it later'
select quotadate,salesquota,
case when extract(month from quotadate) <=3 then '1'
when extract(month from quotadate) > 3 and extract(month from quotadate) <= 3 then '2'
when extract(month from quotadate) > 6 and extract(month from quotadate) <= 9 then '3'
else '4'
end as quater
from sales.salespersonquotahistory
where extract(year from quotadate) = 2012a

'97 From the following table write a query in SQL to populate the variance of all unique values as well as all values, including any duplicates values of SalesQuota column.'

'work on it later'

'98 From the following table write a query in SQL to return the total ListPrice and StandardCost of products for each color. 
Products that name starts with \'Mountain\' and ListPrice is more than zero. Return Color, total list price, total standardcode. Sort the result set on color in ascending order.'

select color,sum(listprice),sum(standardcost)
from production.product
where listprice > 0 and name like 'Mountain%' and color is not null
group by color

'99 From the following table write a query in SQL to find the TotalSalesYTD of each SalesQuota. 
Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.'
'check what is grouping in this solution provided'

select salesquota,sum(salesytd) as totalsalesytd
from sales.salesperson
where salesquota is not null
group by salesquota

'100 From the following table write a query in SQL to calculate the sum of the ListPrice and StandardCost for each color. Return color, sum of ListPrice.'

select color,sum(listprice),sum(standardcost)
from production.product
group by color


'learnings: window functions but need to learn how exactly partition works and work on more examples
group by rollup,sets,cube
limit and offset, derived tables
after 50 questions revisit unanswered and doubt questions
regex expressions, date conversions, string postition, length of string, trim, substring, right,coalesce,string_agg,overlay,casting one type to another and its restriction,grouping func'

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

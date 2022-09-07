use onlineretail

---View table---
select  *
from OnlineRetail$

---Delete records having negative quantity ---
delete from OnlineRetail$
where Quantity <= 0

---Total of each Invoice---
select InvoiceNo, InvoiceDate, CustomerID, Country, sum(Quantity*UnitPrice) as Total
from OnlineRetail$
group by InvoiceNo, InvoiceDate, CustomerID, Country

---Quantity of Customers per Country---
select Country, count(CustomerID) as Customers
from OnlineRetail$
group by Country
order by Customers desc

---Monthly Active Customers in UK---
select YEAR(InvoiceDate) Year, month(InvoiceDate) Month, count(distinct(CustomerID)) ActiveCustomers
from OnlineRetail$
where Country = 'United Kingdom'
group by YEAR(InvoiceDate), month(InvoiceDate)
order by YEAR(InvoiceDate), month(InvoiceDate)

---Monthly Order---
select YEAR(InvoiceDate) Year, month(InvoiceDate) Month, count(distinct(InvoiceNo)) Orders, sum(Quantity*UnitPrice) Revenue
from OnlineRetail$
group by YEAR(InvoiceDate), month(InvoiceDate)
order by YEAR(InvoiceDate), month(InvoiceDate)

---Top 10 best seller items---
select TOP 10 StockCode, Description, SUM(Quantity) Quantity
from OnlineRetail$
group by StockCode, Description
order by SUM(Quantity) desc

select Country, StockCode, Sum(Quantity) over (partition by StockCode)
from OnlineRetail$
group by Country, StockCode

-- Creating View to store data for later visualizations---
Create View MonthlyActiveCustomer as
select YEAR(InvoiceDate) Year, month(InvoiceDate) Month, count(distinct(CustomerID)) ActiveCustomers
from OnlineRetail$
where Country = 'United Kingdom'
group by YEAR(InvoiceDate), month(InvoiceDate)


Create View MonthlyOrder as
select YEAR(InvoiceDate) Year, month(InvoiceDate) Month, count(distinct(InvoiceNo)) Orders, sum(Quantity*UnitPrice) Revenue
from OnlineRetail$
group by YEAR(InvoiceDate), month(InvoiceDate)


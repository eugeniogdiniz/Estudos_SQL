----------------------------------------------------------------------------------------
-- Demonstração Interações entre Conjuntos 
----------------------------------------------------------------------------------------
-- CONECTAR NO BD: TSQL2012


-- INTERAÇÕES ENTRE CONJUNTOS


-- UNION
SELECT country, region, city FROM HR.Employees
UNION
SELECT country, region, city FROM Sales.Customers;












-- UNION ALL
SELECT country, region, city FROM HR.Employees
UNION ALL
SELECT country, region, city FROM Sales.Customers;



















-- INTERSECT
SELECT country, region, city FROM HR.Employees
INTERSECT
SELECT country, region, city FROM Sales.Customers;

SELECT country, region, city FROM Sales.Customers
INTERSECT
SELECT country, region, city FROM HR.Employees;



















-- EXCEPT
SELECT country, region, city FROM HR.Employees
EXCEPT
SELECT country, region, city FROM Sales.Customers;

SELECT country, region, city FROM HR.Employees
EXCEPT
SELECT country, region, city FROM Sales.Customers 
ORDER BY city DESC; -- ORDER BY

SELECT country, region, city FROM Sales.Customers
EXCEPT
SELECT country, region, city FROM HR.Employees;






-- TABELAS DERIVADAS

-- ALIASES INTERNOS

SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (
SELECT YEAR(orderdate) AS orderyear, custid 
FROM Sales.Orders) AS derived_year
GROUP BY orderyear;


-- ALIASES EXTERNOS
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (
SELECT YEAR(orderdate), custid
FROM Sales.Orders) AS 
derived_year(orderyear, custid)
GROUP BY orderyear;




















-- PASSAGEM DE VARIÁVEIS
DECLARE @emp_id INT = 9;
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (
SELECT YEAR(orderdate) AS orderyear, custid
FROM Sales.Orders
WHERE empid=@emp_id
) AS derived_year
GROUP BY orderyear;
























-- ANINHAMENTO DE TABELAS DERIVADAS

SELECT orderyear, cust_count
FROM  (
      SELECT  orderyear, COUNT(DISTINCT custid) AS cust_count
      FROM ( 
            SELECT YEAR(orderdate) AS orderyear,custid
            FROM Sales.Orders
            ) AS derived_table_1
GROUP BY orderyear
      ) AS derived_table_2
WHERE cust_count > 80;






-- APPLY

-- CROSS APPLY

SELECT * FROMProduction.Products ORDER BY supplierid
SELECT * FROMProduction.Suppliers

SELECTS.supplierid, S.companyname
, P.productid, P.productname, P.unitprice
FROMProduction.Suppliers AS S OUTER APPLY (
select productid, productname, unitprice
from Production.Products 
where supplierid = S.supplierid
) AS P







-- CTE
WITHTopVendasVeiculo (idVeiculo, SomaQtd) AS
( 
SELECT idVeiculo, sum(qtd)
FROM Concessionaria.dbo.VendasAnuais 
GROUP BY idVeiculo
)

SELECT top 10 * FROM TopVendasVeiculo ORDER BY SomaQtd DESC











-- CTE
WITH MinFreight AS
(
SELECT empid, min(freight) as [Lower]  
FROM Sales.Orders 
GROUP BY empid
)
, MaxFreight AS
(
SELECT empid, max(freight) as [Higher]  
FROM Sales.Orders 
GROUP BY empid
)

SELECTempid as 'Número do Empregado', [Lower] as 'Menores e Maiores Fretes' FROM MinFreight
UNION ALL
SELECT empid, [Higher] FROM MaxFreight
ORDER BY empid, 'Menores e Maiores Fretes'























-- CTE
WITHTopVendasVeiculo (idVeiculo, SomaQtd) AS
( 
SELECT idVeiculo, sum(qtd)
FROM Concessionaria.dbo.VendasAnuais 
GROUP BY idVeiculo
)

SELECTtop 10 * FROM TopVendasVeiculo 
ORDER BYSomaQtd DESC




use TSQL2012
go

-- CTE
WITH TopSales (SalesPersonID, NumSales) AS
(SELECT empid, Count(*) 
 FROM Sales.Orders GROUP BY empid)

SELECTfirstname, lastname, NumSales
FROMHR.Employees e INNER JOIN TopSales ON TopSales.SalesPersonID = e.empid
ORDER BY NumSales DESC
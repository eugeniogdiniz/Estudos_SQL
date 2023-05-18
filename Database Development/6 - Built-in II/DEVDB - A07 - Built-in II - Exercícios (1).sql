

-- 1. Na tabela Sales.Customers, liste as respectivas colunas com os cabe�alhos N�mero do Cliente
--    , Nome do Cliente e N�mero do Fax. Nesta �ltima coluna, atrav�s da fun��o ISNULL, colocar o 
--   fax quando houver valor e �SEM FAX� se inexistirem valores.
select * from Sales.Customers

select	Custid as 'N�mero do Cliente'
		, contactName as 'Nome do Cliente'
		, isnull(fax, 'Sem Fax') as  'N�mero do Fax'
from	Sales.Customers

-- 2 Na tabela Production.Products, construa uma query que traga cabe�alhos o N�mero do Produto
--	 , Nome do Produto. Com o comando IIF, adicione uma coluna chamada Estado do Produto colocando 
--   o texto �Descontinuado� ou �Em Produ��o� caso a coluna Discontinued seja 1 ou 0 respectivamente�.
select * from Production.Products

select	productid as 'N�mero do Produto'
		, productName as 'Nome do Produto' 
		, iif(Discontinued = 1, 'Descontinuado', 'Em Produ��o') as 'Estado do Produto'
from	Production.Products


-- 3. Fa�a uma c�pia da tabela Production.Products, com qualquer outro nome e adicione a estrutura 
--    desta nova tabela, as colunas F�SICAS referentes aos nomes abaixo 
--    (coloque nomes diferentes dos que est�o na COLUNA): 

-- Coluna: stockLevel - Num�rica inteira at� 5.000 unidades
-- Coluna: goalPrice - Duas casas decimais e inteiro que suporte at� 10.000
-- drop table Tempdb.dbo.MyProducts
select * into Tempdb.dbo.MyProducts from Production.Products

alter table Tempdb.dbo.MyProducts add stkLevel smallint, gPrice decimal(9,2)


-- 4. Construa um loop que percorra registro a registro e atualize as colunas criadas da seguinte forma:

-- StockLevel: Gere um n�mero aleat�rio, multiplicado por 1.000 e pegue apenas a parte inteira
select ceiling(rand() * 1000)


declare @productId tinyint = 0

while exists(select * from Tempdb.dbo.MyProducts where productId > @productId)
begin
	select	@productId = min(productId) from Tempdb.dbo.MyProducts where productId > @productId
	update	Tempdb.dbo.MyProducts 
	set		stkLevel = ceiling(rand() * 1000)
			, gPrice = case
							when abs(@productId - unitprice) > 20 then unitprice
							when abs(@productId - unitprice) > 10 then unitprice + ((@productId - unitprice) / 10) 
							when abs(@productId - unitprice) > 0 then unitprice + (@productId - unitprice) 
							else unitprice
						end 
	where	productId = @productId
end

select * from Tempdb.dbo.MyProducts

-- 5. Baseada na query do exerc�cio 2, adicione uma nova coluna de qualquer nome referente a 
-- N�vel de Estoque (um case de simples express�o sob o campo StockLevel, que atenda ao quadro abaixo):
select	productid as 'N�mero do Produto'
		, productName as 'Nome do Produto' 
		, iif(Discontinued = 1, 'Descontinuado', 'Em Produ��o') as 'Estado do Produto'
		, stkLevel as 'Qtd. Estoque'
		, case 
			when stkLevel <= 100 then 'Muito Baixo'
			when stkLevel <= 300 then 'Baixo'
			when stkLevel <= 400 then 'M�dio'
			when stkLevel <= 500 then 'Normal'
			when stkLevel <= 700 then 'Alto'
			when stkLevel > 700 then 'Muito Alto'
		end as 'Nvl. Estoque'
from	Tempdb.dbo.MyProducts



-- 6. Com um case de express�o de procura, adicione a query anterior  uma coluna referente a Faixa de Pre�o
--    , de forma que atenda ao seguinte quadro:
select	productid as 'N�mero do Produto'
		, productName as 'Nome do Produto' 
		, iif(Discontinued = 1, 'Descontinuado', 'Em Produ��o') as 'Estado do Produto'
		, stkLevel as 'Qtd. Estoque'
		, case 
			when stkLevel <= 100 then 'Muito Baixo'
			when stkLevel <= 300 then 'Baixo'
			when stkLevel <= 400 then 'M�dio'
			when stkLevel <= 500 then 'Normal'
			when stkLevel <= 700 then 'Alto'
			when stkLevel > 700 then 'Muito Alto'
		end as 'Nvl. Estoque'
		, unitprice as 'Pre�o'
		, case 
			when unitprice between 0 and 9.99 then 'Faixa de R$ 0,00 a R$ 9,99'
			when unitprice between 10 and 19.99 then 'Faixa de R$ 10,00 a R$ 19,99'
			when unitprice between 20 and 29.99 then 'Faixa de R$ 20,00 a R$ 29,99'
			when unitprice between 30 and 39.99 then 'Faixa de R$ 30,00 a R$ 39,99'
			when unitprice between 40 and 49.99 then 'Faixa de R$ 40,00 a R$ 49,99'
			when unitprice > 50 then 'Faixa acima de R$ 50,00'
		end as 'Fx. Pre�o'
from	Tempdb.dbo.MyProducts


-- 7. Apenas com comando  CHOOSE, adicione a query anterior uma coluna referente a  Categoria do Produto
--    , conforme quadro abaixo
select	productid as 'N�mero do Produto'
		, productName as 'Nome do Produto' 
		, iif(Discontinued = 1, 'Descontinuado', 'Em Produ��o') as 'Estado do Produto'
		, stkLevel as 'Qtd. Estoque'
		, case 
			when stkLevel <= 100 then 'Muito Baixo'
			when stkLevel <= 300 then 'Baixo'
			when stkLevel <= 400 then 'M�dio'
			when stkLevel <= 500 then 'Normal'
			when stkLevel <= 700 then 'Alto'
			when stkLevel > 700 then 'Muito Alto'
		end as 'Nvl. Estoque'
		, unitprice as 'Pre�o'
		, case 
			when unitprice between 0 and 9.99 then 'Faixa de R$ 0,00 a R$ 9,99'
			when unitprice between 10 and 19.99 then 'Faixa de R$ 10,00 a R$ 19,99'
			when unitprice between 20 and 29.99 then 'Faixa de R$ 20,00 a R$ 29,99'
			when unitprice between 30 and 39.99 then 'Faixa de R$ 30,00 a R$ 39,99'
			when unitprice between 40 and 49.99 then 'Faixa de R$ 40,00 a R$ 49,99'
			when unitprice > 50 then 'Faixa acima de R$ 50,00'
		end as 'Fx. Pre�o'
		, categoryId as 'Num. Categoria'
		, choose(categoryId, 'Beverages', 'Condiments', 'Confections', 'Dairy Products', 'Grains/Cereals', 'Meat/Poultry', 'Produce', 'Seafood') as 'Ctg. Produto'
from	Tempdb.dbo.MyProducts


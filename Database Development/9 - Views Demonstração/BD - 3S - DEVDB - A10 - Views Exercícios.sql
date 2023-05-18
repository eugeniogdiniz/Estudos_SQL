
-- 1. Crie a view vwVeiculo que traga distintamente todas as descrições dos veículos, com seus respectivos modelos e nomes dos fabricantes.
create view vwVeiculo
as 
select	distinct F.nome as 'Fabricante'
		, V.descricao as 'Veiculo'
		, M.descricao as 'Modelo'
from	Veiculo as V	inner join Modelo as M on V.idModelo = M.idModelo
						inner join Fabricante as F on F.idFabricante = V.idFabricante
go

select * from vwVeiculo


-- 2. Crie um CTE que retire da view os Fabricantes Honda e Yamaha. Lista o CTE, ordenando pelo Fabricante, Veiculo e Modelo.
with	cte as
		(
		select * from vwVeiculo where Fabricante not in ('Honda', 'Yamaha')
		)

select * from cte order by Fabricante, Veiculo, Modelo


-- 3. Utilizando a view, Contabilize pelo o Fabricante a quantidade de Veiculos produzidos.
select fabricante, count(*) as Quantidade from vwVeiculo group by fabricante

-- 4. Utilizando a view, Contabilize pelo fabricante e veiculo, a quantidade de modelos produzidos.
select fabricante, veiculo, count(*) as Quantidade from vwVeiculo group by fabricante, veiculo

-- 5. Com a query anterior, liste apenas os Veículos com mais de 1 modelo produzido.
select fabricante, veiculo, count(*) as Quantidade from vwVeiculo group by fabricante, veiculo having count(*) > 1

-- 6. Utilizando operadores de interação de conjuntos liste todas as Vendas (2013, 2014, 2015) 
--    contendo as informações referentes aos clientes (Nome, Sexo, dtNascimento) e veículo (descrição). Verifique se a quantidade obtida de registros é a mesma que 
--    o número de registros de cada tabela individualmente.

select * from Vendas2013 -- 80
select * from Vendas2014 -- 120
select * from Vendas2015 -- 100

select	nome, sexo, dtNascimento, descricao as 'Veiculo' 
from	Vendas2013 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
union
select	nome, sexo, dtNascimento, descricao as 'Veiculo' 
from	Vendas2014 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
union
select	nome, sexo, dtNascimento, descricao as 'Veiculo' 
from	Vendas2015 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo


-- 7. Altere a query anterior, obrigando que o número de registros do resultado final seja o mesmo que a quantidade de registros de cada tabela.
select	nome, sexo, dtNascimento, descricao as 'Veiculo' 
from	Vendas2013 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
union all
select	nome, sexo, dtNascimento, descricao as 'Veiculo' 
from	Vendas2014 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
union all
select	nome, sexo, dtNascimento, descricao as 'Veiculo' 
from	Vendas2015 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo

-- 8. Utilizando operadores de interação de conjuntos, traga os nomes dos clientes que compraram veículos em 2013 e também compraram em 2014.
select	nome
from	Vendas2013 as V inner join Cliente as C on V.idCliente = C.idCliente
intersect
select	nome
from	Vendas2014 as V inner join Cliente as C on V.idCliente = C.idCliente
-- 36

-- 9. Traga os nomes dos clientes que compraram em 2015 e não compraram em 2013.
select	nome
from	Vendas2015 as V inner join Cliente as C on V.idCliente = C.idCliente
except
select	nome
from	Vendas2013 as V inner join Cliente as C on V.idCliente = C.idCliente
-- 7

-- 10. Crie uma view particionada que represente todas as Vendas para Clientes, com informações do nome do cliente, Fabricante, descrição do veículo, descrição do modelo e nome do fabricante.
create view vwVendasClientes
as
select	C.nome as 'Cliente'
		, F.nome as 'Fabricante' 
		, L.descricao as 'Veiculo' 
		, m.descricao as 'Modelo' 
from	Vendas2013 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
						inner join Modelo as M on L.idModelo = M.idModelo
						inner join Fabricante as F on F.idFabricante = L.idFabricante
union all 
select	C.nome as 'Cliente'
		, F.nome as 'Fabricante' 
		, L.descricao as 'Veiculo' 
		, m.descricao as 'Modelo' 
from	Vendas2014 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
						inner join Modelo as M on L.idModelo = M.idModelo
						inner join Fabricante as F on F.idFabricante = L.idFabricante
union all
select	C.nome as 'Cliente'
		, F.nome as 'Fabricante' 
		, L.descricao as 'Veiculo' 
		, m.descricao as 'Modelo' 
from	Vendas2015 as V inner join Cliente as C on V.idCliente = C.idCliente
						inner join Veiculo as L on V.idVeiculo = L.idVeiculo
						inner join Modelo as M on L.idModelo = M.idModelo
						inner join Fabricante as F on F.idFabricante = L.idFabricante







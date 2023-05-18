use Concessionaria
go

-- 1. Crie uma CTE chamada QtdVendas, com a Descricao do Veiculo, Fabricante, Ano da Venda e as Quantidades de Vendas Anuais. 
--    Chame a CTE apenas para o período de 2001 a 2008.

with	QtdVendas as
		(
		select	V.descricao as Veiculo
				, F.nome as Fabricante
				, A.ano as 'Ano da Venda'
				, sum(VA.qtd) as 'Quantidade de Vendas Anuais'
		from	VendasAnuais as VA	inner join Veiculo as V on VA.idVeiculo = V.idVeiculo
									inner join Ano as A on A.idAno = VA.idAnodaVenda
									inner join Fabricante as F on V.idFabricante = F.idFabricante
		group by	V.descricao
					, F.nome
					, A.ano
		) 

select * from QtdVendas where [Ano da Venda] between 2001 and 2008


-- 2. Com a mesma CTE anterior, chame o objeto somando as quantidades pelo agrupamento por fabricantes e ano, 
--    apenas para os anos ímpares acima de 2002 e menor que 2014.
with	QtdVendas as
		(
		select	V.descricao as Veiculo
				, F.nome as Fabricante
				, A.ano as 'Ano da Venda'
				, sum(VA.qtd) as 'Quantidade de Vendas Anuais'
		from	VendasAnuais as VA	inner join Veiculo as V on VA.idVeiculo = V.idVeiculo
									inner join Ano as A on A.idAno = VA.idAnodaVenda
									inner join Fabricante as F on V.idFabricante = F.idFabricante
		group by	V.descricao
					, F.nome
					, A.ano
		) 

select	Fabricante
		, [Ano da Venda]
		, sum([Quantidade de Vendas Anuais]) as 'Quantidade de Vendas Anuais' 
from	QtdVendas 
where	([Ano da Venda] % 2 = 1)
		and ([Ano da Venda] > 2002 and [Ano da Venda] < 2014)
group by Fabricante, [Ano da Venda]
order by Fabricante, [Ano da Venda]


-- 3. Gere duas CTEs, apenas com a qtd das vendas anuais. A CTE chamada QTD900 terá apenas as quantidades maiores que 900. 
--    A CTE QTD850a950 terá quantidades entre 850 e 950. Gere o UNION e UNION ALL entre as duas CTEs criadas (um por vez) e 
--    veja as diferenças entre os resultados.
with	QTD900 as
		(
		select qtd from VendasAnuais where qtd > 900 -- 150
		)
		, QTD850a950 as

		(
		select qtd from VendasAnuais where qtd between 850 and 950 -- 132
		)

select * from QTD900
-- union -- 109  
union all -- 282
select * from QTD850a950 



-- 4. Como você explicaria essas diferenças ?

-- R:	O processo do UNION elimina registros duplicados e ordena as quantidades podendo gerar quantidade de registros inferiores a 
--		soma do número de registros de cada conjunto. Já o UNION ALL aplica meramente a união entre os dois conjuntos, gerando 
--      o número de registros EXATAMENTE igual a soma dos registros de cada conjunto.


-- 5. Sem construir os respectivos SELECTs imagine um conjunto de dados A com todos os registros da Tabela Veiculo que possuam 
--    valores estejam entre R$ 5.000,00 e R$ 10.000,00. Agora imagine um conjunto de dados B com todos os registros da Tabela 
--	  Veiculo que possuam valores estejam entre R$ 8.000,00 e R$ 12.000,00. Quais os valores possíveis em reais dos preços dos 
--	  veículos realizando INTERSECT entre A e B ? Quais os valores possíveis para um EXCEPT entre A e B ?

-- R:	INTERSECT: entre 8000 e 10000
--		EXCEPT: entre 5000 e inferior a 8000



-- 6. Construa os SELECTs do Exercício 5 e valide suas respostas
select * from veiculo where valor between 5000 and 10000
-- intersect 
except
select * from veiculo where valor between 8000 and 12000




-----------------------------------------------------------------------------------------------
-- EXERCÍCIOS - Subqueries e Tabelas Temporárias
-----------------------------------------------------------------------------------------------
/*
Utilizando SUBQUERIES e conceitos desta aula, escrever os seguintes Scripts:

1. Listar as Vendas Anuais onde o valor do Veiculo seja o valor R$ 28.011,00 (autosuficiente)
2. Listar os Fabricantes que somaram quantidade de vendas anuais acima de  7.500 (correlacionada).
3. Traga as descrições dos veículos e valores distintos que existam (EXISTS) o modelo STD.
4. Traga as descrições dos veículos distintos que NÃO existam (NOT EXISTS) os modelos R, STD e GTR.
5. Crie uma tabela temporária LOCAL com o nome, endereço e contato dos Fabricantes do sudeste. Teste o acesso em outra conexão.
6. Crie uma tabela temporária GLOBAL com a descrição e valor dos veículos onde o Fabricante seja Honda. Teste o acesso em outra conexão.
*/


-- 1. Listar as Vendas Anuais onde o valor do Veiculo seja o valor R$ 28.011,00 (autosuficiente)
select * from Veiculo order by valor desc

-- Via Subquery autosuficiente
Select 	*
From  	VendasAnuais 
Where 	idVeiculo = (
					select	idVeiculo
					from	Veiculo
					where	valor = 28011.00
					)
-- Via Join
Select 	VA.*
From  	VendasAnuais VA	inner join Veiculo V on V.idVeiculo = VA.idVeiculo
where 	V.valor = 28011.00




-- 2. Listar os Fabricantes que tiveram algum veículo com soma da quantidade de vendas anuais acima de 7.500 (correlacionada).
select * from Fabricante
select * from Veiculo 
select * from VendasAnuais

-- Veículos com Vendas acima de 7.500
select  idVeiculo, sum(qtd) as Soma
from    VendasAnuais 
group by idVeiculo
having sum(qtd) >= 7500

-- CTE para encontrar os Fabricantes
with    Maior7500 as
        (
        select  idVeiculo, sum(qtd) as Soma
        from    VendasAnuais 
        group by idVeiculo
        having sum(qtd) >= 7500
        )

select  distinct F.* -- V.idVeiculo, V.descricao, M.Soma, F.nome
from    Veiculo as V    inner join Maior7500 as M on V.idVeiculo = M.idVeiculo
                        inner join Fabricante as F on V.idFabricante = F.idFabricante
order by F.nome


-- Subquery Correlacionada
select 	*
from  	Fabricante as F
where	exists  (
                select  *
				from    Veiculo as V
                where   V.idFabricante = F.idFabricante
                        and exists  (
                                    select  *
                                    from    VendasAnuais as VA
                                    where   VA.idVeiculo = V.idVeiculo
                                    group by VA.idVeiculo
                                    having sum(qtd) >= 7500
                                    )
				)
order by F.Nome





-- 3. Traga as descrições dos veículos e valores distintos que existam (EXISTS) o modelo STD.
select * from Modelo
select * from Veiculo where idModelo = 1

Select 	distinct descricao, idModelo, valor
From  	Veiculo
Where 	exists	(
				select 	*
				from 	Modelo
				where 	Descricao = 'GS'
						and Modelo.idModelo = Veiculo.idModelo
				)

-- 4. Traga as descrições dos veículos distintos que NÃO existam (NOT EXISTS) os modelos R, STD e GTR.
select * from Modelo
select distinct descricao from Veiculo where idModelo not in (2, 7, 5)

Select 	distinct descricao
From  	Veiculo
Where 	NOT EXISTS	(
					select 	*
					from 	Modelo
					where 	Descricao IN ('R', 'STD', 'GTR')
						    and Modelo.idModelo = Veiculo.idModelo
					)

-- 5. Crie uma tabela temporária LOCAL com o nome, endereço e contato dos Fabricantes do sudeste. Teste o acesso em outra conexão.
select * from fabricante

Select 	nome, endereco, contato
Into 	#tempLocal
From  	Fabricante
Where 	uf in ('SP', 'RJ', 'MG', 'ES')

select * from #tempLocal


-- 6. Crie uma tabela temporária GLOBAL com a descrição e valor dos veículos onde o Fabricante seja Honda. Teste o acesso em outra conexão.
Select 	descricao, valor
Into 	##tempGlobal
From  	Veiculo
Where 	idFabricante =	(
						select idFabricante from Fabricante 
						where nome = 'Honda'
						)

select * from ##tempGlobal




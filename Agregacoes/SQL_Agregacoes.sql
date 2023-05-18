USE Concessionaria 


/*ATIVIDADE CONTINUA 5 */

-- 1 Qual o n�mero de registros existentes na tabela VendasAnuais ?

SELECT COUNT(*) AS REGISTROS
FROM VendasAnuais


--2 Qual o acumulado da quantidade de vendas Totais at� o momento ?

SELECT * FROM VendasAnuais
SELECT SUM(qtd) AS ACUMULADO
FROM VendasAnuais


--3 Quais as quantidades de vendas Totais at� o momento para: menor venda, m�dia de
--vendas e a maior venda?

SELECT * FROM VendasAnuais order by qtd asc


SELECT		 AVG(qtd) "Media venda", min(qtd) "menor venda", max(qtd)"maior venda"
FROM		VendasAnuais

--4 Extraia a soma das vendas anuais por ano em ordem descendente.

SELECT idAnodaVenda, SUM(qtd) AS ACUMULADO
FROM VendasAnuais
GROUP BY idAnodaVenda
ORDER BY  ACUMULADO DESC

--5 Traga a soma das vendas anuais para o ve�culo/modelo CG 125 STD (as informa��es do
--ve�culo devem constar na query).

SELECT * FROM VendasAnuais
SELECT * FROM Veiculo

SELECT 
VEI.descricao, MODE.descricao, VED.idVeiculo,
SUM(VED.qtd) AS ACUMULADO
FROM VendasAnuais VED
INNER JOIN Veiculo VEI ON VED.idVeiculo = VEI.idVeiculo
INNER JOIN MODELO MODE ON MODE.idModelo = MODE.idModelo
WHERE VEI.descricao = 'CG 125' AND MODE.descricao = 'STD'
GROUP BY VEI.descricao, MODE.descricao, VED.idVeiculo


--6 Traga as primeiras datas (ANOS) de FABRICA��O de todos os ve�culos e modelos,
--ordenados pelo nome do fabricante (ascendente), ano (descendente), Ve�culo
--(ascendente) e Modelo (descendente) Toda as informa��es solicitadas, inclusive
--ordena��o, devem constar na query.


SELECT		DISTINCT
			FAB.Nome		AS NOME_FABRICANTE,
			MIN(ANO.ANO)	AS ANO,
			VEI.descricao	AS DESCRI��O_VEICULO,
			MODE.descricao	AS MODELO
FROM		VendasAnuais VED
INNER JOIN	Veiculo VEI		ON VED.idVeiculo = VEI.idVeiculo
INNER JOIN	MODELO MODE		ON MODE.idModelo = MODE.idModelo
INNER JOIN	Fabricante FAB	ON FAB.idFabricante = VEI.idFabricante
INNER JOIN	ANO ANO			ON VEI.idAnoFabricacao = ANO.idAno
GROUP BY	FAB.Nome, VEI.descricao, MODE.descricao
ORDER BY	FAB.Nome ASC, ANO DESC, VEI.descricao ASC, MODE.descricao DESC



--7 Extraia a menor, maior, m�dia e a soma das vendas de cada m�s do ano de 2000, em
--ordem ascendente.


SELECT		
     min(qtd) as Minimo,
	 max(qtd) as Maxima,
	 sum(qtd) as soma,
	 avg(qtd) as Media,
	 ano as Ano,
	 Mes as Mes
FROM		VendasAnuais VED
INNER JOIN	Veiculo VEI		ON VED.idVeiculo = VEI.idVeiculo
INNER JOIN	MODELO MODE		ON MODE.idModelo = MODE.idModelo
INNER JOIN	Fabricante FAB	ON FAB.idFabricante = VEI.idFabricante
INNER JOIN	ANO ANO			ON VEI.idAnoFabricacao = ANO.idAno 
INNER JOIN  MES MS          ON VED.idMesdaVenda = MS.idMes
WHERE		ANO = '2000'
GROUP BY	Mes, Ano

--8 Retorne a mesma consulta anterior, mas somente os registros que tiverem m�dia de
--vendas superior a 500.

SELECT		
     min(qtd) as MENOR_VENDA,
	 max(qtd) as MAXIMA_VENDA,
	 sum(qtd) as SOMA_TATAL,
	 avg(qtd) as MEDIA,
	 ano as Ano,
	 Mes as Mes
FROM		VendasAnuais VED
INNER JOIN	Veiculo VEI		ON VED.idVeiculo = VEI.idVeiculo
INNER JOIN	MODELO MODE		ON MODE.idModelo = MODE.idModelo
INNER JOIN	Fabricante FAB	ON FAB.idFabricante = VEI.idFabricante
INNER JOIN	ANO ANO			ON VEI.idAnoFabricacao = ANO.idAno 
INNER JOIN  MES MS          ON VED.idMesdaVenda = MS.idMes
--WHERE ANO = '2000'
GROUP BY	Mes, ANO
HAVING AVG(QTD) >= 500
ORDER BY	ANO ASC
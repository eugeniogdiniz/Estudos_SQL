/*----------------------------------------------------------------------------------------------------------------------------------

AC01 BD2AN
EUGÊNIO LENINE GUEIROS DINIZ

Criar a seguinte estrutura em Código SQL, considerando as premissas:
1. Livre utilização dos Tipos de Dados;
2. Respeite os tamanhos e formatos adequados para cada Campo;
3. Os relacionamentos devem possuir mesmo Tipo de Dado;
4. Crie as Primary e Foreign Key conforme o Modelo;
5. Campo CODFUN da Tabela de Empregados é de Auto Numeração;
6. Campo COD_DEPTO da Tabela de Departamentos é de Auto Numeração;
7. Campo COD_CARGO da Tabela de Cargos é de Auto Numeração;
8. Campos NOME (Tabelas Empregados e Dependentes), variáveis, contendo 50 bytes;
9. Campos SALARIO, SALARIO_INIC e PREMIO_MENSAL são Monetários;
10. Apenas os campos OBS, FOTO E COD_SUPERVISOR aceitam NULOS;

----------------------------------------------------------------------------------------------------------------------------------*/

CREATE DATABASE DB_EMPRESAS
GO

USE DB_EMPRESAS
GO

CREATE TABLE TB_DEPARTAMENTO
(
				COD_DEPTO						BIGINT								IDENTITY(1,1)	
			,	DEPTO								VARCHAR(30)						NOT NULL

				CONSTRAINT		PK_DEPARTAMENTO_COD_DEPTO		PRIMARY KEY	(COD_DEPTO)

)

INSERT TB_DEPARTAMENTO
(	DEPTO	)

VALUES
(	'RELATÓRIO OPERACIONAL'	),
(	'RELATÓRIO GERENCIAL'	),
(	'PED'	),
(	'TRANSPORTES'	),
(	'DIRETORIA'	)

SELECT * FROM TB_DEPARTAMENTO


CREATE TABLE TB_CARGO
(
				COD_CARGO						BIGINT										IDENTITY(1,1)
			,	CARGO								VARCHAR(30)						NOT NULL
			,	SALARIO								MONEY								NOT NULL

				CONSTRAINT		PK_CARGO_COD_CARGO		PRIMARY KEY	(COD_CARGO)

)

INSERT TB_CARGO
(	CARGO		,		SALARIO			)

VALUES
(	'AUXILIAR DE PESQUISA'		,									1500	),
(	'AUXILIAR DE GERENCIAMENTO'		,					2000	),
(	'ANALISTA SÊNIOR'		,											2500	),
(	'DIRETOR'			,														3000	),
(	'ESTAGIARIO'			,													4500	)

SELECT * FROM TB_CARGO


CREATE TABLE TB_EMPREGADO
(
				CODFUN								BIGINT								IDENTITY(1,1)					NOT NULL
			,	NOME									CHAR(50)							NOT NULL
			,	NUM_DEPEND					INT										NOT NULL
			,	DATA_NASCIMENTO			DATE									NOT NULL
			,	COD_DEPTO						BIGINT								NOT NULL
			,	COD_CARGO						BIGINT								NOT NULL
			,	DATA_ADMISSAO				DATE									NOT NULL
			,	SALARIO								MONEY								NOT NULL
			,	PREMIO_MENSAL				MONEY								NOT NULL
			,	SINDICALIZADO					VARCHAR(3)						NOT NULL
			,	OBS										VARCHAR(500)
			,	FOTO									IMAGE
			,	COD_SUPERVISOR			INT
			

				CONSTRAINT		PK_EMPREGADO_COD_FUN					PRIMARY KEY	(CODFUN)
			,	CONSTRAINT		FK_EMPREGADO_COD_DEPTO				FOREIGN KEY	(COD_DEPTO)			REFERENCES TB_DEPARTAMENTO(COD_DEPTO)
			,	CONSTRAINT		FK_EMPREGADO_COD_CARGO				FOREIGN KEY	(COD_CARGO)			REFERENCES TB_CARGO(COD_CARGO)

)

DROP TABLE TB_EMPREGADO

INSERT TB_EMPREGADO
(	NOME,		NUM_DEPEND, DATA_NASCIMENTO , COD_DEPTO, COD_CARGO, DATA_ADMISSAO,	SALARIO,	PREMIO_MENSAL	,	SINDICALIZADO)
VALUES
(	'EUGENIO',		1	,	'1999-10-27',	1		,	1	,	'2011-05-09',	1500	,	100		,	'SIM'),
(	'JOÃO',			2	,	'1958-05-09',	2		,	2	,	'2021-01-01',	2000	,	50		,	'SIM'),
(	'PEDRO',			3	,	'2002-06-15',	3		,	3	,	'2021-01-01',	54800	,	1000	,	'SIM'),
(	'THIAGO',		4	,	'1998-08-08',	4		,	4	,	'2021-01-01',	10000	,	600		,	'SIM'),
(	'ELISABETE',	5	,	'2000-09-30',	5		,	5	,	'2021-01-01',	1000	,	10		,	'SIM')

SELECT * FROM TB_EMPREGADO

CREATE TABLE TB_DEPENDENTE
(
				COD_FUN								BIGINT								NOT NULL
			,	CODDEP									BIGINT								NOT NULL
			,	NOME										CHAR(50)							NOT NULL
			,	DATA_NASCIMENTO				DATE									NOT NULL

			,	CONSTRAINT		PK_DEPEND_COD_DEP				PRIMARY KEY	(CODDEP)
			,	CONSTRAINT		FK_DEPEND_COD_FUN				FOREIGN KEY	(COD_FUN)			REFERENCES TB_EMPREGADO(CODFUN)

)

INSERT TB_DEPENDENTE
(	COD_FUN		 ,		CODDEP		,		NOME		,	DATA_NASCIMENTO	)

VALUES
(	1,		1001		,		'MARX EUGENIO'					,		'2008-01-11'	),
(	2,		1002		,		'LUCAS SALLES'					,		'1998-09-30'	),
(	3,		1003		,		'THIAGO FELIX'					,		'1985-01-29'	),
(	4,		1004		,		'RICARDO GOMES'				,		'1999-10-20'	),
(	5,		1005		,		'RODOLFO AMARANTE'		,		'2015-09-13'	)

SELECT * FROM TB_DEPENDENTE

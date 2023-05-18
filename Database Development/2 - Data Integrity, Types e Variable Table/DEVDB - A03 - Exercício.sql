----------------------------------------------------------------------------------------------------------------------------
-- Exerc�cio
----------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- 1. Elaborar tabela vari�vel table para uma tabela de cliente que armazene as seguintes colunas:

--    nroCliente (100 clientes, num�rico, gera��o autom�tica, pk)
--    nome (character at� 60)
--    dataNascimento (data, dom�nio: 18 a 50 anos)
--    cpf (caracter fixo de 11, obrigat�rio os 11 d�gitos, entre 0 e 9)  
--    sexo (dom�nio: Masculino ou Feminino)
--    estadoCivil (dom�nio: Solteiro (a), Casado (a) , Divorciado (a) , Vi�vo (a) � Padr�o Solteiro (a))
--    nroFilhos (dom�nio: 0 a 20 � Padr�o 0)

-- Nota: Os dom�nios dever�o ter as restri��es mencionadas assim como os padr�es sugeridos.
----------------------------------------------------------------------------------------------------------------------------
declare @tbCliente table 
(
	nroCliente tinyint identity(1,1) primary key,
	nome varchar(60),
	dataNascimento date check (datediff(year, dataNascimento, getdate()) between 18 and 50),
	cpf char(11) not null check (cpf like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	sexo varchar(9) check (sexo in ('Masculino', 'Feminino')),
	estadoCivil varchar(14) check (estadoCivil in ('Solteiro (a)', 'Casado (a)', 'Divorciado (a)', 'Vi�vo (a)')) default 'Solteiro (a)',
	nroFilhos tinyint check (nroFilhos between 0 and 20) default 0 
);
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- 3. Experimentar inser��o com dados fora do dom�nio 
----------------------------------------------------------------------------------------------------------------------------
--insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
--values	('Amadeu Abrantes', '20070101', '83365982271', 'Masculino', 'Solteiro (a)', 0)

--insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
--values	('Juliana Batista', cast(dateadd(year,-36, getdate()) as date), 'A0303777258', 'Feminino', 'Casado (a)', 2)

--insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
--values	('S�rgio Silva', cast(dateadd(year,-47, getdate()) as date),'28813550420', 'Sei n�o', 'Vi�vo (a)', 4)
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- 3. Popular os nomes abaixo: 

--    Amadeu Abrantes (21 anos, 0 filhos)
--    Juliana Batista (36 anos, 2 filhos)
--    S�rgio Silva (47 anos, 4 filhos)

-- Listar (select) a vari�vel table 
----------------------------------------------------------------------------------------------------------------------------
insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
values	('Amadeu Abrantes', '19970101', '83365982271', 'Masculino', 'Solteiro (a)', 0)
		, ('Juliana Batista', cast(dateadd(year,-36, getdate()) as date), '00303777258', 'Feminino', 'Casado (a)', 2)
		, ('S�rgio Silva', cast(dateadd(year,-47, getdate()) as date),'28813550420', 'Masculino', 'Vi�vo (a)', 4)

--select * from @tbCliente
----------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------------------
-- 4. Retornar as seguintes informa��es

--    1a. coluna: Label: Sobrenome, Nome 
--    2a. coluna: Label: Idade (c�lculo aproximado utilizando datediff)
--    3a. coluna: Label: CPF (colocar no formato 999.999.999-99)
--    4a. coluna: Label: G�nero (masculino/feminino)
--    5a. coluna: Label: Estado Civil ( Solteiro (a), Casado (a) , Divorciado (a) , Vi�vo (a) )
--    6a. coluna: Label: Filhos ( 0 a 20 filhos )
----------------------------------------------------------------------------------------------------------------------------
select	substring(nome, charindex(' ', nome) + 1, len(nome) - charindex(' ', nome)) 
                    + ', ' 
					+ left(nome, charindex(' ', nome) - 1) as [Sobrenome, Nome] 
		, datediff(year, dataNascimento, getdate()) as Idade
		, substring(cpf, 1, 3) + '.' + substring(cpf, 4, 3) + '.' + substring(cpf, 7, 3) + '-' + substring(cpf, 10, 2) as CPF 
		, sexo as 'G�nero'
		, estadoCivil as [Estado Civil]
		, nroFilhos as Filhos
from	@tbCliente
----------------------------------------------------------------------------------------------------------------------------


-- nome = Amadeu Abrantes
--        123456789012345

-- charindex(' ', nome) = 7
-- len(nome) = 15
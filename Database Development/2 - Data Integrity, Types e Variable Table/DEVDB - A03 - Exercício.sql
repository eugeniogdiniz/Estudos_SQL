----------------------------------------------------------------------------------------------------------------------------
-- Exercício
----------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- 1. Elaborar tabela variável table para uma tabela de cliente que armazene as seguintes colunas:

--    nroCliente (100 clientes, numérico, geração automática, pk)
--    nome (character até 60)
--    dataNascimento (data, domínio: 18 a 50 anos)
--    cpf (caracter fixo de 11, obrigatório os 11 dígitos, entre 0 e 9)  
--    sexo (domínio: Masculino ou Feminino)
--    estadoCivil (domínio: Solteiro (a), Casado (a) , Divorciado (a) , Viúvo (a) – Padrão Solteiro (a))
--    nroFilhos (domínio: 0 a 20 – Padrão 0)

-- Nota: Os domínios deverão ter as restrições mencionadas assim como os padrões sugeridos.
----------------------------------------------------------------------------------------------------------------------------
declare @tbCliente table 
(
	nroCliente tinyint identity(1,1) primary key,
	nome varchar(60),
	dataNascimento date check (datediff(year, dataNascimento, getdate()) between 18 and 50),
	cpf char(11) not null check (cpf like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	sexo varchar(9) check (sexo in ('Masculino', 'Feminino')),
	estadoCivil varchar(14) check (estadoCivil in ('Solteiro (a)', 'Casado (a)', 'Divorciado (a)', 'Viúvo (a)')) default 'Solteiro (a)',
	nroFilhos tinyint check (nroFilhos between 0 and 20) default 0 
);
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- 3. Experimentar inserção com dados fora do domínio 
----------------------------------------------------------------------------------------------------------------------------
--insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
--values	('Amadeu Abrantes', '20070101', '83365982271', 'Masculino', 'Solteiro (a)', 0)

--insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
--values	('Juliana Batista', cast(dateadd(year,-36, getdate()) as date), 'A0303777258', 'Feminino', 'Casado (a)', 2)

--insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
--values	('Sérgio Silva', cast(dateadd(year,-47, getdate()) as date),'28813550420', 'Sei não', 'Viúvo (a)', 4)
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
-- 3. Popular os nomes abaixo: 

--    Amadeu Abrantes (21 anos, 0 filhos)
--    Juliana Batista (36 anos, 2 filhos)
--    Sérgio Silva (47 anos, 4 filhos)

-- Listar (select) a variável table 
----------------------------------------------------------------------------------------------------------------------------
insert	into @tbCliente (nome, dataNascimento, cpf, sexo, estadoCivil, nroFilhos)
values	('Amadeu Abrantes', '19970101', '83365982271', 'Masculino', 'Solteiro (a)', 0)
		, ('Juliana Batista', cast(dateadd(year,-36, getdate()) as date), '00303777258', 'Feminino', 'Casado (a)', 2)
		, ('Sérgio Silva', cast(dateadd(year,-47, getdate()) as date),'28813550420', 'Masculino', 'Viúvo (a)', 4)

--select * from @tbCliente
----------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------------------
-- 4. Retornar as seguintes informações

--    1a. coluna: Label: Sobrenome, Nome 
--    2a. coluna: Label: Idade (cálculo aproximado utilizando datediff)
--    3a. coluna: Label: CPF (colocar no formato 999.999.999-99)
--    4a. coluna: Label: Gênero (masculino/feminino)
--    5a. coluna: Label: Estado Civil ( Solteiro (a), Casado (a) , Divorciado (a) , Viúvo (a) )
--    6a. coluna: Label: Filhos ( 0 a 20 filhos )
----------------------------------------------------------------------------------------------------------------------------
select	substring(nome, charindex(' ', nome) + 1, len(nome) - charindex(' ', nome)) 
                    + ', ' 
					+ left(nome, charindex(' ', nome) - 1) as [Sobrenome, Nome] 
		, datediff(year, dataNascimento, getdate()) as Idade
		, substring(cpf, 1, 3) + '.' + substring(cpf, 4, 3) + '.' + substring(cpf, 7, 3) + '-' + substring(cpf, 10, 2) as CPF 
		, sexo as 'Gênero'
		, estadoCivil as [Estado Civil]
		, nroFilhos as Filhos
from	@tbCliente
----------------------------------------------------------------------------------------------------------------------------


-- nome = Amadeu Abrantes
--        123456789012345

-- charindex(' ', nome) = 7
-- len(nome) = 15
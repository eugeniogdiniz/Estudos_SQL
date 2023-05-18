---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Exercício:
---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Faça um SELECT cujo algoritmo traga o 1o. e último dia do mês atual
select	cast(convert(varchar(6), getdate(), 112) + '01' as date) as '1o. Dia do Mês'
		, dateadd(day, -1, dateadd(month, 1, cast(convert(varchar(6), getdate(), 112) + '01' as date))) as 'Último Dia do Mês'

select	dateadd(day, 1, eomonth(getdate(), -1))
		, eomonth(getdate())

-- Faça um SELECT que retorne apenas a data de ontem, sem hora, minuto, segundo ou milissegundo.
select	cast(getdate() - 1 as date)
		, convert(char(8), getdate() - 1, 112)
		, convert(varchar, getdate() - 1, 103)

-- Faça um SELECT que retorne a data de ontem juntamente com a última hora, minuto, segundo e milissegundo.
select	dateadd(millisecond, -2, cast(cast(getdate() as date) as datetime))

---------------------------------------------------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Desenvolva T-SQL que resolva com precisão os cálculos abaixo (tempo 10 minutos):
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- a. 456/5
select 456/5.0 -- 91.200000

-- b. 782,23 x 82,07
select 782.23 * 82.07 -- 64197.6161

-- c. 5^2+3^3
select power(5, 2), power(3, 3), power(5, 2) + power(3, 3) -- 52

-- d. √125
select sqrt(125)

-- e. (((42 + 18) ÷ (54 ÷ 9) – 2) ÷ 4) – 2
select	42 + 18.0
		, 54 / 9.0
		, (((42 + 18.0) / (54 / 9.0) - 2) / 4.0) - 2
---------------------------------------------------------------------------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Através de funções built-in ou T-SQL, realize as operações abaixo (tempo 10 minutos):
---------------------------------------------------------------------------------------------------------------------------------------------------------

-- a. “Maria” e 5 espaços e “Antônia”
select 'Maria' + space(5) + 'Antônia'

-- b. Trocar a letra “a” por “e” na palavra “Tarara”
select replace('Tarara', 'a', 'e')

-- c. Recuperar as 3 primeiras letras do texto “Mongaguá”
select substring('Mongaguá', 1, 3), left('Mongaguá', 3)

-- d. Recuperar do caracter 6 ao 9 da palavra “Paralelepípido”
--				  12345678901234	
select substring('Paralelepípido', 6, 4)

-- e. Recuperar as 2 últimas letras de “Inverno”
select	right('Inverno', 2)
		, substring('Inverno', len('Inverno') - (2 - 1), 2)
---------------------------------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.Com a tabela DEVDB_2022_1SEM criada com os nomes dos alunos da turma, gere um ÚNICO SELECT que retorne apenas o Nome e o Sobrenome de TODOS alunos. 
-- Na Result Set,  o Nome  do aluno deverá ter a 1ª letra maiúscula, já o Sobrenome deve estar totalmente em maiúscula. O nome da coluna deverá ser 
-- apelidada de Nome e Sobrenome.
---------------------------------------------------------------------------------------------------------------------------------------------------------
create table DEVDB_2022_1SEM (id tinyint identity(1,1) constraint pkDEVDB_2022_1SEM primary key, nome varchar(60))
go
grant select on DEVDB_2022_1SEM to public
go
insert DEVDB_2022_1SEM values('ALAN MAGNO DA COSTA MOREIRA');
insert DEVDB_2022_1SEM values('Ariel Jentof');
insert DEVDB_2022_1SEM values('arthur barreto joaquim');
insert DEVDB_2022_1SEM values('BRUNO DOS SANTOS LOURENÇO');
insert DEVDB_2022_1SEM values('Camila Lima Ferreira de Souza');
insert DEVDB_2022_1SEM values('christian guimarães cilento negrão');
insert DEVDB_2022_1SEM values('DANIELA ALEXANDRA DA SILVA');
insert DEVDB_2022_1SEM values('David Marques Costa');
insert DEVDB_2022_1SEM values('eduardo julio monteiro');
insert DEVDB_2022_1SEM values('EDUARDO MACHADO DA COSTA OLIVEIRA');
insert DEVDB_2022_1SEM values('Eliseu Fernandes de Oliveira');
insert DEVDB_2022_1SEM values('eugênio lenine gueiros diniz');
insert DEVDB_2022_1SEM values('FERNANDO SERHAN PEREIRA');
insert DEVDB_2022_1SEM values('Flavia Maria Mota');
insert DEVDB_2022_1SEM values('gabriel silva ezequiel');
insert DEVDB_2022_1SEM values('GEISIANE APARECIDA RODRIGUES');
insert DEVDB_2022_1SEM values('George Kaique Brandão de Abreu Hoyo');
insert DEVDB_2022_1SEM values('guilherme silva monteiro');
insert DEVDB_2022_1SEM values('HIGOR VINICIOS CARRIAO');
insert DEVDB_2022_1SEM values('João Lucas Vieira Santos');
insert DEVDB_2022_1SEM values('joão vitor pezzuol trinca');
insert DEVDB_2022_1SEM values('JONATHAN FERREIRA REINALDO');
insert DEVDB_2022_1SEM values('Julia Camila Matias de Araujo');
insert DEVDB_2022_1SEM values('karina dos santos corrêa ribeiro');
insert DEVDB_2022_1SEM values('KASSIO ALMEIDA GOMES SORIANO');
insert DEVDB_2022_1SEM values('Leonardo Rocha Negro');
insert DEVDB_2022_1SEM values('leticia borges de oliveira');
insert DEVDB_2022_1SEM values('LUCAS HENRIQUE DE SOUSA');
insert DEVDB_2022_1SEM values('Lucas Oliveira Fernandes');
insert DEVDB_2022_1SEM values('lucas pereira galves');
insert DEVDB_2022_1SEM values('LUIS HENRIQUE ALVES SILVA');
insert DEVDB_2022_1SEM values('Luiz Gustavo Dias da Silva');
insert DEVDB_2022_1SEM values('marcelo ferreira faria');
insert DEVDB_2022_1SEM values('MARCOS HENRIQUE FERREIRA DA SILVA');
insert DEVDB_2022_1SEM values('Matheus Aparecido Ribeiro de Oliveira');
insert DEVDB_2022_1SEM values('nikolas barbosa miranda');
insert DEVDB_2022_1SEM values('PAMELLA ALVES DE OLIVEIRA');
insert DEVDB_2022_1SEM values('Pedro Gabriel Barreto Perobelli');
insert DEVDB_2022_1SEM values('rafael loureiro');
insert DEVDB_2022_1SEM values('RAFAEL STRABELI DOS SANTOS');
insert DEVDB_2022_1SEM values('Renan Alves Freitas');
insert DEVDB_2022_1SEM values('thiago muneratti');
insert DEVDB_2022_1SEM values('Vinicius Alves Siqueira');
insert DEVDB_2022_1SEM values('Wendel de Sousa Aquino');
insert DEVDB_2022_1SEM values('Bruno Henrique de Oliveira Dias');
insert DEVDB_2022_1SEM values('Victor de Paula Campos');
go

select  upper(left(nome, 1)) + lower(substring(nome, 2, charindex(' ', nome) - 2)) + ' ' + reverse(upper(left(reverse(nome), charindex(' ', reverse(nome)) - 1)))
from	DEVDB_2022_1SEM
---------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Em T-SQL, declare as variáveis, escolha o menor tipo possível que comporte o valor inicial e final, 
-- execute a operação para obter o valor final solicitado (10 minutos).
---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Variável	Valor Inicial	Valor Final
-- Mes		5				12
-- Ano		2013			2100
-- graus	-10				32
-- id		5				60.000
-- placa    XPT-9563        XPT-9245
-- modelo   Cruze           Cruze LS
-- endereco Av. Brasil      Av. Juscelino Kubitschek, 1000

-- declarando variáveis
declare @Mes tinyint, @Ano smallint, @graus smallint
		, @id int, @placa char(8), @modelo varchar(8)
		, @endereco varchar(30)

-- Setando valores Iniciais
select @Mes = 5, @Ano = 2013, @graus = -10, @id = 5
   , @placa = 'XPT-9563', @modelo = 'Cruze', @endereco = 'Av. Brasil'

-- Mostrando o conjunto de resultados Iniciais
select @Mes as Mes, @Ano as Ano, @graus as graus, @id as id
	, @placa as placa, @modelo as modelo, @endereco as endereco

-- Setando valores Finais
select	@Mes += 7, @Ano += 87, @graus += 42, @id += 59995
		, @placa = left(@placa, 4) + '9245'
		, @modelo += ' LS'
		, @endereco = left(@endereco, 4) + 'Juscelino Kubitschek, 1000'

-- Mostrando o conjunto de resultados Finais
select @Mes as Mes, @Ano as Ano, @graus as graus, @id as id
      , @placa as placa, @modelo as modelo, @endereco as endereco
---------------------------------------------------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Com os valores finais do exercício anterior e ainda em variáveis, faça as tranformações solicitadas (10 minutos):
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- a. Id ÷ Ano
-- b. Palavra “Mês” e 1 espaço e variável Mes
-- c. Variável Ano e texto “ Mongaguá”
-- d. Variável (id ÷ graus) – (Ano * Mês)
-- e. Modelo, hífen e placa
-- f. Substituir o número atual no endereço e colocar os 4 últimos dígitos da placa


select	@id / (@Ano * 1.0) 'a'
		, 'Mês' + space(1) + cast(@Mes as varchar) as 'b'
		, cast(@Ano as varchar) + 'Mongaguá' as 'c'
		, ((@id / (@graus * 1.0)) - (@Ano * @Mes)) as 'd'
		, @modelo + '-' + @placa as 'e'
		, replace(@endereco, right(@endereco, 4), right(@placa, 4)) as 'f'
---------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6. Você terá que deixar o script abaixo pronto para ser executado automaticamente através de um job. 
-- Faça as alterações suficientes para que seja executado totalmente sem erros:
---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Teste_sjo 
(
id tinyint primary key, nome varchar(20)
);
go
insert Teste_sjo values (1, 'Ana'), (2, 'Marcelo'), (3, 'Fábio'), (4, 'Paula');
go


create view vwTeste_sjo
as
select nome from Teste_sjo;
go


select * from vwTeste_sjo;
go
---------------------------------------------------------------------
/*
drop view vwTeste_sjo
drop table Teste_sjo
*/ 
---------------------------------------------------------------------------------------------------------------------------------------------------------


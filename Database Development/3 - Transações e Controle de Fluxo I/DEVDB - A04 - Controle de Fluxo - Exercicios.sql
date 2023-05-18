------------------------------------------------------------
-- Part I
------------------------------------------------------------
-- Construa um bloco T-SQL com as seguintes (20 minutos):

-- I.	Criar vari�veis saldoInicial e saldoTotal, num�ricas, de 2 bytes e 
--		com valores iniciais respectivamente 100 e 200.
declare @saldoInicial smallint = 100, @saldoTotal smallint = 200

-- II.	Criar vari�veis dtAtual e dtFutura, de 3 bytes e armazenando datas 
--		com valores iniciais em 19-06-2015 e 25-08-2015.
declare @dtAtual date = '20150619', @dtFutura date = '20150825'

-- III. Utilizando fun��es built-in, adicione ao saldoInicial a diferen�a em 
--		dias obtida entre as datas anteriores. 
select @saldoInicial = @saldoInicial + abs(datediff(day, @dtFutura, @dtAtual))

-- IV.	Da mesma forma que a instru��o anterior, multiplique saldoTotal pela 
--		diferen�a em meses destas datas.
select @saldoTotal = @saldoTotal * datediff(month, @dtAtual, @dtFutura)

-- V.	Fa�a um controle de fluxo verificando se o saldoInicial � 
--		maior ou igual ao saldoFinal, Se TRUE:
select	@saldoInicial saldoInicial, @saldoTotal saldoTotal

--		I .Escreva (select) a seguinte mensagem: 
--			�Seu Saldo em � e dtAtual e espa�o(1) e � � de � e saldoInicial e �.�
if @saldoInicial >= @saldoTotal
begin
	select	'Seu Saldo em ' + cast(@dtAtual as varchar) + space(1) 
			+ ' � de ' + cast(@saldoInicial as varchar) + '.'

--		II .Fa�a com que a dtAtual seja somada em 21 dias
	set @dtAtual = dateadd(day, 21, @dtAtual)
end
-- VI.	Se FALSE, escreva:

--		�Seu Saldo em � e dtFutura e espa�o(1) e � � de � e saldoTotal e �.�
else
	select	'Seu Saldo em ' + cast(@dtFutura as varchar) + space(1) 
			+ ' � de ' + cast(@saldoTotal as varchar) + '.'

-- VII.	Gere a sa�da de todas as vari�veis numa �nica linha, colocando um 
--		ALIAS em cada coluna de forma que saibamos do que cada coluna representa.
select	@saldoInicial as saldoInicial
		, @saldoTotal as saldoTotal
		, @dtAtual as dtAtual
		, @dtFutura as dtFutura


------------------------------------------------------------
-- Part II
------------------------------------------------------------
--	Atrav�s de comandos ad hoc, verifique a quantidade de registros das 
--	seguintes tabelas no banco de dados TempDB: 
--	sys.objetcs, sys.tables, sys.columns
select * from sys.objects
select * from sys.tables
select * from sys.columns


-- Examine tamb�m o conte�do da tabela sys.columns

-- A partir da investiga��o anterior, crie um script com as seguintes caracter�sticas

-- 1. Criar vari�veis com os menores tipos de dados poss�veis que armazenem (10 min.):
--		a. As quantidades de dados das tabelas.

--		b. Os Maiores e Menores valores dos seguintes campos da sys.columns: 
--			Object_id, name, system_type_id, user_type_id, is_nullable

--		c. A m�dia (com 2 casas decimais) do campo�column_id da tabela sys.columns

-- Vari�veis utilizadas
declare @qtd_sys_objects tinyint, @qtd_sys_tables tinyint, @qtd_sys_columns smallint
declare @min_Object_id int, @max_Object_id int
declare @min_name varchar(100), @max_name varchar(100)
declare @min_system_type_id tinyint, @max_system_type_id tinyint
declare @min_user_type_id smallint, @max_user_type_id smallint
declare @min_is_nullable bit, @max_is_nullable bit, @avg_column_id decimal(9,2)

-- Armazenando Valores
select	@qtd_sys_objects = count(*) from sys.objects
select	@qtd_sys_tables = count(*) from sys.tables
select	@qtd_sys_columns = count(*), @avg_column_id = avg(column_id)
		, @min_Object_id = min(Object_id), @max_Object_id = max(Object_id) 
		, @min_system_type_id = min(system_type_id), @max_system_type_id = max(system_type_id) 
		, @min_user_type_id = min(user_type_id), @max_user_type_id = max(user_type_id) 
		, @min_is_nullable = min(cast(is_nullable as tinyint)), @max_is_nullable = max(cast(is_nullable as tinyint)) 
from	sys.columns

-- Listando Valores encontrados
select	@qtd_sys_objects as qtd_sys_objects, @qtd_sys_tables as qtd_sys_tables
		, @qtd_sys_columns as qtd_sys_columns, @avg_column_id as avg_column_id
		, @min_Object_id as min_Object_id, @max_Object_id as max_Object_id
		, @min_system_type_id as min_system_type_id, @max_system_type_id as max_system_type_id
		, @min_user_type_id as min_user_type_id, @max_user_type_id as max_user_type_id
		, @min_is_nullable as min_is_nullable, @max_is_nullable as max_is_nullable






-- 2. Ap�s o armazenamento, construa o seguinte controle de fluxo (10 min.):

--		a. Caso o menor valor de system_type_id for igual ao menor valor de
--			user_type_id, escreva um texto que mostre isso. Em seguida some 
--			10 unidades em cada uma destas vari�veis.
--		b. Sen�o, escreva um texto que mostre que s�o divergentes.

--		c. Caso o menor object_id seja negativo, desvie o fluxo para um r�tulo 
--			chamado DESVIO_DE_FLUXO. No r�tulo mencionado gere um SELECT que 
--			mostre toda a linha referente ao objeto respons�vel pelo desvio.
--		d. Sen�o, verifique se os maiores valores em system_type_id e 
--			user_type_id.  Caso sejam diferentes escreva um texto sobre isso, 
--			mostrando os 2 valores.

--		e. Force o t�rmino�do script antes de chegar o r�tulo DESVIO_DE_FLUXO.


-- Vari�veis utilizadas
declare @qtd_sys_objects tinyint, @qtd_sys_tables tinyint, @qtd_sys_columns smallint
declare @min_Object_id int, @max_Object_id int
declare @min_name varchar(100), @max_name varchar(100)
declare @min_system_type_id tinyint, @max_system_type_id tinyint
declare @min_user_type_id smallint, @max_user_type_id smallint
declare @min_is_nullable bit, @max_is_nullable bit, @avg_column_id decimal(9,2)

-- Armazenando Valores
select	@qtd_sys_objects = count(*) from sys.objects
select	@qtd_sys_tables = count(*) from sys.tables
select	@qtd_sys_columns = count(*), @avg_column_id = avg(column_id)
		, @min_Object_id = min(Object_id), @max_Object_id = max(Object_id) 
		, @min_system_type_id = min(system_type_id), @max_system_type_id = max(system_type_id) 
		, @min_user_type_id = min(user_type_id), @max_user_type_id = max(user_type_id) 
		, @min_is_nullable = min(cast(is_nullable as tinyint)), @max_is_nullable = max(cast(is_nullable as tinyint)) 
from	sys.columns

-- a.
if @min_system_type_id <= @min_user_type_id
begin
	select	'O MENOR valor de system_type_id (' +  +cast(@min_system_type_id as varchar)
			+ ') � MENOR OU IGUAL ao valor de user_type_id (' + cast(@min_user_type_id as varchar) + ') !'
	select  @min_system_type_id += 10, @min_user_type_id += 10
end

-- b.
else
	select	'O MENOR valor de system_type_id (' + cast(@min_system_type_id as varchar) +
			') � SUPERIOR ao MENOR valor de user_type_id (' + cast(@min_user_type_id as varchar) + ') !'

-- c.
if @min_Object_id < 0
	goto DESVIO_DE_FLUXO

-- d.
else 
begin
	if @max_system_type_id <> @max_user_type_id
		select	'O MAIOR valor de system_type_id (' + cast(@max_system_type_id as varchar) +
				') � DIFERENTE do MAIOR valor de user_type_id (' + cast(@max_user_type_id as varchar) + ') !'
end

-- e.
return

DESVIO_DE_FLUXO: -- c.
	select	'Houve um desvio de Fluxo gerado pelo valor negativo do MENOR valor para Object_id (' + cast(@min_Object_id as varchar) + ') !'












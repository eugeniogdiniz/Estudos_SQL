---------------------------------------------------------------------------
-- DATA TYPES INTERNALS: SMALLDATETIME
---------------------------------------------------------------------------
/*
- Armazenamento em 4 Bytes
- Armazenamento de Data e/ou Hora
- Precis�o de MINUTOS (aproxima��o dos segundos, final 0)
- Dom�nio de Data: 1� de janeiro de 1900 a 6 de junho de 2079 
- Dom�nio de Hora: 00:00:00 a 23:59:59
- Valor Padr�o: 1900-01-01 00:00:00
*/

-- drop table TBTeste01
create table TBTeste01
(
id tinyint identity
, dt smalldatetime
)

sp_help TBTeste01



-- INSERTS
insert into TBTeste01 values (null);
insert into TBTeste01 (dt) values (getdate());

select * from TBTeste01 

select getdate(), cast(getdate() as date)


-- Armazenando somente DATA
insert into TBTeste01 (dt) values ('20180227'); -- FORMATO ISO YYYYMMDD
insert into TBTeste01 values (cast(getdate() as date));

select * from TBTeste01 
select *, convert(varchar, dt, 103) as 'Data Padr�o' from TBTeste01 



-- Armazenando somente Hora
insert into TBTeste01 values ('13:15');
insert into TBTeste01 values ('21:09');

select * from TBTeste01 

select '12' + ':' + '30' + ':' + '30'

-- Apresenta��o de segundos sempre ZERADOS (aproximacao de segundos)
insert TBTeste01 values ('20180113 12:30:59')
insert TBTeste01 values ('12' + ':' + '30' + ':' + '30')
insert TBTeste01 values ('20571231 12:30:29')
insert TBTeste01 values ('20571231 12:30:01')
insert TBTeste01 values ('20171231 23:59:30')

select * from TBTeste01 

select * from TBTeste01 where dt > '20571231 12:29:31'
select * from TBTeste01 where dt >= '20571231 12:29:31'
select * from TBTeste01 where dt >= '20571231 12:30'

drop table TBTeste01
---------------------------------------------------------------------------



---------------------------------------------------------------------------
-- DATA TYPES INTERNALS: DATETIME
---------------------------------------------------------------------------
/*
- Armazenamento em 8 Bytes
- Armazenamento de Data e/ou Hora
- Precis�o aproximada, 3 MILISSEGUNDOS (aproxima��o dos milissegundos, finais 0, 3, 7)
- Dom�nio de Data: Janeiro 1, 1753, a dezembro 31, 9999 
- Dom�nio de Hora: 00:00:00.000 a 23:59:59.997
- Valor Padr�o (default): 1900-01-01 00:00:00.000
*/

-- drop table TBTeste02 
create table TBTeste02
(
id tinyint identity
, dt datetime not null
)

sp_help TBTeste02


-- INSERTS
insert into TBTeste02 (dt) values (null);
insert into TBTeste02 values (getdate());
insert into TBTeste02 (dt) values ('20180227 09:59');

select * from TBTeste02 


-- Armazenando somente DATA
insert into TBTeste02 (dt) values ('20180227'); -- FORMATO ISO YYYYMMDD
insert into TBTeste02 values (cast(getdate() as date));

select * from TBTeste02 


-- Armazenando somente Hora
insert into TBTeste02 values ('13:15:29.663');
insert into TBTeste02 values ('21:09:38.777');

select * from TBTeste02 

-- Apresenta��o de MILISSEGUNDOS com finais 0, 3, 7 (aproximacao de milissegundos - precisao aproximada de 003 milissegundos)
insert TBTeste02 values('20180228 23:59:59:989'), ('20180228 23:59:59:990'), ('20180228 23:59:59:991') -- 9, 0, 1 --> 0
insert TBTeste02 values('20180228 23:59:59:992'), ('20180228 23:59:59:993'), ('20180228 23:59:59:994') -- 2, 3, 4 --> 3
insert TBTeste02 values('20180228 23:59:59:995'), ('20180228 23:59:59:996'),
('20180228 23:59:59:997'), ('20180228 23:59:59:998') -- 5, 6, 7, 8 --> 7
insert TBTeste02 values('20180228 23:59:59:999')

select * from TBTeste02 order by id desc

select * from TBTeste02 where dt < '20180227' -- '20180227 00:00:00.000'
select * from TBTeste02 where dt <= '20180227' 
select * from TBTeste02 where dt < '20180228'-- '20180228 00:00:00.000'
select * from TBTeste02 where dt < '20180229'
select * from TBTeste02 where dt < '20180301 00:00:00.000'
select * from TBTeste02 where dt between '20180228 00:00:00.000' and '20180228 23:59:59'
select * from TBTeste02 where dt between '20180228 23:59:59' and '20180228 23:59:59.999' -- '20180301 00:00:00.000'
select * from TBTeste02 where dt between '20180228 23:59:59' and '20180228 23:59:59.997'

select * from TBTeste02 where dt between '20180228' and '20180228 23:59:59.995' -- '20180301 00:00:00.000'

select * from TBTeste02 where dt >= '20180228' and dt <= '20180228 23:59:59.997'

select *, convert(varchar, dt, 112) as 'Data ISO' from TBTeste02 

select *, convert(varchar(6), dt, 112) as 'Ano e M�s ISO' from TBTeste02 

drop table TBTeste02 
---------------------------------------------------------------------------



---------------------------------------------------------------------------
-- DATA TIME FUNCTIONS
---------------------------------------------------------------------------
select isdate('20180228') as 'Data V�lida', isdate('20180229') as 'Data Inv�lida'

select	year('20180228') as 'Ano'
		, month('20180228') as 'M�s'
		, day('20180228') as 'Dia'

select	getdate() as 'Data Atual do Servidor'
		, year(getdate()) as 'Ano'
		, month(getdate()) as 'M�s'
		, day(getdate()) as 'Dia'

select	datepart(year, getdate()) as 'Ano'
		, datepart(mm, getdate()) as 'M�s'
		, datepart(d, getdate()) as 'Dia'

select	datepart(quarter, getdate()) as 'Trimestre'
		, datepart(dayofyear, getdate()) as 'Dia no Ano'
		, datepart(week, getdate()) as 'Semana no Ano'
		, datepart(weekday, getdate()) as 'Dia da Semana de Hoje' -- 1-Domingo, ... 7-S�bado
		, datepart(weekday, '19990921') as 'Dia da Semana de uma Data' -- 1-Domingo, ... 7-S�bado
		, datepart(millisecond, getdate()) as 'Milisegundos' 

select	dateadd(year, 1, getdate()) as 'Data no pr�ximo Ano'
		, dateadd(year, -9, getdate()) as 'Data a 9 anos atr�s'
		, dateadd(day, 2, getdate()) as 'Depois de Amanh�'

select	datediff(year, '20080519', '20100516') as 'Diferen�a em Anos (+)'
		, datediff(year, '20100516', '20080519') as 'Diferen�a em Anos (-)'
		, datediff(day, '20080519', getdate()) as 'Diferen�a em dias'
---------------------------------------------------------------------------





---------------------------------------------------------------------------
-- VARI�VEIS
---------------------------------------------------------------------------

-- Declarando Vari�veis I
Declare @contador int
Select @contador
go

Declare @qtd tinyint, @texto varchar(20)
Set @qtd = 5
Set @texto = 'Aula'
Select @qtd as Quantidade, @texto Aula, @texto 'Aula de BD'
Go

Declare @qtd tinyint, @texto varchar(20)
Select @qtd = 150, @texto = 'Aula 2'
Select @qtd, @texto
go


-- Declarando Vari�veis II
Declare @contador int = 5
Set @contador = @contador + 2
Select @contador
go

Declare @contador1 smallint = 15, @contador2 tinyint = 100
Set @contador1 = @contador1 + 5
Set @contador2 = @contador2 - 50
Select @contador1, @contador2, @contador1 * @contador2
go

Declare @contador1 smallint = 15, @contador2 tinyint = 100
Select @contador1 = @contador1 + 5, @contador2 = @contador2 - 50
Select @contador1, @contador2, @contador1 * @contador2
go



-- Declarando Vari�veis III
Declare @contador int = 5
Set @contador += 2
Select @contador
go

Declare @contador1 smallint = 15, @contador2 tinyint = 100
Set @contador1 += 5
Set @contador2 -= 50
Select @contador1 * @contador2
go

Declare @qtd tinyint = 2, @texto varchar(20) = 'Aula'
select @qtd *= 20, @texto += '2'
Select @qtd, @texto
go

---------------------------------------------------------------------------





---------------------------------------------------------------------------
-- DEMONSTRA��O DE FUN��ES APLICADAS
---------------------------------------------------------------------------
declare @texto varchar(30) = 'Rog�rio Vieira'

-- Pegando caracteres a esquerda, direita e extraindo bloco caracteres
select	left(@texto, 4) Esquerda
		, right(@texto, 3) as Direita
		, substring(@Texto, 5, 3) as 'Bloco de Caracteres'
		, len(@texto) as [Tamanho do texto]



-- Com a posi��o do espa�o podemos encontrar primeiro nome e �ltimo nome
-- Rog�rio Vieira
-- 12345678901234 

declare @texto varchar(30) = 'Rog�rio Vieira'

-- Encontrando o caracter ESPA�O no texto
select	charindex(' ', @texto) as [Posi��o do ESPA�O]


declare		@texto varchar(30) = 'Rog�rio Vieira', @posicaoEspaco tinyint
set			@posicaoEspaco = charindex(' ', @texto)
select		@texto as 'Nome', @posicaoEspaco as 'Posi��o do ESPA�O'
			, left(@texto, @posicaoEspaco - 1) as 'Primeiro Nome'
			, right(@texto, len(@texto) - @posicaoEspaco) as '�ltimo Nome'

-- Gil Gomes
-- 123456789

declare		@texto varchar(30) = 'Gil Gomes'
declare		@posicaoEspaco tinyint = charindex(' ', @texto), @tamanhoTexto tinyint = len(@texto)
select		@posicaoEspaco [Posi��o do Espa�o], @tamanhoTexto 'Tamanho do Texto'



declare		@texto varchar(30) = 'Gil Gomes'
declare		@posicaoEspaco tinyint = charindex(' ', @texto), @tamanhoTexto tinyint = len(@texto)
declare		@primeiroNome varchar(30), @ultimoNome varchar(30)

-- Ajustando e mostrando vari�veis
select  @primeiroNome = left(@texto, @posicaoEspaco - 1)
		, @ultimoNome = right(@texto, @tamanhoTexto - @posicaoEspaco)

select	@primeiroNome as 'Primeiro Nome', @ultimoNome as '�ltimo Nome'




/*
Adalgiza Albuquerque
12345678901234567890
*/


/*
euqreuqublA azigladA
12345678901234567890
*/
select reverse('Adalgiza Albuquerque')

select		left('Adalgiza Albuquerque', charindex(' ', 'Adalgiza Albuquerque') - 1) as 'Primeiro Nome'
			, reverse(left(reverse('Adalgiza Albuquerque'), charindex(' ', reverse('Adalgiza Albuquerque')) - 1)) as '�ltimo Nome'



-- Retirando Caracteres
select		replace('XPT-1234', '-', '') as 'Placa Padronizada'

declare		@cpf varchar(14) = '009.545.978-88'
select		replace(@cpf, '.', '') as 'Resultado Parcial'
select		replace(replace(@cpf, '.', ''), '-', '') as 'CPF sem Formato'

-- Concatenando
select 'Teste' + ' ' + 'de ' + 'concatena��o'
select concat('Teste ',  'de', ' concatena��o')
---------------------------------------------------------------------------
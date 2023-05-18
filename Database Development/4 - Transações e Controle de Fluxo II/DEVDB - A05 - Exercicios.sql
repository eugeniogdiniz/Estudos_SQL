------------------------------------------------------------
-- Part I
------------------------------------------------------------
-- I. Reescreva os exemplos passados nos slides anteriores, executem e verifiquem o controle de fluxo.

-- LOOP Infinito
while 1 = 1
begin
	select 'Essa rotina executar� o SELECT ETERNAMENTE !'
end




-- Loop limitando a 100 execu��es
declare @qtd tinyint = 1

while @qtd <= 100
begin
	PRINT 'QTD = ' + cast(@qtd as varchar)
	set @qtd = @qtd + 1
end






-- Combinando WHILE e IF
declare @qtd tinyint = 0, @msg varchar(100)

while @qtd <= 100
begin
	select @qtd += 1, @msg = 'O n�mero ' + cast(@qtd as varchar)

	-- Verificando se � PAR ou �MPAR
	if @qtd % 2 = 0
	begin
		select @msg = @msg + ' � PAR, pois o resto de divis�o por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
	end
	else
	begin
		select @msg = @msg + ' � �MPAR, pois o resto de divis�o por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
	end

	print @msg
end

-- Quando sair do Loop, rotina CONTINUA
set @msg =	'O n�mero ' + cast(@qtd as varchar)
			+ ' foi o limite que tornou a condi��o FALSE,'
			+ ' for�ando a sa�da do WHILE.'
PRINT @msg

-- Porque a rotina do LOOP 1 foi at� 100 e esta �ltima at� 101







-- TSQL: Controle de Fluxo
--use TempDB
--go

-- Percorrendo uma tabela
declare @oid int = -2147483648

while exists (select * from TempDB.sys.tables where object_id > @oid)
begin
	select @oid = min(object_id) from TempDB.sys.tables where object_id > @oid
	select @oid, 'Tabela' + object_name(@oid)
end




/*
   II. Crie um bloco T-SQL:
  		a. Tenha uma vari�vel para armazenar data com precis�o de dias, sendo iniciada em 13/jul/2015.
  		b. Fa�a um loop que rode o script at� a data atual.
  		c. O script deve gerar um print mostrando �Data no ciclo do Loop: � e a data que est� armazenada na vari�vel.
  		d. No fim do ciclo, mostrar �Sa�da do Loop com data: � e a data da vari�vel que for�ou a sa�da do loop.
*/

declare @dt date = '20150713'

while @dt <= GETDATE()
begin
	PRINT 'Data no ciclo do Loop: ' + cast(@dt as varchar)
	set @dt = DATEADD(day, 1, @dt)
end

PRINT 'Sa�da do Loop com data: ' + cast(@dt as varchar)








------------------------------------------------------------
-- Part II
------------------------------------------------------------
-- I. Reescreva os exemplos passados nos slides anteriores, executem e verifiquem o controle de fluxo.


-- BREAK
-- Loop limitando a 100 execu��es
declare @qtd tinyint = 1

while @qtd <= 100
begin
	PRINT 'QTD = ' + cast(@qtd as varchar)

	if @qtd = 50
		BREAK -- For�a a sa�da do loop

	set @qtd += @qtd
end



-- CONTINUE
-- Loop limitando a 100 execu��es
declare @qtd tinyint = 1

while @qtd <= 100
begin
	PRINT 'QTD = ' + cast(@qtd as varchar)

	if @qtd = 8
		CONTINUE -- For�a o teste do WHILE

	set @qtd += @qtd 
end







-- Utilizando WAITFOR
declare @qtd tinyint = 0, @msg varchar(100), @dt1 datetime, @dt2 datetime

while @qtd <= 100
begin
	select @qtd += 3
	set @msg = 'O n�mero ' + cast(@qtd as varchar)
	set @dt1 = getdate()

	-- Verificando se � PAR ou �MPAR
	if @qtd % 2 = 0
	begin
		select @msg = @msg + ' � PAR, pois o resto de divis�o por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
	end
	else
	begin
		select @msg = @msg + ' � �MPAR, pois o resto de divis�o por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
		WAITFOR DELAY '00:00:00.200'
	end

	set @dt2 = getdate()
	set @msg = @msg + 'Diferen�a em milisegundos '
				+ cast(datediff(millisecond, @dt1, @dt2) as varchar)
	print @msg
end

-- Quando sair do Loop, rotina CONTINUA
set @msg =	'O n�mero ' + cast(@qtd as varchar)
			+ ' foi o limite que tornou a condi��o FALSE,'
			+ ' for�ando a sa�da do WHILE.'
PRINT @msg








/*
I.  Crie uma tabela chamada geraNumero, com os seguintes campos:
	id - Capacidade para armazenar 10.000 n�meros, auto numerado com n�mera��o inicial em -29351 e pr�ximos n�meros 
		variando de 3 em 3 (ex: -29351, -29348, -29345, ...)
	registro - Campo num�rico de mesma capacidade que o campo id
	descricao - Texto com limite em 100 caracteres
*/

use TempDB
go

-- 1
create table geraNumero(
id smallint identity(-29351,3),
registro smallint,
descricao varchar(100)
)

GO

/*
II. Construa um bloco SQL que preencha a tabela criada com 10.000 registros com as seguintes formas de preenchimento:
		valor - ser� igual ao n�mero relativo a execu��o do bloco (ciclo em que est� no loop)
		descricao - ter� o texto "Registro inserido em " e adicionar a data e hora contendo os milissegundos (usar CONVERT no estilo 113)  

*/


-- 2
DECLARE @registro int = 1 
 WHILE @registro <= 10000
BEGIN
   INSERT INTO geraNumero 
   values(@registro, 'Registro inserido em ' 
		 + convert(varchar(100),getdate(),113)) 
 SET @registro = @registro + 1
END
select * from geraNumero





/*
III. Crie uma rotina que percorra todos os registros da tabela, do menor id para o maior e aplique as seguintes regras de controle de fluxo:
- Se o id for negativo, atualizar o campo descri��o, adicionando o texto: �. Este n�mero � NEGATIVO !�. 
	Se o id for maior ou igual a 0 adicionar: �. Este n�mero � NEGATIVO !�
- Se o id for divis�vel por 11, deletar o registro e lan�ar um result set (SELECT) que mencione o 
	motivo da dele��o e mostrar as informa��es do id, registro e descricao.
- Se o id for divis�vel por 17 ou 19, fa�a voltar para o WHILE.
- Se o id for um dos n�meros por 5627, 7812, 9422, 11898 ou 15212, force a sa�da do loop, mostre uma mensagem indicando o 
	motivo da sa�da e o n�mero que provocou a sa�da.

*/

--3
declare @id smallint = -32768
while exists(select * from geraNumero where id > @id)
begin
	select @id = MIN(id) from geraNumero where id > @id 

	if @id < 0
	begin
		update geraNumero set descricao = descricao + 'Este n�mero � NEGATIVO' where id = @id 
	end	
	else
	begin
		update geraNumero set descricao = descricao  + 'Este n�mero � POSITIVO' where id = @id 
	end
			 
	if @id % 11 = 0
	begin
		delete geraNumero 
		output deleted.*
		where id = @id
	end	
		 
	-- Divisivel por 17 ou 19
	if (@id % 17 = 0) or (@id % 19 = 0)
		continue	
		
	if @id in (5627, 7812, 9422, 11898, 15212)
	begin
		PRINT 'Sa�da fora�ada pois o n�mero tem o valor: ' + cast(@id as varchar)
		BREAK
	end			 
end



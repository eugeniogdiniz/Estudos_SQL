
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

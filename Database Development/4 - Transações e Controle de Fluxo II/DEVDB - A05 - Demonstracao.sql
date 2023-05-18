
-- LOOP Infinito
while 1 = 1
begin
	select 'Essa rotina executará o SELECT ETERNAMENTE !'
end



-- Loop limitando a 100 execuções
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
	select @qtd += 1, @msg = 'O número ' + cast(@qtd as varchar)

	-- Verificando se é PAR ou ÍMPAR
	if @qtd % 2 = 0
	begin
		select @msg = @msg + ' é PAR, pois o resto de divisão por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
	end
	else
	begin
		select @msg = @msg + ' é ÍMPAR, pois o resto de divisão por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
	end

	print @msg
end

-- Quando sair do Loop, rotina CONTINUA
set @msg =	'O número ' + cast(@qtd as varchar)
			+ ' foi o limite que tornou a condição FALSE,'
			+ ' forçando a saída do WHILE.'
PRINT @msg

-- Porque a rotina do LOOP 1 foi até 100 e esta última até 101



-- BREAK
-- Loop limitando a 100 execuções
declare @qtd tinyint = 1

while @qtd <= 100
begin
	PRINT 'QTD = ' + cast(@qtd as varchar)

	if @qtd = 50
		BREAK -- Força a saída do loop

	set @qtd += @qtd
end



-- CONTINUE
-- Loop limitando a 100 execuções
declare @qtd tinyint = 1

while @qtd <= 100
begin
	PRINT 'QTD = ' + cast(@qtd as varchar)

	if @qtd = 8
		CONTINUE -- Força o teste do WHILE

	set @qtd += @qtd 
end




-- Utilizando WAITFOR
declare @qtd tinyint = 0, @msg varchar(100), @dt1 datetime, @dt2 datetime

while @qtd <= 100
begin
	select @qtd += 3
	set @msg = 'O número ' + cast(@qtd as varchar)
	set @dt1 = getdate()

	-- Verificando se é PAR ou ÍMPAR
	if @qtd % 2 = 0
	begin
		select @msg = @msg + ' é PAR, pois o resto de divisão por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
	end
	else
	begin
		select @msg = @msg + ' é ÍMPAR, pois o resto de divisão por 2 foi ' + cast(@qtd % 2 as varchar) + ' !'
		WAITFOR DELAY '00:00:00.200'
	end

	set @dt2 = getdate()
	set @msg = @msg + 'Diferença em milisegundos '
				+ cast(datediff(millisecond, @dt1, @dt2) as varchar)
	print @msg
end

-- Quando sair do Loop, rotina CONTINUA
set @msg =	'O número ' + cast(@qtd as varchar)
			+ ' foi o limite que tornou a condição FALSE,'
			+ ' forçando a saída do WHILE.'
PRINT @msg

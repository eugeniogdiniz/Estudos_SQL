----------------------------------------------------------------------------------------------------------------------------
-- PRATICANDO ALGORITMO DE LOOP
----------------------------------------------------------------------------------------------------------------------------

-- Conectar na base Temp e construir Loop que "varra" a tabela FUNCIONARIO e incluindo algumas caracter�sticas


-- Atrav�s de uma vari�vel, contabilize o n�mero de execu��o de cada ciclo no loop 
-- A "varredura" da tabela deve ocorrer pela matr�cula, do menor n�mero para o maior
-- A cada ciclo, incremente o n�mero de controle, armazene em vari�veis os valores da matr�cula, email e sal�rio e liste os 4 valores.


-- 1. Construa o algoritmo de Loop sem utiliza��o do comando EXISTS na cl�usula WHILE
-- 2. Reconstrua o algoritmo de Loop UTILIZANDO o comando EXISTS na cl�usula WHILE
-- 3. Escolha uma das formas anteriores e adapte para que a "varredura" ocorra do maior n�mero da matr�cula para o menor  
----------------------------------------------------------------------------------------------------------------------------

select * from funcionario


-- 1. Construa o algoritmo de Loop sem utiliza��o do comando EXISTS na cl�usula WHILE
declare @qtdCiclo tinyint = 0, @matricula tinyint, @email varchar(100), @salario decimal(9, 2)

while @qtdCiclo < 200
begin
    set @qtdCiclo += 1
    select @matricula = matricula, @email = email, @salario = salario from funcionario where matricula = @qtdCiclo
    print concat(   
                'N�mero do Ciclo: ', cast(@qtdCiclo as varchar)
                , ' - Matr�cula: ', cast(@matricula as varchar)
                , ' - e-mail: ', @email
                , ' - Sal�rio: ', cast(@salario as varchar)
                )
end





-- 2. Reconstrua o algoritmo de Loop UTILIZANDO o comando EXISTS na cl�usula WHILE
declare @qtdCiclo tinyint = 0, @matricula tinyint = 0, @email varchar(100), @salario decimal(9, 2)

while exists(select * from funcionario where matricula > @matricula)
begin
    select @matricula = min(matricula) from funcionario where matricula > @matricula
    select @email = email, @salario = salario, @qtdCiclo += 1 from funcionario where matricula = @matricula
    print concat(   
                'N�mero do Ciclo: ', cast(@qtdCiclo as varchar)
                , ' - Matr�cula: ', cast(@matricula as varchar)
                , ' - e-mail: ', @email
                , ' - Sal�rio: ', cast(@salario as varchar)
                )
end




-- 3. Escolha uma das formas anteriores e adapte para que a "varredura" ocorra do maior n�mero da matr�cula para o menor  
declare @qtdCiclo tinyint = 0, @matricula tinyint = 255, @email varchar(100), @salario decimal(9, 2)

while exists(select * from funcionario where matricula < @matricula)
begin
    select @matricula = max(matricula) from funcionario where matricula < @matricula
    select @email = email, @salario = salario, @qtdCiclo += 1 from funcionario where matricula = @matricula
    print concat(   
                'N�mero do Ciclo: ', cast(@qtdCiclo as varchar)
                , ' - Matr�cula: ', cast(@matricula as varchar)
                , ' - e-mail: ', @email
                , ' - Sal�rio: ', cast(@salario as varchar)
                )
end






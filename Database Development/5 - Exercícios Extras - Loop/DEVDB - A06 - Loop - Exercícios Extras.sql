----------------------------------------------------------------------------------------------------------------------------
-- PRATICANDO ALGORITMO DE LOOP
----------------------------------------------------------------------------------------------------------------------------

-- Conectar na base Temp e construir Loop que "varra" a tabela FUNCIONARIO e incluindo algumas características


-- Através de uma variável, contabilize o número de execução de cada ciclo no loop 
-- A "varredura" da tabela deve ocorrer pela matrícula, do menor número para o maior
-- A cada ciclo, incremente o número de controle, armazene em variáveis os valores da matrícula, email e salário e liste os 4 valores.


-- 1. Construa o algoritmo de Loop sem utilização do comando EXISTS na cláusula WHILE
-- 2. Reconstrua o algoritmo de Loop UTILIZANDO o comando EXISTS na cláusula WHILE
-- 3. Escolha uma das formas anteriores e adapte para que a "varredura" ocorra do maior número da matrícula para o menor  
----------------------------------------------------------------------------------------------------------------------------

select * from funcionario


-- 1. Construa o algoritmo de Loop sem utilização do comando EXISTS na cláusula WHILE
declare @qtdCiclo tinyint = 0, @matricula tinyint, @email varchar(100), @salario decimal(9, 2)

while @qtdCiclo < 200
begin
    set @qtdCiclo += 1
    select @matricula = matricula, @email = email, @salario = salario from funcionario where matricula = @qtdCiclo
    print concat(   
                'Número do Ciclo: ', cast(@qtdCiclo as varchar)
                , ' - Matrícula: ', cast(@matricula as varchar)
                , ' - e-mail: ', @email
                , ' - Salário: ', cast(@salario as varchar)
                )
end





-- 2. Reconstrua o algoritmo de Loop UTILIZANDO o comando EXISTS na cláusula WHILE
declare @qtdCiclo tinyint = 0, @matricula tinyint = 0, @email varchar(100), @salario decimal(9, 2)

while exists(select * from funcionario where matricula > @matricula)
begin
    select @matricula = min(matricula) from funcionario where matricula > @matricula
    select @email = email, @salario = salario, @qtdCiclo += 1 from funcionario where matricula = @matricula
    print concat(   
                'Número do Ciclo: ', cast(@qtdCiclo as varchar)
                , ' - Matrícula: ', cast(@matricula as varchar)
                , ' - e-mail: ', @email
                , ' - Salário: ', cast(@salario as varchar)
                )
end




-- 3. Escolha uma das formas anteriores e adapte para que a "varredura" ocorra do maior número da matrícula para o menor  
declare @qtdCiclo tinyint = 0, @matricula tinyint = 255, @email varchar(100), @salario decimal(9, 2)

while exists(select * from funcionario where matricula < @matricula)
begin
    select @matricula = max(matricula) from funcionario where matricula < @matricula
    select @email = email, @salario = salario, @qtdCiclo += 1 from funcionario where matricula = @matricula
    print concat(   
                'Número do Ciclo: ', cast(@qtdCiclo as varchar)
                , ' - Matrícula: ', cast(@matricula as varchar)
                , ' - e-mail: ', @email
                , ' - Salário: ', cast(@salario as varchar)
                )
end






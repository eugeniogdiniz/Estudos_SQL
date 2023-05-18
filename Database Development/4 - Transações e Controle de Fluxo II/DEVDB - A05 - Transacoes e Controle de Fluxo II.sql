-- ======================================================================================================================
-- Transações e Controle de Fluxo II
-- ======================================================================================================================

-- Propriedades ligadas da conexão
dbcc useroptions -- Mostra o que está ON na sessão

set nocount on;  
set implicit_transactions off;  -- AUTO COMMIT é o DEFAULT do SQL Server

-- Criando tabela para testes
select object_id('dbo.t1','U') -- Null

if (object_id('dbo.t1','U') is not null)     drop table dbo.t1;  
go
create table dbo.t1 (a int);  
go 



-------------------------------------
-- AUTOCOMMIT (set implicit_transactions off)
-------------------------------------

-- DROP TABLE NewTable
if (object_id('NewTable') is not null)     drop table NewTable;  
go
CREATE TABLE NewTable (Id INT PRIMARY KEY, Info CHAR(3))
GO

-- Transação Implícita (nem sempre temos o AUTOCOMMIT, será mostrado mais a frente)
-- AUTOCOMMIT (Default. Transação é implícita e se tudo estiver OK, finaliza com COMMIT. Se algum erro é
--						gerado, rollback)
INSERT INTO NewTable VALUES (0, 'AAA')
INSERT INTO NewTable VALUES (1, 'aaa') -- Mesmo rodando os dois inserts, são duas transações implícitas

select @@TranCount -- Verifica Transações abertas
select * from NewTable

---------------------------------------------------------------------------------------
-- Lembrar que no AZURE SQL estamos em read committed snapshot
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- Caso seja necessária alteração
-- ALTER DATABASE ABC SET ALLOW_SNAPSHOT_ISOLATION ON
-- while (@@TranCount > 0) commit transaction;  
---------------------------------------------------------------------------------------


  

---------------------------------------------------------------------------------------
-- TESTE A: DEFAULT (SET IMPLICIT_TRANSACTIONS OFF)
---------------------------------------------------------------------------------------
PRINT N'-------- [Test A] ---- OFF ----';  
PRINT N'[A.01] Now, SET IMPLICIT_TRANSACTIONS OFF.';  
PRINT N'[A.02] @@TranCount, at start, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
SET IMPLICIT_TRANSACTIONS OFF;  
GO 

INSERT INTO dbo.t1 VALUES (11);  
INSERT INTO dbo.t1 VALUES (12);  
PRINT N'[A.03] @@TranCount, after INSERTs, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO  
---------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------
-- TESTE B: SET IMPLICIT_TRANSACTIONS ON.
---------------------------------------------------------------------------------------
PRINT N' ';  
PRINT N'-------- [Test B] ---- ON ----';  
PRINT N'[B.01] Now, SET IMPLICIT_TRANSACTIONS ON.';  
PRINT N'[B.02] @@TranCount, at start, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
SET IMPLICIT_TRANSACTIONS ON;  --<-- alterando para ON
GO

INSERT INTO dbo.t1 VALUES (21);  
INSERT INTO dbo.t1 VALUES (22);  
PRINT N'[B.03] @@TranCount, after INSERTs, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO 

COMMIT TRANSACTION;  
PRINT N'[B.04] @@TranCount, after COMMIT, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO


select * from dbo.t1
dbcc useroptions


PRINT N' ';  
PRINT N'-------- [Test B] ---- ON ----';  
PRINT N'[B.03] SET IMPLICIT_TRANSACTIONS ON, Yet';  
PRINT N'[B.02] @@TranCount, at start, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
SET IMPLICIT_TRANSACTIONS ON;  
GO

INSERT INTO dbo.t1 VALUES (23);  
INSERT INTO dbo.t1 VALUES (24);  
PRINT N'[B.03] @@TranCount, after INSERTs, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO 

select * from dbo.t1 

-- Abrir outra sessão e visualizar conteúdo da tabela

-- CONFIRMAR e verificar novamente na outra sessão
COMMIT TRANSACTION;  
---------------------------------------------------------------------------------------







/*
---------------------------------------------------------------------------------------
-- TESTE C: SET IMPLICIT_TRANSACTIONS ON.
-- Aumentando Trancount com Begin Transaction (não é transação aninhada)
---------------------------------------------------------------------------------------
PRINT N' ';  
PRINT N'-------- [Test C] ---- ON, then BEGIN TRAN ----';  
PRINT N'[C.01] Now, SET IMPLICIT_TRANSACTIONS ON.';  
PRINT N'[C.02] @@TranCount, at start, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
SET IMPLICIT_TRANSACTIONS ON;  
GO  

BEGIN TRANSACTION;  
INSERT INTO dbo.t1 VALUES (31);  
INSERT INTO dbo.t1 VALUES (32);  
PRINT N'[C.03] @@TranCount, after INSERTs, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO  

COMMIT TRANSACTION;  
PRINT N'[C.04] @@TranCount, after a COMMIT, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
COMMIT TRANSACTION;  
PRINT N'[C.05] @@TranCount, after another COMMIT, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO

select @@TRANCOUNT
commit transaction
rollback transaction -- Cancela tudo
---------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------
-- TESTE D: SET IMPLICIT_TRANSACTIONS ON.
-- Similar ao TESTE C, onde não há transação aninhada, mas parece
---------------------------------------------------------------------------------------  
PRINT N' ';  
PRINT N'-------- [Test D] ---- ON, INSERT, BEGIN TRAN, INSERT ----';  
PRINT N'[D.01] Now, SET IMPLICIT_TRANSACTIONS ON.';  
PRINT N'[D.02] @@TranCount, at start, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
SET IMPLICIT_TRANSACTIONS ON;  
GO 

INSERT INTO dbo.t1 VALUES (41);  
BEGIN TRANSACTION;  
INSERT INTO dbo.t1 VALUES (42);  
PRINT N'[D.03] @@TranCount, after INSERTs, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO 

COMMIT TRANSACTION;  
PRINT N'[D.04] @@TranCount, after a COMMIT, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
COMMIT TRANSACTION;  
PRINT N'[D.05] @@TranCount, after another COMMIT, == ' + CAST(@@TRANCOUNT AS NVARCHAR(10));  
GO
---------------------------------------------------------------------------------------
*/


  
---------------------------------------------------------------------------------------
-- Clean up.  
SET IMPLICIT_TRANSACTIONS OFF;  
GO  
WHILE (@@TranCount > 0) COMMIT TRANSACTION;  
GO  
DROP TABLE dbo.t1;  
GO
---------------------------------------------------------------------------------------









-------------------------------------
-- Transação Explícita (COMMIT)
-------------------------------------
BEGIN TRAN
	INSERT INTO NewTable VALUES (2, 'bbb')
	INSERT INTO NewTable VALUES (3, 'ccc')
	INSERT INTO NewTable VALUES (4, 'ddd')
	SELECT * FROM NewTable
COMMIT TRAN

ROLLBACK TRAN

-- Verificação da table
SELECT * FROM NewTable
TRUNCATE TABLE NewTable
-------------------------------------




---------------------------------------------------------------------------------------------------------------
-- ERRO DE COMPILAÇÂO (um erro de sintaxe, no batch enviado, inviabiliza todo o batch)
---------------------------------------------------------------------------------------------------------------
INSERT INTO NewTable VALUES (1, 'aaa')
INSERT INTO NewTable VALUES (2, 'bbb')
INSERT INTO NewTable VALUSE (3, 'ccc')

SELECT * FROM NewTable
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
-- RUN-TIME ERRORS (erro em tempo de execução), uma violação de restrição em um batch, inviabiliza apenas a 
-- instrução que gerou o erro. As demais serão concluídas. 
-- SET XACT_ABORT OFF
---------------------------------------------------------------------------------------------------------------
dbcc useroptions

TRUNCATE TABLE NewTable

begin tran
	INSERT INTO NewTable VALUES (1, 'aaa')
	INSERT INTO NewTable VALUES (2, 'bbb')
	INSERT INTO NewTable VALUES (2, 'ccc') 
	INSERT INTO NewTable VALUES (3, 'ddd')
commit tran

SELECT * FROM NewTable


dbcc useroptions
---------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------
-- Erros de Compilação não são alterados com XACT_ABORT (DEFAULT OFF). Já erros em tempo de execução, serão
-- feitos ROLLBACK caso o SET XACT_ABORT esteja em ON. 
-- RUN-TIME ERRORS SÂO AFETADOS pelo XACT_ABORT
---------------------------------------------------------------------------------------------------------------
TRUNCATE TABLE NewTable

-- Specifies whether SQL Server automatically rolls back the current transaction when a Transact-SQL statement raises a run-time error.
-- SET XACT_ABORT ON
SET XACT_ABORT ON
BEGIN TRAN
	INSERT INTO NewTable VALUES (1, 'aaa')
	INSERT INTO NewTable VALUES (2, 'bbb')
	INSERT INTO NewTable VALUES (2, 'ccc') -- Syntax error.
	select @@error -- Verifica último erro gerado pela linha EXATAMENTE anterior
	INSERT INTO NewTable VALUES (3, 'ddd') 
COMMIT TRAN

SELECT * FROM NewTable

truncate table NewTable
---------------------------------------------------------------------------------------------------------------






----------------------------------------------------------------------------------------------------
-- Controle de Transação Explícita (COMMIT/ROLLBACK)
----------------------------------------------------------------------------------------------------
BEGIN TRAN
	INSERT INTO NewTable VALUES (3, 'ccc')
	INSERT INTO NewTable VALUES (4, 'ddd')
	INSERT INTO NewTable VALUES (5, 'eee')
	
IF (SELECT MAX(ID) FROM NewTable) < 5 -- Repetir uma 2a. execução com <=
	COMMIT TRAN
ELSE
	ROLLBACK TRAN


-- Verificação da table
SELECT * FROM NewTable
TRUNCATE TABLE NewTable
DROP TABLE NewTable



-- Ou podemos precisar de uma operação casada, onde não haja erros (exemplo 'teórico)
BEGIN TRANSACTION fund_transfer
	EXEC debit_checking 100, 'account1'
	EXEC credit_savings 100, 'account2'
	
IF @@error <> 0
	ROLLBACK TRANSACTION fund_transfer
ELSE
	COMMIT TRANSACTION fund_transfer
----------------------------------------------------------------------------------------------------





----------------------------------------------------------------------------------------------------
-- Não Há NESTED TRANSACTIONS no SQL SERVER
----------------------------------------------------------------------------------------------------
-- truncate table TBA
-- drop table TBA
-- DROP TABLE NewTable
if (object_id('Veiculo') is not null)     drop table Veiculo;  
go
create table Veiculo(carro varchar(20))

-- Apesar de parecer, não são transações aninhadas, mesmo havendo o incremento do TRANCOUNT
-- Apesar de necessitar de tantos COMMITs para CADA BEGIN, um simples ROLLBACK desfaz TUDO
--> Notar também que numa OUTRA SESSÃO, mesmo com um COMMIT não é possível ver os VEICULOS,
--> Em outras palavras, ainda temos uma transação PRINCIPAL (a 1a. aberta) que ainda controla os dados
begin transaction
   insert Veiculo values ('palio'), ('corsa')

   begin transaction
         insert Veiculo values ('Polo'), ('S10')
   rollback transaction

commit transaction

select @@trancount
select * from Veiculo


-- Nova tabela TBA
if (object_id('TBA') is not null)     drop table TBA;  
go
create table TBA(c1 tinyint identity(1,1), c2 varchar(5))

insert TBA values ('a')
insert TBA values ('b')
insert TBA values ('c')

select * from TBA

-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED

-- Prova do não aninhamento de transações
begin transaction Transacao1
	update TBA set c2 = 'Z' where c1 = 2
	select @@trancount TRANCOUNT, * from TBA where c1 = 2
	
	begin transaction Transacao2
		update TBA set c2 = 'T' where c1 = 1
		select @@trancount TRANCOUNT, * from TBA where c1 = 1
	commit transaction Transacao2	

rollback transaction Transacao1 -- ROLLBACK é de toda a transação e não parte dela
rollback transaction Transacao2 -- Aqui gera erro, pois o ROLLBACK é para toda a tranação

select * from TBA
drop table TBA
----------------------------------------------------------------------------------------------------







----------------------------------------------------------------------------------------------------
-- SAVE TRANSACTIONS - Controlando transações
----------------------------------------------------------------------------------------------------
-- truncate table TBB
-- drop table TBB
if (object_id('TBB') is not null)     drop table TBB;  
go
create table TBB(c1 tinyint )

insert TBB values (15)
insert TBB values (25)
insert TBB values (35)

select * from TBB


-- Controlando Transações com Save Transaction
begin transaction t1

	insert TBB Values(3)
	save transaction t2
		
	insert TBB Values(4)
	save transaction t3	
	
	insert TBB Values (5)

	-- Poderia realizar uma validação e dependendo do resultado, 
	-- voltar com um rollback na posição desejada
	rollback transaction t2 -- ROLLBACK quando usado com SAVE TRANSACTION, funciona numa ÚNICA TRANSAÇÃO
                            -- mas notar no Trancount que temos uma ÚNICA TRANSAÇÃO
commit transaction t1

select @@trancount
select * from TBB
drop table TBB
----------------------------------------------------------------------------------------------------


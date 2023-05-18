--use master
--go

--if exists (select * from sys.databases where name = 'Concessionaria')
--drop database Concessionaria
--go

--create database Concessionaria
--go

--use Concessionaria
--go


CREATE TABLE Ano
( 
idAno tinyint identity(1,1)
, descricao smallint not null 
, constraint pkAno primary key (idAno)
)
go


CREATE TABLE Fabricante
( 
idFabricante       tinyint identity(1,1)
, Nome               varchar(50) not null 
, endereco           varchar(100) null 
, cidade             varchar(50) not null 
, UF                 char(2) null 
, telefone           varchar(20) null 
, contato            varchar(50) not null
, constraint pkFabricante primary key (idFabricante)
)
go

CREATE TABLE Mes
( 
idMes              tinyint identity (15, 3) 
, descricao        tinyint  not null 
, constraint pkMes primary key (idMes)
)
go

CREATE TABLE Modelo
( 
idModelo           smallint identity(1,1)
, descricao          varchar(50) not null 
, constraint pkModelo primary key (idModelo)
)
go

CREATE TABLE Veiculo
( 
idVeiculo          smallint identity(1,1)
, descricao          varchar(50) not null
, valor              decimal(9,2)not null
, dataCompra date not null
, idModelo           smallint null 
, idFabricante       tinyint  null 
, idAnoFabricacao    tinyint  null 
, constraint pkVeiculo primary key (idVeiculo)
, constraint fkVeiculo_idModelo foreign key (idModelo) references Modelo(idModelo)
, constraint fkVeiculo_idFabricante foreign key (idFabricante) references Fabricante(idFabricante)
, constraint fkVeiculo_idAnoFabricacao foreign key (idAnoFabricacao) references Ano(idAno)
)
go

CREATE TABLE VendasAnuais
( 
idVendas           int identity (1,1)
, qtd                smallint not null 
, idVeiculo          smallint  null 
, idAnodaVenda       tinyint  null 
, idMesdaVenda       tinyint  null 
, constraint pkVendasAnuais primary key (idVendas)
, constraint fkVendasAnuais_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo)
, constraint fkVendasAnuais_idAnodaVenda foreign key (idAnodaVenda) references Ano(idAno)
, constraint fkVendasAnuais_idMesdaVenda foreign key (idMesdaVenda) references Mes(idMes)
)
go

/*
-- Selects
select * from Fabricante
select * from Modelo
select * from Ano
select * from Mes
select * from VendasAnuais
select * from Veiculo
select * from Ano

use master
go

Use Concessionaria
go

*/


-- Fabricante
insert Fabricante (nome, endereco, cidade, uf, telefone, contato) values
  ('Honda', 'Rua da Consolacao, 125', 'Sao Paulo', 'SP', '26454128', 'Ismael Santos')
, ('Yamaha', 'Rua Ipiranga, 820', 'Sao Paulo', 'SP', '24456200', 'Ana Cristina')
, ('Suzuki', 'Av. Rio Branco, 1250', 'Rio de Janeiro', 'RJ', '37785511', 'Marcelo Faria')
, ('Dafra', 'Av. Rodolfo Paiva, 340', 'Rio de Janeiro', 'RJ', '43326667', 'Antonio Brandao')
, ('Kawasaki', 'Rua Joaquim Floriano, 678', 'Sao Paulo', 'SP', '24527272', 'Monica Bahia')
, ('Ducati', 'Rua das Flores, 620', 'Curitiba', 'PR', '62331111', 'Paula Beltrão')
, ('BMW', 'Rua Antonio Bandeiras, 890', 'Sao Paulo', 'SP', '27783535', 'Hans Miller')
, ('Harley-Davidson', 'Rua das Gaivotas, 81', 'Joinville', 'SC', '32662112', 'Adolfo Siqueira')
, ('Kasinski', 'Av. Brasil, 545', 'Recife', 'PE', '4112-8878', 'Silvia Telles')

-- Modelo
insert Modelo values ('GS'), ('R'), ('K'), ('GT'), ('GTR'), ('GTS'), ('STD'), ('L'), ('LS')

-- Ano
declare @anoFinal smallint = year(getdate())
declare @anoInicial smallint = (@anoFinal - 10)
while @anoFinal >= @anoInicial
begin
insert Ano values (@anoFinal)
set @AnoFinal -= 1
end



-- Mes
declare @mesFinal smallint = 12, @mesInicial smallint = 1
while @mesFinal >= @mesInicial
begin
insert mes values (@mesFinal)
set @mesFinal -= 1
end

----------------------------------------------------------------------------
-- Veiculo / Vendas Anuais
----------------------------------------------------------------------------
-- drop procedure InserirVeiculoVendas
go
create procedure InserirVeiculoVendas @valor int, @ano int, @veiculo varchar(20), @fabricante varchar(30), @modelo varchar(20), @qtdModelo tinyint
as
begin
   set nocount on
   
   declare @idAno tinyint, @idMes tinyint = (select min(idMes) from Mes)
   declare @qtd1 int, @qtd2 int, @qtd3 int, @idFabricante tinyint, @idModelo tinyint
   declare @randMes tinyint, @randDia tinyint, @dataCompra varchar(8), @anoData varchar(4)

-- Valores Iniciais
select   @idFabricante = (select idFabricante from Fabricante where nome = @fabricante)
, @idModelo = (select idModelo from Modelo where descricao = @modelo)
, @idAno = (select idAno from ano where descricao = @ano)
, @idMes = (select min(idMes) from Mes)

-- Percorrendo do ano fornecido até o último Ano
   while @idAno <= (select max(idAno) from Ano)
   begin

-- Montando uma data válida
select @anoData = cast(descricao as varchar(4)) from ano where idAno = @idAno
select @randMes = cast((rand() * 50) as tinyint), @randDia = cast((rand() * 20) as tinyint)
select @dataCompra = (cast(@anoData as varchar(4))+ replicate('0', 2 - len(@randMes)) + cast(@randMes as varchar) + replicate('0', 2 - len(@randDia)) + cast(@randDia as varchar))

while isdate(@dataCompra) = 0
begin
select @randMes = cast((rand() * 50) as tinyint), @randDia = cast((rand() * 20) as tinyint)
select @dataCompra = (cast(@ano as varchar)+ replicate('0', 2 - len(@randMes)) + cast(@randMes as varchar) + replicate('0', 2 - len(@randDia)) + cast(@randDia as varchar))
end

      -- Inclusão de Veículo
      insert Veiculo (descricao, valor, idModelo, idFabricante, idAnoFabricacao, dataCompra) values (@veiculo, @valor, @idModelo, @idFabricante, @idAno, @dataCompra) 

      if @qtdModelo >= 2
         insert Veiculo (descricao, valor, idModelo, idFabricante, idAnoFabricacao, dataCompra) values (@veiculo, cast(@valor * 1.0025 as int) , @idModelo + 1, @idFabricante, @idAno, @dataCompra) 

      if @qtdModelo = 3
         insert Veiculo (descricao, valor, idModelo, idFabricante, idAnoFabricacao, dataCompra) values (@veiculo, cast(@valor * 1.0045 as int) , @idModelo + 2, @idFabricante, @idAno, @dataCompra) 


  -- Inclusão de Vendas Anuais
      while @idMes <= (select max(idMes) from Mes)
      begin
         select @qtd1 = cast(rand() * 1000 as int), @qtd2 = cast(rand() * 1000 as int), @qtd3 = cast(rand() * 1000 as int)

         -- VendasAnuais
         insert VendasAnuais values
         (@qtd1, (select idVeiculo from Veiculo where idFabricante = @idFabricante and idAnoFabricacao = @idAno and idModelo = @idModelo and descricao = @veiculo), @idAno, @idMes) 
               
         if @qtdModelo >= 2
            insert VendasAnuais values
            (@qtd2, (select idVeiculo from Veiculo where idFabricante = @idFabricante and idAnoFabricacao = @idAno and idModelo = @idModelo + 1 and descricao = @veiculo), @idAno, @idMes) 

         if @qtdModelo = 3
            insert VendasAnuais values  
            (@qtd3, (select idVeiculo from Veiculo where idFabricante = @idFabricante and idAnoFabricacao = @idAno and idModelo = @idModelo + 2 and descricao = @veiculo), @idAno, @idMes) 

         select @idMes = min(idMes) from Mes where idMes > @idMes
      end

      select @valor = @valor * 1.0065, @idAno += 1, @idMes = (select min(idMes) from Mes)
   end
end
go

-- Honda
declare @Ano01 smallint = (select min(descricao) from Ano)
declare @Ano02 smallint = (@Ano01 + 1), @Ano03 smallint = (@Ano01 + 2), @Ano04 smallint = (@Ano01 + 3), @Ano05 smallint = (@Ano01 + 4), @Ano06 smallint = (@Ano01 + 5)
declare @Ano07 smallint = (@Ano01 + 6), @Ano08 smallint = (@Ano01 + 7), @Ano09 smallint = (@Ano01 + 8), @Ano10 smallint = (@Ano01 + 9)

exec InserirVeiculoVendas 4700, @Ano01, 'CG 125', 'Honda', 'STD', 3
exec InserirVeiculoVendas 5350, @Ano03, 'CG 150', 'Honda', 'STD', 3
exec InserirVeiculoVendas 9300, @Ano07, 'CB 300', 'Honda', 'LS', 1

-- Yamaha
exec InserirVeiculoVendas 5200, @Ano02, 'XTZ 125', 'Yamaha', 'STD', 3
exec InserirVeiculoVendas 8200, @Ano04, 'XTZ 250', 'Yamaha', 'L', 2
exec InserirVeiculoVendas 21400, @Ano08, 'XT 660', 'Yamaha', 'STD', 1

-- Suzuki
exec InserirVeiculoVendas 27000, @Ano06, 'Bandit 650', 'Suzuki', 'GT', 3

-- Dafra
exec InserirVeiculoVendas 5250, @Ano01, 'Kansas 150', 'Dafra', 'LS', 1
exec InserirVeiculoVendas 3200, @Ano03, 'Zig 50', 'Dafra', 'STD', 1
exec InserirVeiculoVendas 10500, @Ano05, 'CityCom 300', 'Dafra', 'STD', 1

-- Kasinski
exec InserirVeiculoVendas 7500, @Ano02, 'Comet 250', 'Kasinski', 'GT', 2

-- BMW
exec InserirVeiculoVendas 37000, @Ano10, 'F800', 'BMW', 'GS', 2

-- Kawasaki
exec InserirVeiculoVendas 28000, @Ano10, 'Versys 650', 'Kawasaki', 'STD', 1

-- Harley-Davidson
exec InserirVeiculoVendas 45000, @Ano09, 'Fat Boy', 'Harley-Davidson', 'STD', 1



-- Criação de estruturas de tabelas
create table Cliente
(
idCliente tinyint identity primary key
, nome varchar(50) unique
, sexo bit
, dtNascimento date
)
go

create table Vendas2013
(
idVendas smallint identity(-32768, 1)
, idCliente tinyint
, idVeiculo smallint
, dataVenda date
, constraint pkVendas2013 primary key (idVendas)
, constraint fkVendas2013_idCliente foreign key (idCliente) references Cliente(idCliente)
, constraint fkVendas2013_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo)
)
go

create table Vendas2014
(
idVendas smallint identity(-32768, 1)
, idCliente tinyint
, idVeiculo smallint
, dataVenda date
, constraint pkVendas2014 primary key (idVendas)
, constraint fkVendas2014_idCliente foreign key (idCliente) references Cliente(idCliente)
, constraint fkVendas2014_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo)
)
go


create table Vendas2015
(
idVendas smallint identity(-32768, 1)
, idCliente tinyint
, idVeiculo smallint
, dataVenda date
, constraint pkVendas2015 primary key (idVendas)
, constraint fkVendas2015_idCliente foreign key (idCliente) references Cliente(idCliente)
, constraint fkVendas2015_idVeiculo foreign key (idVeiculo) references Veiculo(idVeiculo)
)
go

-- INSERT
insert Cliente values ('Ana Paula Batista de Souza', 0, '19790504')
insert Cliente values ('ELIANE APARECIDA DE BARROS DOS SANTOS', 0, '19800712')
insert Cliente values ('Manoella Neres Jubilato', 0, '19830705')
insert Cliente values ('Jon Anderson Andrade Costa', 1, '19750604')
insert Cliente values ('Denilson Alves de Lima', 1, '19700422')
insert Cliente values ('Francisco Andre Sousa Martins', 1, '19820514')
insert Cliente values ('Mauricio Nogueira da Silveira', 1, '19670108')
insert Cliente values ('Marlene Oliveira Rocha', 0, '19670313')
insert Cliente values ('Fernanda Rego Sacchi', 0, '19820802')
insert Cliente values ('Divane Dias dos Santos Nascimento', 0, '19770710')
insert Cliente values ('Eliete Silva Coutinho', 0, '19831014')
insert Cliente values ('EDUARDO JOSÉ PINTO', 1, '19820101')
insert Cliente values ('Juliana Moris Placco', 0, '19790806')
insert Cliente values ('Fabio Vinicius Rufo Menengoti ', 1, '19780216')
insert Cliente values ('Denise Cantisani', 0, '19731115')
insert Cliente values ('Pedro José Costa Costa', 1, '19841020')
insert Cliente values ('Giulianno Tavares Pinto da Silva', 1, '19750812')
insert Cliente values ('Luís Henrique Pirola', 1, '19720505')
insert Cliente values ('Fabricio Fernandes Osorio', 1, '19730107')
insert Cliente values ('Aline Cristine Leal Soares', 0, '19820405')
insert Cliente values ('Julio Carlos Maggioni Meng', 1, '19620407')
insert Cliente values ('Renata Bocchiglieri', 0, '19750816')
insert Cliente values ('carine ferreira de souza', 0, '19790321')
insert Cliente values ('Katia Regina Matias', 0, '19711110')
insert Cliente values ('Marcelo Yazbek', 1, '19670704')
insert Cliente values ('Luiz Claudio Taya de Araujo', 1, '19640628')
insert Cliente values ('Nilson José de Oliveira Junior', 1, '19691030')
insert Cliente values ('Marlon Sinelio Guimarães de Almeida', 1, '19731208')
insert Cliente values ('JOSÉ MARCO DA COSTA', 1, '19660725')
insert Cliente values ('Bruno Feitosa de Sousa', 1, '19761116')
insert Cliente values ('Bergson Benjamin de Melo Júnior.', 1, '19760907')
insert Cliente values ('Leandro Adell Ribeiro Faria', 1, '19800123')
insert Cliente values ('Mário Sérgio Thurler', 1, '19580923')
insert Cliente values ('Fabiana Setúbal Marques da Silva', 0, '19820922')
insert Cliente values ('JOÃO MARCOS BATISTA', 1, '19801009')
insert Cliente values ('Cristiani Hinghaus', 0, '19791101')
insert Cliente values ('Silvia Peron', 0, '19631124')
insert Cliente values ('ISIS OLIVEIRA DE SOUZA', 0, '19800831')
insert Cliente values ('Marcelo Jacobina Monte Alto', 1, '19770831')
insert Cliente values ('Mônica da Silva Lima Rosas', 0, '19700429')
insert Cliente values ('Fabio Jenkins Teixeira', 1, '19731013')
insert Cliente values ('Jadson Fabrício Lopes da Silva', 1, '19820417')
insert Cliente values ('Bruno Rodrigues Bezerra', 1, '19771222')
insert Cliente values ('Marcela Moscatelli de Carvalho', 0, '19800827')
insert Cliente values ('MÁRCIA REGINA ADIDIA', 0, '19640728')
insert Cliente values ('Helena Márcia Cota Ferreira', 0, '19780214')
insert Cliente values ('BRENO ALEXANDRE THOMAZ TAKAKURA', 1, '19760819')
insert Cliente values ('Alessandra Costa Cesar de Souza', 0, '19751129')
insert Cliente values ('Denise Aguiar Siqueira', 0, '19840105')
insert Cliente values ('Fernando Jorge Figueiredo Nazareth', 1, '19810721')


insert Vendas2013 values (47, 12, '20130706')
insert Vendas2013 values (5, 7, '20131202')
insert Vendas2013 values (20, 7, '20130227')
insert Vendas2013 values (41, 35, '20130905')
insert Vendas2013 values (16, 39, '20130702')
insert Vendas2013 values (42, 50, '20130328')
insert Vendas2013 values (18, 22, '20130924')
insert Vendas2013 values (48, 27, '20130520')
insert Vendas2013 values (33, 40, '20130822')
insert Vendas2013 values (32, 17, '20131007')
insert Vendas2013 values (43, 39, '20131027')
insert Vendas2013 values (40, 39, '20130710')
insert Vendas2013 values (42, 32, '20130119')
insert Vendas2013 values (25, 9, '20130917')
insert Vendas2013 values (10, 22, '20131126')
insert Vendas2013 values (38, 5, '20130513')
insert Vendas2013 values (49, 15, '20130808')
insert Vendas2013 values (17, 42, '20130920')
insert Vendas2013 values (41, 11, '20130115')
insert Vendas2013 values (18, 26, '20130320')
insert Vendas2013 values (43, 40, '20130520')
insert Vendas2013 values (45, 31, '20130416')
insert Vendas2013 values (17, 2, '20130613')
insert Vendas2013 values (4, 20, '20130710')
insert Vendas2013 values (13, 33, '20130827')
insert Vendas2013 values (36, 32, '20130816')
insert Vendas2013 values (17, 31, '20131211')
insert Vendas2013 values (44, 47, '20130515')
insert Vendas2013 values (23, 30, '20131205')
insert Vendas2013 values (37, 8, '20131219')
insert Vendas2013 values (5, 21, '20130411')
insert Vendas2013 values (18, 17, '20130720')
insert Vendas2013 values (14, 24, '20130914')
insert Vendas2013 values (43, 6, '20131026')
insert Vendas2013 values (8, 29, '20130403')
insert Vendas2013 values (39, 42, '20130208')
insert Vendas2013 values (42, 22, '20131011')
insert Vendas2013 values (41, 16, '20131014')
insert Vendas2013 values (49, 36, '20130522')
insert Vendas2013 values (11, 42, '20131002')
insert Vendas2013 values (16, 9, '20130602')
insert Vendas2013 values (46, 8, '20131101')
insert Vendas2013 values (39, 41, '20130624')
insert Vendas2013 values (5, 4, '20130205')
insert Vendas2013 values (17, 30, '20130213')
insert Vendas2013 values (23, 45, '20130326')
insert Vendas2013 values (24, 50, '20130216')
insert Vendas2013 values (41, 43, '20131107')
insert Vendas2013 values (18, 42, '20130905')
insert Vendas2013 values (8, 38, '20131108')
insert Vendas2013 values (28, 15, '20130721')
insert Vendas2013 values (15, 49, '20130319')
insert Vendas2013 values (32, 46, '20130427')
insert Vendas2013 values (6, 30, '20130509')
insert Vendas2013 values (3, 20, '20130718')
insert Vendas2013 values (9, 22, '20130304')
insert Vendas2013 values (5, 11, '20131002')
insert Vendas2013 values (49, 28, '20131113')
insert Vendas2013 values (34, 18, '20130625')
insert Vendas2013 values (13, 11, '20130514')
insert Vendas2013 values (7, 20, '20130817')
insert Vendas2013 values (8, 27, '20130209')
insert Vendas2013 values (3, 38, '20131210')
insert Vendas2013 values (32, 32, '20130213')
insert Vendas2013 values (26, 12, '20130126')
insert Vendas2013 values (17, 34, '20130822')
insert Vendas2013 values (22, 23, '20130214')
insert Vendas2013 values (47, 36, '20130417')
insert Vendas2013 values (35, 45, '20130815')
insert Vendas2013 values (15, 36, '20130922')
insert Vendas2013 values (20, 17, '20130922')
insert Vendas2013 values (10, 47, '20130522')
insert Vendas2013 values (24, 4, '20130821')
insert Vendas2013 values (14, 21, '20130928')
insert Vendas2013 values (8, 32, '20130918')
insert Vendas2013 values (44, 50, '20130417')
insert Vendas2013 values (40, 33, '20130409')
insert Vendas2013 values (48, 32, '20130921')
insert Vendas2013 values (7, 12, '20130615')
insert Vendas2013 values (5, 29, '20130703')


insert Vendas2014 values (4, 8, '20140305')
insert Vendas2014 values (45, 31, '20140913')
insert Vendas2014 values (36, 32, '20140328')
insert Vendas2014 values (9, 51, '20140910')
insert Vendas2014 values (25, 49, '20140926')
insert Vendas2014 values (7, 18, '20140102')
insert Vendas2014 values (34, 41, '20140110')
insert Vendas2014 values (24, 28, '20141020')
insert Vendas2014 values (29, 50, '20140715')
insert Vendas2014 values (17, 10, '20141108')
insert Vendas2014 values (7, 14, '20140323')
insert Vendas2014 values (34, 20, '20141106')
insert Vendas2014 values (33, 48, '20140219')
insert Vendas2014 values (1, 4, '20141114')
insert Vendas2014 values (28, 27, '20140107')
insert Vendas2014 values (8, 22, '20140827')
insert Vendas2014 values (40, 28, '20140410')
insert Vendas2014 values (47, 32, '20140601')
insert Vendas2014 values (12, 29, '20140408')
insert Vendas2014 values (7, 37, '20141215')
insert Vendas2014 values (24, 10, '20140323')
insert Vendas2014 values (8, 14, '20140609')
insert Vendas2014 values (1, 19, '20141114')
insert Vendas2014 values (9, 27, '20140103')
insert Vendas2014 values (32, 2, '20140417')
insert Vendas2014 values (9, 33, '20141109')
insert Vendas2014 values (23, 13, '20140927')
insert Vendas2014 values (36, 37, '20140813')
insert Vendas2014 values (15, 42, '20140326')
insert Vendas2014 values (1, 6, '20140217')
insert Vendas2014 values (17, 11, '20140507')
insert Vendas2014 values (22, 13, '20140307')
insert Vendas2014 values (24, 2, '20140108')
insert Vendas2014 values (45, 31, '20140518')
insert Vendas2014 values (28, 38, '20141221')
insert Vendas2014 values (18, 30, '20140425')
insert Vendas2014 values (36, 12, '20141022')
insert Vendas2014 values (40, 36, '20140308')
insert Vendas2014 values (34, 45, '20140922')
insert Vendas2014 values (45, 13, '20140418')
insert Vendas2014 values (44, 23, '20140628')
insert Vendas2014 values (2, 21, '20141005')
insert Vendas2014 values (29, 36, '20140709')
insert Vendas2014 values (33, 2, '20140327')
insert Vendas2014 values (39, 9, '20141005')
insert Vendas2014 values (18, 18, '20140925')
insert Vendas2014 values (40, 18, '20140110')
insert Vendas2014 values (12, 42, '20140327')
insert Vendas2014 values (37, 5, '20140218')
insert Vendas2014 values (42, 50, '20140221')
insert Vendas2014 values (29, 48, '20140701')
insert Vendas2014 values (21, 33, '20140920')
insert Vendas2014 values (16, 7, '20140708')
insert Vendas2014 values (25, 14, '20141006')
insert Vendas2014 values (6, 31, '20140817')
insert Vendas2014 values (31, 27, '20140713')
insert Vendas2014 values (46, 8, '20140210')
insert Vendas2014 values (32, 27, '20140426')
insert Vendas2014 values (17, 43, '20140404')
insert Vendas2014 values (16, 25, '20141220')
insert Vendas2014 values (23, 44, '20140704')
insert Vendas2014 values (20, 12, '20141212')
insert Vendas2014 values (19, 5, '20141208')
insert Vendas2014 values (23, 48, '20140916')
insert Vendas2014 values (6, 15, '20140907')
insert Vendas2014 values (25, 48, '20140722')
insert Vendas2014 values (27, 21, '20140428')
insert Vendas2014 values (25, 23, '20140728')
insert Vendas2014 values (27, 43, '20140524')
insert Vendas2014 values (10, 29, '20141208')
insert Vendas2014 values (31, 21, '20140224')
insert Vendas2014 values (49, 13, '20140227')
insert Vendas2014 values (36, 36, '20141001')
insert Vendas2014 values (37, 15, '20140719')
insert Vendas2014 values (43, 49, '20141104')
insert Vendas2014 values (47, 51, '20140213')
insert Vendas2014 values (26, 20, '20140118')
insert Vendas2014 values (2, 9, '20140306')
insert Vendas2014 values (40, 40, '20140715')
insert Vendas2014 values (13, 29, '20140317')
insert Vendas2014 values (13, 42, '20140222')
insert Vendas2014 values (26, 43, '20140619')
insert Vendas2014 values (42, 12, '20140115')
insert Vendas2014 values (22, 49, '20140625')
insert Vendas2014 values (15, 5, '20141014')
insert Vendas2014 values (25, 43, '20140717')
insert Vendas2014 values (29, 32, '20141003')
insert Vendas2014 values (34, 6, '20140105')
insert Vendas2014 values (11, 47, '20141213')
insert Vendas2014 values (48, 18, '20140222')
insert Vendas2014 values (5, 47, '20140719')
insert Vendas2014 values (19, 47, '20140821')
insert Vendas2014 values (36, 47, '20140416')
insert Vendas2014 values (1, 24, '20140414')
insert Vendas2014 values (46, 48, '20140622')
insert Vendas2014 values (11, 5, '20140206')
insert Vendas2014 values (45, 8, '20140817')
insert Vendas2014 values (24, 11, '20140908')
insert Vendas2014 values (46, 37, '20140519')
insert Vendas2014 values (32, 16, '20140909')
insert Vendas2014 values (1, 35, '20141011')
insert Vendas2014 values (31, 10, '20140621')
insert Vendas2014 values (42, 47, '20140209')
insert Vendas2014 values (37, 11, '20140811')
insert Vendas2014 values (33, 12, '20140310')
insert Vendas2014 values (14, 9, '20141010')
insert Vendas2014 values (21, 2, '20140302')
insert Vendas2014 values (43, 24, '20140612')
insert Vendas2014 values (18, 25, '20140322')
insert Vendas2014 values (25, 32, '20140815')
insert Vendas2014 values (15, 24, '20140320')
insert Vendas2014 values (46, 17, '20141015')
insert Vendas2014 values (46, 11, '20140610')
insert Vendas2014 values (47, 45, '20140524')
insert Vendas2014 values (29, 41, '20140807')
insert Vendas2014 values (11, 21, '20140515')
insert Vendas2014 values (5, 15, '20141017')
insert Vendas2014 values (5, 38, '20141001')
insert Vendas2014 values (36, 41, '20140424')
insert Vendas2014 values (39, 32, '20141122')


insert Vendas2015 values (23, 37, '20151021')
insert Vendas2015 values (45, 6, '20151002')
insert Vendas2015 values (24, 27, '20151002')
insert Vendas2015 values (26, 23, '20150117')
insert Vendas2015 values (47, 8, '20151008')
insert Vendas2015 values (16, 35, '20150927')
insert Vendas2015 values (6, 22, '20150923')
insert Vendas2015 values (24, 29, '20150314')
insert Vendas2015 values (9, 28, '20150907')
insert Vendas2015 values (39, 18, '20150423')
insert Vendas2015 values (21, 28, '20150711')
insert Vendas2015 values (16, 35, '20150619')
insert Vendas2015 values (14, 21, '20150409')
insert Vendas2015 values (29, 19, '20150928')
insert Vendas2015 values (35, 5, '20150524')
insert Vendas2015 values (32, 34, '20150316')
insert Vendas2015 values (49, 10, '20151009')
insert Vendas2015 values (15, 32, '20150214')
insert Vendas2015 values (9, 31, '20150427')
insert Vendas2015 values (8, 34, '20150424')
insert Vendas2015 values (43, 19, '20150914')
insert Vendas2015 values (23, 11, '20150410')
insert Vendas2015 values (39, 13, '20151015')
insert Vendas2015 values (23, 23, '20150823')
insert Vendas2015 values (38, 3, '20150508')
insert Vendas2015 values (7, 33, '20150605')
insert Vendas2015 values (38, 28, '20150228')
insert Vendas2015 values (15, 33, '20150214')
insert Vendas2015 values (18, 33, '20150313')
insert Vendas2015 values (40, 39, '20150308')
insert Vendas2015 values (39, 49, '20150222')
insert Vendas2015 values (44, 23, '20150427')
insert Vendas2015 values (19, 35, '20150420')
insert Vendas2015 values (29, 33, '20150508')
insert Vendas2015 values (8, 18, '20151120')
insert Vendas2015 values (45, 4, '20151123')
insert Vendas2015 values (41, 25, '20150811')
insert Vendas2015 values (44, 18, '20150418')
insert Vendas2015 values (47, 35, '20150224')
insert Vendas2015 values (5, 16, '20150928')
insert Vendas2015 values (48, 4, '20150911')
insert Vendas2015 values (36, 25, '20150526')
insert Vendas2015 values (35, 20, '20150914')
insert Vendas2015 values (17, 35, '20150922')
insert Vendas2015 values (21, 45, '20150223')
insert Vendas2015 values (10, 17, '20150507')
insert Vendas2015 values (42, 41, '20150222')
insert Vendas2015 values (26, 22, '20150825')
insert Vendas2015 values (6, 18, '20150321')
insert Vendas2015 values (30, 50, '20150316')
insert Vendas2015 values (16, 6, '20150518')
insert Vendas2015 values (6, 21, '20150727')
insert Vendas2015 values (15, 25, '20150409')
insert Vendas2015 values (6, 14, '20150221')
insert Vendas2015 values (39, 19, '20150918')
insert Vendas2015 values (42, 16, '20150709')
insert Vendas2015 values (42, 28, '20150817')
insert Vendas2015 values (40, 10, '20150617')
insert Vendas2015 values (33, 4, '20150926')
insert Vendas2015 values (18, 46, '20151124')
insert Vendas2015 values (30, 11, '20151120')
insert Vendas2015 values (21, 10, '20150918')
insert Vendas2015 values (25, 39, '20150824')
insert Vendas2015 values (18, 5, '20150302')
insert Vendas2015 values (31, 26, '20151025')
insert Vendas2015 values (5, 8, '20150710')
insert Vendas2015 values (32, 6, '20150613')
insert Vendas2015 values (47, 34, '20150206')
insert Vendas2015 values (44, 21, '20150421')
insert Vendas2015 values (19, 31, '20150604')
insert Vendas2015 values (27, 31, '20150920')
insert Vendas2015 values (28, 10, '20150618')
insert Vendas2015 values (9, 34, '20151118')
insert Vendas2015 values (10, 6, '20150327')
insert Vendas2015 values (22, 11, '20151121')
insert Vendas2015 values (17, 39, '20151028')
insert Vendas2015 values (27, 15, '20150706')
insert Vendas2015 values (4, 23, '20151209')
insert Vendas2015 values (44, 21, '20150827')
insert Vendas2015 values (47, 51, '20150826')
insert Vendas2015 values (3, 51, '20151005')
insert Vendas2015 values (48, 36, '20150405')
insert Vendas2015 values (12, 46, '20150815')
insert Vendas2015 values (30, 49, '20150406')
insert Vendas2015 values (21, 41, '20151005')
insert Vendas2015 values (21, 26, '20150820')
insert Vendas2015 values (49, 40, '20150101')
insert Vendas2015 values (9, 37, '20150505')
insert Vendas2015 values (18, 22, '20150822')
insert Vendas2015 values (4, 3, '20150307')
insert Vendas2015 values (5, 41, '20150711')
insert Vendas2015 values (35, 32, '20151103')
insert Vendas2015 values (28, 35, '20150801')
insert Vendas2015 values (7, 35, '20150709')
insert Vendas2015 values (42, 33, '20150611')
insert Vendas2015 values (47, 17, '20150808')
insert Vendas2015 values (32, 2, '20150326')
insert Vendas2015 values (35, 13, '20150912')
insert Vendas2015 values (28, 9, '20150312')
insert Vendas2015 values (7, 46, '20150720')





-- Selects
select * from Fabricante
select * from Modelo
select * from Ano
select * from Mes
select * from VendasAnuais
select * from Veiculo

-- Select 
select * from cliente
select * from Vendas2013
select * from Vendas2014
select * from Vendas2015


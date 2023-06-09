use consultorio
go

;with base(ra, nome) as (
	select '1601152', 'Wellington Serafim'
	union all select '1600892', 'Daywison Ferreira Leal'
	union all select '1601291', 'Alan Lazari'
	union all select '1601119', 'Eduardo Felipe Freitas Satyra'
	union all select '1601148', 'Lucas do Nascimento Galdino da Silva'
	union all select '1701091', 'Victor Correia de Campos'
	union all select '1701340', 'Mateus Yoshihito Teruya Sugimura'
	union all select '1701214', 'Vitor Hugo Lage Cabral'
	union all select '1701697', 'Diogo Barbosa Lima'
	union all select '1701362', 'Luis Henrique Miranda de Souza'
	union all select '1700431', 'Bruno Henrique Cipriano'
	union all select '1601538', 'Bruno Pereira dos Anjos'
	union all select '1600696', 'Izidio dos Santos Nascimento'
	union all select '1601140', 'Luciano Souza Cerqueira'
	union all select '1701499', 'Andr� Vogelsanger'
	union all select '1700431', 'Bruno Henrique Cipriano dos Santos'
	union all select '1701717', 'Felipe Gomes de Farias Costa'
	union all select '1701768', 'Mauricio Rodrigues de Sousa'
	union all select '1701301', 'Michel Cortinovis Perin'
	union all select '1700776', 'Vinicius Foga�a'
	union all select '1700640', 'Kaique Melo'
	union all select '1601283', 'Raphael Darlan'
	union all select '1700101', 'Bruna de Paula Taveiros'
	union all select '1700582', 'L�dia Rodrigues da Silva Santos'
	union all select '1601538', 'Bruno Pereira dos Anjos'
	union all select '0', 'Izidio Nascimento'
	union all select '1601140', 'Luciano Cerqueira'
	union all select '8240001', 'Dilson Rainov'
	union all select '1700781', 'Gabriel Alex O. Rezende'
	union all select '1700235', 'Liber Ferraz'
	union all select '1701556', 'Andr� Victor Santos'
	union all select '1701489', 'Oct�vio Duarte'
	union all select '1701081', 'Ot�vio Capel'
	union all select '1701533', 'Patr�cia de Andrade'
	union all select '1600567', 'Bruno Sanchez Miguel'
	union all select '1700617', 'Cesar Augusto D. de Paula'
	union all select '1700531', 'Diego Silva Alc�ntara'
	union all select '1700709', 'Giovane Pereira'
	union all select '1700791', 'Rafael Fernandes Fran�a'
	union all select '1600933', 'Bernardo Ribeiro Generozo'
	union all select '1600509', 'Elis Regina Fernandes Machado'
	union all select '1601199', 'Gabrielle dos Santos Dias'
	union all select '1601101', 'Samara de Jesus Sant�Ana'
	union all select '1510712', 'Lucas Nascimento Leite'
	union all select '1701065', 'Charles Comege de Queiroz'
	union all select '1520030', 'Georges Montgomery Lopes Silva Filho'
	union all select '1701751', 'Gustavo Arruda'
	union all select '1701772', 'Lucas de Souza'
	union all select '1601292', 'Orlando Castilho Neto'
	union all select '1800549', 'Rafael Mazas Martinez'
	union all select '1701524', 'Thiago Ribeiro da Silva'
	union all select '1701718', 'Alvaro Jesus Soria Quispe'
	union all select '1701169', 'Giuseppe de Oliveira Rosa'
	union all select '8105058', 'Pedro H. Vicente Campoamor'
	union all select '1701613', 'Thiago Reis Sim�es'
	union all select '1700144', 'Victor Braga Ramos'
	union all select '1701692', 'Yago de Barros Martins Pereira'
	union all select '1510552', 'Alexandre de Marco Andrade'
	union all select '1600646', 'Alexandre Vieira de Souza'
	union all select '1520337', 'Cleiton Marques Queiroz'
	union all select '1510609', 'Leonardo Dias Moraes'
	union all select '1520344', 'Paulo Henrique Soares'
	union all select '1700713', 'Bruno Lima dos Santos'
	union all select '1700525', 'Isaque Felizardo'
	union all select '1700262', 'Lucas Alves Siqueira'
	union all select '1700424', 'Lucas Araujo de Oliveira'
	union all select '1700239', 'Nayara de Paula Muniz'
	union all select '1700266', 'Vitor Crepaldi Carlessi"'
	union all select '1700365', 'Ana Paula Lopes'
	union all select '1701394', 'Caio Henrique de Melo Moreira'
	union all select '1700384', 'Isabella Azumi Anze'
	union all select '1700699', 'Isabella Penteado Picirillo Voso'
	union all select '1700254', 'Johnny de Jesus dos Santos'
	union all select '1700073', 'Vinicius Lucas Silvestre'
	union all select '1700135', 'Fillipe Borges'
	union all select '1700784', 'Alisson Ferrari'
	union all select '1700824', 'Gabriel Geoge'
	union all select '1700726', 'Lucas Marques'
	union all select '1700238', 'Lucas Amorim de Lima'
	union all select '1700073', 'Vinicius Lucas Silvestre'
	union all select '1700729', 'Felipe Sim�es'
	union all select '1700785', 'Maria Cec�lia'
	union all select '1520284', 'Mauricio de Souza da Silva'
	union all select '1701565', 'Fabiana Vicente Barboza Gomes'
	union all select '1701478', 'Rayssa Maria de Araujo Neves Chaves"'
	union all select '1701344', 'Ariadne Moreira Caetano'
	union all select '1701695', 'Fabricio Belam'
	union all select '1700953', 'Paulo Pavan Damasco'
	union all select '1701070', 'Vinicius Gomes da Silva'
	union all select '1520339', 'Alexandre Brandizzi'
	union all select '1510622', 'Ingrid Stofalete'
	union all select '1510607', 'Julio Cesar'
	union all select '1510654', 'Karol Cruz'
	union all select '1510512', 'Vinicius Luiz'
	union all select '1510634', 'Wilder Roberto'
	union all select '1600924', 'Renan Santana Garcia'
	union all select '1601370', 'Ana Carolina Nunes da Cruz'
	union all select '1601013', 'Anderson Jord�o Gonzalez Brito'
	union all select '1601446', 'Evandro Concei��o da Silva'
	union all select '1601145', 'Francieli Gon�alves da Silva'
	union all select '1601301', 'Andr� Poleto Corvetto'
	union all select '1601188', 'Andrew Renan Longo'
	union all select '1601071', 'B�rbara Cristina Florencio Duque'
	union all select '1601458', 'Cristopher Frederico Klein'
	union all select '1600512', 'Nath�lia Ribeiro Ferreira Lima'
	union all select '1600893', 'Vin�cius Fabris Leite Victorino'
	union all select '1601215', 'Wellington dos Santos Ramalho'
	union all select '1700629', 'Kevin da Silva Prado'
	union all select '1701259', 'Jose Ricardo de Melo Cruz Fernandes'
	union all select '1700811', 'Guilherme Alcantara Mendes'
	union all select '1700055', 'Vinicios Ziroldo Gomes'
	union all select '1700637', 'Icaro Guedes dos Santos Oliveira'
	union all select '1700092', 'Gustavo Henrique Crisostomo Serafim'
	union all select '1701785', 'Giovanni Paulo da Cunha'
	union all select '1701603', 'Carolina Nakau Fuzissaki'
	union all select '1701170', 'Gabriel Venditti Barreira'
	union all select '1700971', 'Guilherme Dias Fonseca'
	union all select '1701804', 'Guilherme Yuki'
	union all select '1701080', 'Leonardo Correia Gon�alves'
	union all select '1700572', 'Jeferson Rubio de Oliveira'
	union all select '1601121', 'Luana Woidella'
	union all select '1601286', 'Bruno Guerra'
	union all select '1601073', 'Gabriela Cardoso'
	union all select '1601162', 'Guilherme Gaspar'
	union all select '1601003', 'Felipe Amaral'
	union all select '1601129', 'Leonardo Bernardes'
	union all select '1601372', 'Rafael Haha'
	union all select '1601300', 'Felipe Cleto'
	union all select '1601334', 'Alexandre Borges'
	union all select '1601175', 'Alan Batista Agostinho'
	union all select '1601220', 'Daniel Rezende da Silva'
	union all select '1600916', 'Jos� Evandro Ten�rio Barbosa"'
	union all select '1701467', 'Marcos Vinicius Alves de Souza'
	union all select '1701253', 'Marcos Viana de Souza'
	union all select '1701580', 'Marcio Felipe Tomaz Gonzaga'
	union all select '1701769', 'Tassio Pereira Lima'
	union all select '1701391', 'Jefferson Dong Min Kwak'
	union all select '1701870', 'Lucas Leite'
	union all select '1701266', 'Rafael Cunha Ribeiro'
	union all select '1701431', 'Peterson Possidonio'
	union all select '1701290', 'Abel Separovich'
	union all select '1701427', 'Maur�cio Barbosa de Queiros J�nior'
	union all select '1800357', 'Fabr�cio Werneck'
	union all select '1600936', 'Victor Tolesano'
	union all select '1701219', 'Matheus de Alc�ntara Silva'
	union all select '1701179', 'Alexandre da Costa Tavares  Jr.'
	union all select '1700942', 'Josu� dos Santos Silva Orlando'
	union all select '1701057', 'Leonardo Pedro de Sousa'
	union all select '1701448', 'Diogo Roberto Ramos Ferrari'
	union all select '1600230', 'Paula Gabriela da Silva Nascimento'
	union all select '1701738', 'Nicholas Lima Leite'
	union all select '1701442', 'Fl�vio Santos'
	union all select '1700738', 'Danilo Cicotti Gallesco'
	union all select '1700666', 'Brenda Karina Mendes'
	union all select '1600713', 'Paola Cristine de Castro'
	union all select '1700358', 'Maria Arislani de Oliveira'
	union all select '1700106', 'Andressa da Silva Medeiros'
	union all select '1700389', 'Jonathas Josemar Santos Fermino'
	union all select '1701728', 'Vitor Hugo Gerace e Borges'
	union all select '1701339', 'Lucas Macedo Santos'
	union all select '1701368', 'Evellyn Silva Araujo'
	union all select '1701763', 'Jaqueline Ribeiro dos Santos'
	union all select '1701013', 'Rodolfo de Oliveira Goulart'
	union all select '1701403', 'Vinicius Leonardo da Silva Aguiar Henrique'
	union all select '1800408', 'Bruno Silva Iwamura'
	union all select '1701339', 'Lucas Macedo Santos'
	union all select '1510185', 'Caique Ferreira'
	union all select '1510550', 'Claudio Vinicius Rosalin da Silva'
	union all select '1510626', 'Marcos Bonaventura Porto'
	union all select '1510284', 'Wendel Ferreira de Oliveira'
	union all select '1600085', 'Victor Augusto Pereira Dias Nicola"'
	union all select '1700492', 'Allan M�ximo Rosa Turatti'
	union all select '1700532', 'Gerson Ito Hashimoto'
	union all select '1700174', 'Gregory In�cio de Oliveira'
	union all select '1700295', 'Lucas Gomes de Souza'
	union all select '1700273', 'Ozias Soares da Costa'
	union all select '1700166', 'Rafael Yuji Takara'
	union all select '1700654', 'Gabriela Camargo Conde de Almeida'
	union all select '1700190', 'Emerson Silva Carbonaro'
	union all select '1700238', 'Jose Renato Santana Santos'
	union all select '1700761', 'Cleiton Souza Andrade"'
	union all select '1700733', 'Valdecy Longo'
	union all select '1700104', 'Fernanda Sipriano'
	union all select '1701370', 'Dennise Appelt Rodrigues'
	union all select '1701288', 'Lucas Mello Pires'
	union all select '1701342', 'Felipe Fiorin da Silva Pinto'
	union all select '1701621', 'Igor Meira Diani'
	union all select '1701799', 'Rodrigo Ribeiro Rossi'
	union all select '1700992', 'Karina Lino Ver�ssimo'
	union all select '1200755', 'Felipe dos Santos Serapi�o'
	union all select '1701359', 'Hugo Dias Souza'
	union all select '1701328', 'Mike Ant�nio do Santos'
	union all select '1701705', 'Everton Rodrigo'
	union all select '1701553', 'Shiley da Silva'
	union all select '1701691', 'Jo�o Victor Molina Lage'
	union all select '1701330', 'Matheus Freire dos Santos'
	union all select '1701773', 'Venancio de Jesus'
	union all select '1700678', 'Gabriel Silva Brito'
	union all select '1600972', 'Leonardo Negreiros'
	union all select '1601329', 'Edna Lins Leite'
	union all select '1600685', 'Maria Nunes dos Santos'
	union all select '1601029', 'Yago Coghi Ferlin'
	union all select '1600899', 'Sergio de Lima Concei��o'
	union all select '1601278', 'Hudson Evaldo Laube'
	union all select '1600105', 'Diego Miller do Nascimento'
	union all select '1700548', 'Bruno Tomas Santos Buzzo'
	union all select '1700576', 'Eduardo Correia dos Santos'
	union all select '1700553', 'Evandro Ferraz Moreira'
	union all select '1700547', 'Gabriel Alves Pereira'
	union all select '1700084', 'Henrique Ambroselli Saula'
	union all select '6111271', 'Leandro Silva Crudo'
	union all select '1700200', 'Leanardo Trindade'
	union all select '1700558', 'Lucas Gomes Silva'
	union all select '1701470', 'Marina Aparecida Fagundes Souza'
	union all select '1700552', 'Pedro Henrique Alves Scavacini da Silva'
	union all select '1700550', 'Yasmin de Laia Gallante'
	union all select '1510137', 'Andr� Felipe Ricarti'
	union all select '1510625', 'Elza Pereira dos Santos'
	union all select '1510683', 'Gregory de Paula Gouveia'
	union all select '1510289', 'Luiz Felipe Guterville Giachetta'
	union all select '1510249', 'Luiz Fernando Bezerra de Jesus'
	union all select '1510538', 'Murilo Precerutti'
	union all select '1520138', 'Gustavo Balieiro Felipe'
	union all select '1700122', 'Felipe Velozo Flores Belo'
	union all select '1700650', 'Adilson Candido de Ara�jo'
	union all select '1700620', 'Michael Jordan C.Santana'
	union all select '1201608', '�nio Ferreira JR.'
	union all select '1700665', 'Lucas Rodrigues Cirino Andrade'
	union all select '1200560', 'Vinicius Norberto Casellato dos Santos'
	union all select '1701518', 'Guilherme Moreira da Natividade'
	union all select '1701294', 'Nicolas da Silva Rezende'
	union all select '1800911', 'Vitoria Chacon de Carvalho'
	union all select '1601352', 'F�bio de Lima Le�o'
	union all select '1701485', 'Denis Felipe dos Santos'
	union all select '1701215', 'Diego Gomes Freire'
	union all select '1701375', 'Victor Hugo Oliveira do Prado'
	union all select '1700525', 'Isaque Felizardo'
	union all select '1700631', 'Leandro Santana'
	union all select '1600684', 'Alini Machado de Oliveira'
	union all select '1701217', 'Douglas Turque da Silveira'
	union all select '1700546', 'Guilherme Ribeiro'
	union all select '1700108', 'Marcos Vinicius Zamboni'
	union all select '1700012', 'Nicolas Cesar Alves'
	union all select '1701551', 'Paulo Roberto da Silva'
	union all select '1701608', 'Rog�rio Augusto Machado Henriques'
	union all select '1510518', 'Victor Yuri Fernandes da Silva'
	union all select '1700164', 'Felipe Pereira de Almeida'
	union all select '1700615', 'Lucas dos Santos Fonseca'
	union all select '1700687', 'Mateus Watanabe'
	union all select '1700364', 'Matheus Macedo'
	union all select '1700134', 'Taina de Oliveira Macedo'
	union all select '1700760', 'Ariel Fernandes'
	union all select '1700727', 'Gabriel Messias'
	union all select '1700741', 'Victor Freitas'
	union all select '1701303', 'Thiago Fernandes Couve'
	union all select '1701653', 'Markus Henrique Kholroser Castro'
	union all select '1701232', 'Vinicius da Silva Costa'
	union all select '1701184', 'Igor Silva dos Santos'
	union all select '1701682', 'Jos� Eduardo Nogueira'
	union all select '1701591', 'Felipe Almeida Lucas'
	union all select '1700604', 'Bruno Camargo Zaccariello'
	union all select '1701749', 'Davison Casagrande'
	union all select '1701596', 'Rodrigo Sena de Oliveira'
	union all select '1700382', 'Gabriel Aubert Costa'
	union all select '1700652', 'Kau� Ramires Ribeiro'
	union all select '1700653', 'Natalia  Nadgela Silva Gon�alves'
	union all select '1700642', 'Victor Vinicius G. Barbosa'
	union all select '1411002', 'Guilherme Neri de Souza'
	union all select '6112501', 'Lucas Dominiciano Neves'
	union all select '1701567', 'Jeferson Alves Fabricio'
	union all select '1600744', 'Marlon de Lima Boschi'
	union all select '1701060', 'Edio Gama Filho'
	union all select '1700658', 'Wesley Marques de Santana'
	union all select '1701459', 'Rechadson Silva de Lucena'
	union all select '1701552', 'Andr� Vicente de Oliveira Silva'
	union all select '1701637', 'Fernando Lemos de Carvalho Junior'
	union all select '1701481', 'Kalel Weyne Oliveira Veloso'
	union all select '1701451', 'Diego Mendes Veloso'
	union all select '1601383', 'Antonio Lee'
	union all select '1600890', 'Artur Folk'
	union all select '1601054', 'Felipe Cardoso'
	union all select '1601232', 'Leonardo de Brito'
	union all select '1601260', 'Yuri Gomes'
	union all select '6109951', 'Diego Teixeira Marcos Sousa'
	union all select '6105246', 'Felipe Neves Ferreira'
	union all select '1700054', 'Henrique Borges'
	union all select '1700381', 'Michael da Silva'
	union all select '1700603', 'Fabio Aur�lio'
	union all select '1700072', 'Alex Augusto'
	union all select '1700693', 'Cinthia Queiroz'
	union all select '1601606', 'Gabriel Bueno'
	union all select '1601030', 'Anderson Santos'
	union all select '1601299', 'Beatriz Vicente'
	union all select '1600953', 'Juliano Holtz'
	union all select '1601086', 'Wellington Sampaio'
	union all select '1601102', 'Jonathan Alves'
	union all select '1600538', 'Marcos Roberto'
	union all select '1520133', 'Thiago Rold�o'
	union all select '1700808', 'Renato Colodro Barbosa'
	union all select '1700804', 'Vitor Bella Lorente'
	union all select '1700608', 'Victor Hugo Camilo"'
	union all select '1601110', 'Kathleen Saraiva'
	union all select '1601116', 'Leonardo Oliveira'
	union all select '1600982', 'Victor Festine'
	union all select '1601053', 'Vitor seiti GANIKO'
	union all select '1601150', 'Rodrigo Moura'
	union all select '1020056', 'Reinaldo'
	union all select '1601092', 'Bruno Melo Silva'
	union all select '1701604', 'Cristopher Crispim Dos Santos'
	union all select '1600518', 'Isadora Soares Martins'
	union all select '1701626', 'Jo�o Vitor Leite Filismino'
	union all select '1701612', 'Kaio Vinicius Hursan'
	union all select '1701607', 'Vinicius K. Costa'
	union all select '1701289', 'Rafael Turra Silva'
	union all select '1701666', 'William Souza Yun'
	union all select '1701265', 'Matheus Souza'
	union all select '1410018', 'Marjorie Oliveira'
	union all select '1701627', 'Vinicius de Abreu'
	union all select '1701098', 'Daniela Martins'
	union all select '1701304', 'Rodrigo'
	union all select '1601540', 'Elen Magalhaes'
	union all select '1600147', 'Guilherme Maciel'
	union all select '1600425', 'Guilherme Moura'
	union all select '1600887', 'Pedro baraldini'
	union all select '1700275', 'Thiago Leme"'
	union all select '1700575', 'Andr� da Silva Sousa'
	union all select '1700539', 'Lucas da Silva de Lavor'
	union all select '1510605', 'Rodrigo Teixeira dos Santos'
	union all select '1510141', 'Caique Gabriel Eloy'
	union all select '1510666', 'Larissa Trindade'
	union all select '1510053', 'Bruno do Carmo Leal Pereira'
	union all select '1601072', 'Bruno Valezzi'
	union all select '1601342', 'Leonardo Mina'
	union all select '1600994', 'Lucas Camargo'
	union all select '1601197', 'Maria Luiza Felix'
	union all select '1601543', 'Rodrigo Domingos da Silva'
	union all select '1600901', 'Vitor Mendes dos Santos'
	union all select '1601072', 'Victor Prado'
	union all select '1700833', 'Luiz Oliveira'
	union all select '1700087', 'Eduardo Ramos'
	union all select '1700066', 'Felipe Feitosa'
	union all select '0', 'Daniel Massato'
	union all select '1700660', 'Eduardo Ferreira'
	union all select '1700184', 'Geibson'
	union all select '1700298', 'Leonardo Hernandes do Quental'
	union all select '1700661', 'Lucas Lujan de Bem'
	union all select '1601242', 'Lucas de Souza'
	union all select '1700780', 'Priscila Beraldi'
	union all select '1700779', 'Matheus Xavier'
	union all select '1700462', 'Osmar Beltr�o Quaresma Junior'
	union all select '1111082', 'Fernando Oliveira Paulino'
	union all select '1700219', 'Os�as Silva Fernandes'
	union all select '1700020', 'Cesar Augusto Pimenta'
	union all select '1700700', 'Vinicius Tavares'
	union all select '1700742', 'Rodrigo Ferreira'
	union all select '1700162', 'Ricardo Sim�es'
	union all select '1700493', 'Marcos Antonio'
	union all select '1700251', 'Wallace de paula Souza'
	union all select '1700690', 'Victor Kiill'
	union all select '1601069', 'Jessica Xavier Celestrino'
	union all select '1601288', 'Isabela Baroni'
	union all select '1601143', 'Murilo Castro'
	union all select '1601295', 'Lucas Souza'
	union all select '1601296', 'Jhonatan Nunes'
	union all select '1600974', 'Stefany Caetano'
	union all select '1700715', 'Victor Enrico S. Codonho'
	union all select '1700768', 'Victor Souza'
	union all select '1700167', 'Andre Tagino'
	union all select '1600971', 'Blenda Leite'
	union all select '1700271', 'Melissa Amelia'
	union all select '1701264', 'Jonatas Silva'
	union all select '1600411', 'Erick do Nascimento Feitosa'
	union all select '1600071', 'Lucas Aparecido de Souza Bonavina'
	union all select '1701088', 'Arlei da Silva Verga'
	union all select '1701731', 'Vinicius dos Reis Oliveira'
	union all select '1701490', 'Victor Maciel Bastos'
	union all select '1701601', 'Daniel Carvalho Blanco'
	union all select '1701148', 'Douglas Vanelli Gomes de Araujo'
	union all select '1701124', 'Jade Midori Kitagawa'
	union all select '1701521', 'Felipe dos Santos'
	union all select '1701544', 'Jo�o Paulo de Sousa'
	union all select '1701077', 'Nicolas Batista'
	union all select '1701523', 'Matheus Penha Pita'
	union all select '1701561', 'Fabiano Ferro'
	union all select '1701117', 'Matheus Neri de Brito'
	union all select '1701509', 'David dos Santos Leite'
	union all select '1701302', 'William Britez Pinto'
	union all select '1701506', 'Amanda Merien Cristina Silva'
	union all select '1701322', 'Marcelo Nunes Sergio"'
	union all select '1700591', 'Gustavo Zaik Fretas'
	union all select '1700646', 'Jhonatan Rafael Brasileiro de Ara�jo'
	union all select '1601603', 'Jo�o Carlos S. da Costa'
	union all select '1601604', 'Daniel Ibiapina Nunes'
	union all select '1700706', 'Luka Gabriel C. Santos'
	union all select '1201915', 'Rafael Lima da Silva'
	union all select '1520075', 'Kleber Felipe de Souza Oliveira'
	union all select '1700756', 'Ivo Santana Santos'
	union all select '1701593', 'Gustavo Tonin'
	union all select '1701416', 'Isaac Oliveira Benites'
	union all select '1701348', 'Jo�o Victor Pires Vilela Corr�a'
	union all select '1701008', 'Luiz Gustavo Parolin Ortega'
	union all select '1700997', 'Ot�vio Sanches Bissoli Zaia'
	union all select '1701480', 'Rodrigo Henrique Ramos de Carvalho'
	union all select '1701456', 'Vinicius Gon�alves de Oliveira'
	union all select '1700314', 'Luan Millian Gon�alves de Souza Fonseca'
	union all select '1701802', 'Luiz Henrique Lindner'
	union all select '1701510', 'Guilherme Felipe de Oliveira'
	union all select '1701793', 'Matias Nilsson da Silva'
	union all select '1701716', 'Pablo Ferreira Pinto'
	union all select '170025', 'Danilo Lopes do Nascimeto'
	union all select '1700393', 'Everton Ricardo Alauk Freire'
	union all select '1700286', 'Pedro Vinicius Rodrigues Furlan'
	union all select '1700696', 'Luan de Oliveira Pereira'
	union all select '1700722', 'Roberto Bello de Souza Ferreira'
	union all select '1700357', 'Rikke Mori Takatu'
	union all select '1601176', 'Carlos Henrique Sousa Rodrigues'
	union all select '1700156', 'Lucas Rodrigues Medina Costa'
	union all select '1700470', 'Henrique Lima Margarido'
	union all select '1510007', 'J�ssica de Oliveira Campos Piva'
	union all select '1510704', 'Willian Pires Concei��o'
	union all select '1410597', 'Tha�s Regina Soares'
	union all select '1510056', 'Beatriz Maciel'
	union all select '1510411', 'Cicero Roberto Soares'
	union all select '1520364', 'Felipe Videira'
	union all select '1700750', 'GILDO DA SILVA CAVALCANTI'
	union all select '1601281', 'WILLIAN KAUE SARAIVA"'
	union all select '1701747', 'Ana Caroline'
	union all select '1701539', 'Pamela Costa'
	union all select '1701750', 'Robsoncler Rocha'
	union all select '1700619', 'Andr� Galdino Arruda'
	union all select '1700645', 'Lucas Lopes Labliuk Leme'
	union all select '1700159', 'Victor de Carvalho Louren�o'
	union all select '1701073', 'Gabriel Rodrigues'
	union all select '1701150', 'Gabriela Vitoria Tolintino Gomes'
	union all select '1701386', 'Guilherme Veneziano Miotto'
	union all select '1701151', 'Kallyne Barbosa Ferreira dos Santos'
	union all select '1700972', 'Michael Abreu de Santana'
	union all select '1701404', 'Nicolas Matos Cardozo'
	union all select '1700948', 'Matheus Ferreira Nunes'
	union all select '1701173', 'Thiago Timoteo da Silva'
	union all select '1700429', 'Reginaldo Rodrigues Barbosa'
	union all select '9100496', 'Rodrigo Soares Leite'
)
INSERT INTO Paciente ( telefone, nome )
select left('9'+convert(varchar,convert(int,ra*rand())),9), nome
from base
GO
INSERT INTO sala ( numero )
select convert(int,rand()*1000)%999
GO 10
INSERT INTO MEDICO (CRM, Nome, Especialidade)
values	( '22322', 'Mauricio Junqueira', 'Clinico Geral')
,		( '17544', 'Igor de Bastos Schmidt', 'Pediatra')
, 		( '88666', 'Camila Andrade Pereira', 'Obstetra')
, 		( '64564', 'Adamastor Damaceno Pedreira', 'Cardiologista')
, 		( '23577', 'Mauricio Gomes dos Santos', 'Obstetra')
, 		( '98567', 'Dorival Modesto da Silva', 'Obstetra')
, 		( '65867', 'Patricia Gomes dos Santos', 'Pediatra')
GO
INSERT INTO Consulta (ID_Paciente, ID_Medico, Numero_Sala, DataHora, Duracao )
SELECT	(select top 1 paciente.id from paciente order by newid())
	,	(select top 1 medico.id from medico order by newid())
	,	(select top 1 sala.numero from sala order by newid())
	,	(dateadd(minute,(convert(int,rand()*2553)%4)*15,
			dateadd(hour, (convert(int,rand()*2553)%8)+8,
				convert(datetime
					,dateadd(day,-1*convert(int,rand()*1000),convert(date,getdate()) )
				)
			)
		 )
		) 
	, ((convert(int,rand()*2553)%2)+1)*15
GO 1000000
		









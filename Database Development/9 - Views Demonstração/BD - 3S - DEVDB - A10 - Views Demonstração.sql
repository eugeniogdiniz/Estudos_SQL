------------------------------------------------------------------------------------------
-- Views Demonstra��o
------------------------------------------------------------------------------------------


---------------------
-- Demonstra��o 1
---------------------
-- Base TSQL

-- 1.1 Mostrar Object Explorer - View
--  1.1.1 Mostrar a chamada de uma View
--  1.1.2 Mostrar o conte�do de uma View
--  1.1.3 Mostrar Dynamic Management Views


-- 1.2 Mostrar sys.views
--  1.2.1 Monstrar sys.objects
---------------------



---------------------
-- Demonstra��o 2
---------------------
-- Base Concessionaria
-- 2. Criar vis�o com o exerc�cio passado
-- Subquery autosuficiente
select 	*
from  	VendasAnuais 
where 	idVeiculo = (
					select	idVeiculo
					from	Veiculo
					where	valor = 28011.00
					)

-- Subquery Correlacionada
select 	*
from  	Fabricante as F
where	exists  (
                select  *
				from    Veiculo as V
                where   V.idFabricante = F.idFabricante
                        and exists  (
                                    select  *
                                    from    VendasAnuais as VA
                                    where   VA.idVeiculo = V.idVeiculo
                                    group by VA.idVeiculo
                                    having sum(qtd) >= 7500
                                    )
				)
order by F.Nome




---------------------

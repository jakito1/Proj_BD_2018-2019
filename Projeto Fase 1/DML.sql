/*********** Participantes ***********/

create view view_Participantes as 
	select Par_nregisto, Par_nome, Par_idade
    from mydb.participantes
    where Par_nome like 'R%' and Par_idade between 14 and 21
    order by Par_nregisto asc;

/*********** Oradores ***********/

create view view_Oradores as
	select Ora_nregisto, Ora_nome
    from mydb.oradores
    where Ora_nome like 'R%' or Ora_nome like 'V%'
    order by Ora_nregisto asc;

/*********** Atividades ***********/

create view view_Atividades as
	select Ati_nregisto, Ati_sala, Ati_tipo
    from mydb.atividades
    where Ati_sala not like 'A1' and Ati_tipo like 'torneio'
    order by Ati_nregisto asc;

/*********** Programa dos eventos ***********/

create view view_Programa as 
	select Eve_nome, Eve_local, Eve_data, Ati_sala, Ati_começo, Ati_final, Ati_tipo
    from mydb.atividades
    inner join mydb.eventos on atividades.Ati_Eve_nregisto = eventos.Eve_nregisto
    where Eve_nome not like '%RPG%' and Eve_local like 'Lisboa' and Eve_data between '2019-05-01' and '2019-05-31'
    order by Eve_nome asc;

/*********** Avaliações das atividades ***********/

create view view_Avaliações as
	select Ins_Ati_registo as atividade, Ins_avaliação as avaliação
    from mydb.inscritos
    order by atividade asc;

/*********** Avaliações dos eventos ***********/

create view view_Evento_Avaliações as
	select Eve_nome as Evento, Ins_Ati_registo as Atividade, Ins_avaliação as Avaliação
    from mydb.eventos
    inner join mydb.atividades on eventos.Eve_nregisto = atividades.Ati_Eve_nregisto
    inner join mydb.inscritos on atividades.Ati_nregisto = inscritos.Ins_Ati_registo
    where Eve_nome like 'Shooters para noobs'
    order by Ins_Ati_registo asc;

/*********** Estatisticas das Atividades ***********/

create view view_Atividade_Stats as
	select avg(a.num) as media, max(a.num) as maximo, min(a.num) as minimo, stddev(a.num) as desvio
    from (select count(Ins_Par_nregisto) as num from mydb.inscritos group by Ins_Ati_registo) as a;

/*********** Estatisticas dos Eventos ***********/

create view view_Evento_Stats as
	select avg(a.num) as media, max(a.num) as maximo, min(a.num) as minimo, stddev(a.num) as desvio
    from (select count(Ins_Par_nregisto) as num from mydb.inscritos inner join atividades on inscritos.Ins_Ati_registo = atividades.Ati_nregisto
		inner join eventos on atividades.Ati_Eve_nregisto = eventos.Eve_nregisto group by Eve_nregisto) as a;

    

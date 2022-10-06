use projeto;

/********************* Selects *********************/

/*********** Participantes ***********/

select Par_nregisto, Par_nome, Par_idade
from projeto.participantes
where Par_nome like 'R%' and Par_idade between 14 and 21
order by Par_nregisto asc;

/*********** Oradores ***********/

select Ora_nregisto, Ora_nome
from projeto.oradores
where Ora_nome like 'R%' or Ora_nome like 'V%'
order by Ora_nregisto asc;

/*********** Atividades ***********/

select Ati_nregisto, Ati_sala, Ati_tipo
from projeto.atividades
where Ati_sala not like 'A1' and Ati_tipo like 'torneio'
order by Ati_nregisto asc;

/*********** Programa dos eventos ***********/

select Eve_nome, Eve_local, Eve_data, Ati_sala, Ati_começo, Ati_final, Ati_tipo
from projeto.atividades
inner join projeto.eventos on atividades.Ati_Eve_nregisto = eventos.Eve_nregisto
where Eve_nome not like '%RPG%' and Eve_local like 'Lisboa' and Eve_data between '2019-05-01' and '2019-05-31'
order by Eve_nome asc;

/*********** Avaliações das atividades ***********/

select Ins_Ati_registo as atividade, avg(Ins_avaliação) AS média, max(Ins_avaliação) AS máximo, min(Ins_avaliação) AS minimo, stddev(Ins_avaliação)
as desvio from inscritos group by Ins_Ati_registo;

/*********** Avaliações dos eventos ***********/

select Eve_nome as Evento, avg(Ins_avaliação) AS média, max(Ins_avaliação) AS máximo, min(Ins_avaliação) AS minimo, stddev(Ins_avaliação) as desvio
from eventos inner join atividades on Eve_nregisto = Ati_Eve_nregisto inner join inscritos on Ati_nregisto = Ins_Ati_registo group by Eve_nregisto;

/*********** Estatisticas das Atividades ***********/

select avg(a.num) as media, max(a.num) as maximo, min(a.num) as minimo, stddev(a.num) as desvio
from (select count(Ins_Par_nregisto) as num from projeto.inscritos group by Ins_Ati_registo) as a;

/*********** Estatisticas dos Eventos ***********/

select avg(a.num) as media, max(a.num) as maximo, min(a.num) as minimo, stddev(a.num) as desvio
from (select count(Ins_Par_nregisto) as num from projeto.inscritos inner join atividades on inscritos.Ins_Ati_registo = atividades.Ati_nregisto
	inner join eventos on atividades.Ati_Eve_nregisto = eventos.Eve_nregisto group by Eve_nregisto) as a;

/********************* Functions *********************/

drop function if exists filter_words;
delimiter //
CREATE FUNCTION filter_words (comment_text VARCHAR(200))
	RETURNS VARCHAR(200)
    DETERMINISTIC
BEGIN
	DECLARE done INT DEFAULT FALSE;
    
    DECLARE a VARCHAR(50);
    DECLARE b CHAR(6);
    DECLARE RESULT VARCHAR(200);
    
    DECLARE word_list CURSOR FOR SELECT UPPER(word) FROM reserved_words;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET b = "******";
    SET RESULT = UPPER(comment_text);
    
    OPEN word_list;
    
    read_words: LOOP
		FETCH word_list INTO a;
        
        
        IF done THEN
			LEAVE read_words;
		END IF;
        
        SET RESULT = REPLACE(RESULT, a, b);
	END LOOP;
    CLOSE word_list;
    
    RETURN(RESULT);

END//
delimiter ;

drop function if exists auxiliar;
delimiter //
create function auxiliar(word1 varchar(200), word2 varchar(200))
RETURNS INT
DETERMINISTIC
BEGIN
	declare checked int default 0;
    select upper(word1) like concat('%',upper(word2),'%') into checked;
    return checked;
END//
DELIMITER ;


/********************* Views *********************/

/********************* Informação de Eventos *********************/
drop view if exists EventoParticipantes;
create view EventoParticipantes (Evento, Participantes) as
	select Eve_nome, Par_nome from eventos inner join atividades on Eve_nregisto = Ati_Eve_nregisto
	inner join inscritos on Ati_nregisto = Ins_Ati_registo inner join participantes on Ins_Par_nregisto = Par_nregisto
    group by Par_nregisto;
    
drop view if exists EventoPatrocinadores;
create view EventoPatrocinadores (Evento, Patrocinadores) as
	select Eve_nome, Pat_marca from eventos inner join patrocinios on Eve_nregisto = Patr_Eve_nregisto
	inner join patrocinadores on Patr_Pat_nregisto = Pat_nregisto;

drop view if exists EventoInfo;    
create or replace view EventoInfo(Evento, Atividade, Sala, Horário, Oradores) as
	select Eve_nome, Ati_titulo, Ati_sala, concat(date_format(Ati_começo, "%H : %i"), " | ", date_format(Ati_final, "%H : %i")), group_concat(Ora_nome, ', ') from eventos
    join atividades on Eve_nregisto = Ati_Eve_nregisto join organizadores on Ati_nregisto = Org_Ati_nregisto join oradores on Org_Ora_nregisto = Ora_nregisto
    order by Ati_começo asc;

/********************* Informação de Atividades *********************/

create or replace view AtividadeInfo(Atividade, Sala, Horário, Temas, Oradores) as
	select Ati_titulo, Ati_sala, 
    concat(date_format(Ati_começo, "%H : %i"), " | ", date_format(Ati_final, "%H : %i")), Ati_tópicos, group_concat(Ora_nome, ', ') from atividades
    inner join organizadores on Ati_nregisto = Org_Ati_nregisto inner join oradores on Org_Ora_nregisto = Ora_nregisto
    group by Ati_titulo order by Ati_começo asc;

/********************* Comentários e Avaliações do utilizador *********************/

create or replace view comentarios_avaliaçoes(Atividade, Utilizador, Comentário, Avaliação) as 
	select Ati_titulo, Par_nome, Ins_comentário, Ins_avaliação from atividades
    inner join inscritos on Ati_nregisto = Ins_Ati_registo inner join participantes on Ins_Par_nregisto = Par_nregisto
    group by par_nregisto;

/********************* Views do Gestor *********************/

/********************* Lista de participantes *********************/

create or replace view participantes_evento_atividade(Evento, Atividade, Total, Participantes) as
	select Eve_nome, Ati_titulo, count(Par_nregisto), group_concat(Par_nome separator ', ') from eventos inner join atividades on
    Eve_nregisto = Ati_Eve_nregisto inner join inscritos on Ati_nregisto = Ins_Ati_registo
    inner join participantes on Ins_Par_nregisto = Par_nregisto group by Ati_titulo;
    
/********************* Lista de Oradores *********************/
    
create or replace view oradores_evento_atividade(Evento, Atividade, Total, Oradores) as
	select Eve_nome, Ati_titulo, count(Ora_nregisto), group_concat(Ora_nome, ', ') from eventos inner join atividades on
    Eve_nregisto = Ati_Eve_nregisto inner join organizadores on Ati_nregisto = Org_Ati_nregisto
    inner join oradores on Org_Ora_nregisto = ora_nregisto group by Ati_titulo;

/********************* Lista de Comentários e Classificações *********************/

create or replace view Comentarios_Classificações_evento_atividade(Evento, Atividade, Comentarios, Classificações) as
	select Eve_nome, Ati_titulo, count(Ins_comentário), count(Ins_avaliação) from eventos inner join atividades on
    Eve_nregisto = Ati_Eve_nregisto inner join inscritos on Ati_nregisto = Ins_Ati_registo
    inner join participantes on Ins_Par_nregisto = Par_nregisto group by Ati_titulo;
    
/********************* Número médio de Comentários e Classificações *********************/


create or replace view Media_Cometarios_Classificações_Atividade(Atividade, Média) as
	select Ati_titulo, avg(a.soma) from (select Ati_titulo, count(Ins_comentário) + count(Ins_avaliação) as soma from atividades
	join inscritos on Ati_nregisto = Ins_Ati_registo group by Ati_nregisto) a;

/********************* Rankings de Atividades *********************/

create or replace view Ranking_Atividades_Classificações as 
	select Ati_titulo as Atividade, avg(Ins_avaliação) as media from atividades
    join inscritos on Ati_nregisto = Ins_Ati_registo
    group by Atividade order by media desc;
    
create or replace view Ranking_Atividades_Participantes as 
	select Ati_titulo as Atividade, count(Ins_Par_nregisto) as contagem from atividades
    join inscritos on Ati_nregisto = Ins_Ati_registo
    group by Atividade order by contagem desc;

/********************* Rankings de Participantes *********************/

create or replace view Ranking_Cometários_Participantes as
	select Par_nome as Participante, count(Ins_comentário) as contagem from participantes
    join inscritos on Par_nregisto = Ins_Par_nregisto
    group by Par_nregisto order by contagem desc limit 5;


/********************* Inserts/Updates *********************/

drop procedure if exists Insert_Atividates;
delimiter //
create procedure Insert_Atividates(in v_Ati_sala varchar(45), in v_Ati_titulo varchar(45), in v_Ati_começo varchar(45), 
in v_Ati_final varchar(45), in v_Eve_nome varchar(45), in v_Ati_tipo varchar(45), in v_Ati_tópicos varchar(100))
	begin
		declare v_Ati_Eve_nregisto int;
		select Eve_nregisto into v_Ati_Eve_nregisto from eventos where v_Eve_nome = Eve_nome;
        insert into atividades (Ati_sala, Ati_titulo, Ati_começo, Ati_final, Ati_Eve_nregisto, Ati_tipo, Ati_tópicos) values
        (v_Ati_sala, v_Ati_titulo, CAST(v_Ati_começo AS datetime), CAST(v_Ati_final AS datetime), v_Ati_Eve_nregisto, 
        v_Ati_tipo, v_Ati_tópicos);
	end //
delimiter ;

drop procedure if exists Insert_Avisos;
delimiter //
create procedure Insert_Avisos(in v_aviso_Par_id int(11), in v_aviso_mensagem varchar(200), in v_aviso_datetime varchar(45))
	begin
        insert into avisos (aviso_Par_id, aviso_mensagem, aviso_data) values
        (v_aviso_Par_id, v_aviso_mensagem,  CAST(v_aviso_datetime AS datetime));
	end //
delimiter ;
    
drop procedure if exists Insert_Conteudo;
delimiter //
create procedure Insert_Conteudo(in v_Eve_nome varchar(45), in v_Tem_nome varchar(45))
	begin
		declare v_Con_Eve_nregisto, v_Con_Tem_nregisto int;
		select Eve_nregisto into v_Con_Eve_nregisto from eventos where Eve_nome = v_Eve_nome;
		select Tem_nregisto into v_Con_Tem_nregisto from temas where v_Tem_nome = Tem_nome;
        insert into conteudos (Con_Eve_nregisto, Con_Tem_nregisto) values
        (v_Con_Eve_nregisto, v_Con_Tem_nregisto);
	end //
delimiter ;
    
drop procedure if exists Insert_Evento;
delimiter //
create procedure Insert_Evento(in v_Eve_nome varchar(45), in v_Eve_data varchar(20), in v_Eve_local varchar(45))
	begin
        insert into eventos (Eve_nome, Eve_data, Eve_local) values
        (v_Eve_nome, str_to_date(v_Eve_data,'%Y/%m/%d'), v_Eve_local);
	end //
delimiter ;

drop procedure if exists Insert_Inscrito;
delimiter //
create procedure Insert_Inscrito(in v_Ins_Par_nregisto int(11), in v_Ins_Ati_registo int(11), in v_Ins_avaliação int(11), in v_Ins_comentário varchar(50))
	begin
        insert into inscritos (Ins_Par_nregisto, Ins_Ati_registo, Ins_avaliação, Ins_comentário) values
        (v_Ins_Par_nregisto, v_Ins_Ati_registo, v_Ins_avaliação, v_Ins_comentário);
	end //
delimiter ;

drop procedure if exists Insert_Login;
delimiter //
create procedure Insert_Login(in v_Log_nome varchar(45), in v_Log_password varchar(45))
	begin
        insert into login (Log_nome, Log_password) values
        (v_Log_nome, v_Log_password);
	end //
delimiter ;

drop procedure if exists Insert_Orador;
delimiter //
create procedure Insert_Orador(in v_Ora_userName varchar(45), in v_Ora_nome varchar(45))
	begin
		declare v_Ora_Log_nregisto int;
		select Log_nregisto into v_Ora_Log_nregisto from login where v_Ora_userName = Log_nome;
        insert into oradores (Ora_Log_nregisto, Ora_nome) values
        (v_Ora_Log_nregisto, v_Ora_nome);
	end //
delimiter ;

drop procedure if exists Insert_Organizadores;
delimiter //
create procedure Insert_Organizadores(in v_Org_Ora_nregisto int(11), in v_Org_Ati_nregisto int(11))
	begin
        insert into organizadores (Org_Ora_nregisto, Org_Ati_nregisto) values
        (v_Org_Ora_nregisto, v_Org_Ati_nregisto);
	end //
delimiter ;

drop procedure if exists Insert_Participante;
delimiter //
create procedure Insert_Participante(in v_userName varchar(45), in v_Par_nome varchar(45), in v_Par_idade tinyint(2), in v_Par_pode_comentar bit, in v_Par_contagem int(11))
	begin
		declare v_Ora_Log_nregisto int;
		select Log_nregisto into v_Ora_Log_nregisto from login where v_userName = Log_nome;
        insert into participantes (Par_Log_nregisto, Par_nome, Par_idade, Par_pode_comentar, Par_contagem) values
        (v_Ora_Log_nregisto, v_Par_nome, v_Par_idade, v_Par_pode_comentar, v_Par_contagem);
	end //
delimiter ;

drop procedure if exists Insert_Patrocinador;
delimiter //
create procedure Insert_Patrocinador(in v_Pat_marca varchar(45))
	begin
        insert into patrocinadores (Pat_marca) values
        (v_Pat_marca);
	end //
delimiter ;

drop procedure if exists Insert_Patrocinio;
delimiter //
create procedure Insert_Patrocinio(in v_Nome_Marca varchar(45), in v_Nome_Evento varchar(45))
	begin
        declare v_Patr_Eve_nregisto, v_Patr_Pat_nregisto int;
		select Eve_nregisto into v_Patr_Eve_nregisto from eventos where v_Nome_Evento = Eve_nome;
		select Pat_nregisto into v_Patr_Pat_nregisto from patrocinadores where v_Nome_Marca = Pat_marca;
        insert into patrocinios (Patr_Pat_nregisto, Patr_Eve_nregisto) values
        (v_Patr_Pat_nregisto, v_Patr_Eve_nregisto);
	end //
delimiter ;

drop procedure if exists Insert_Tema;
delimiter //
create procedure Insert_Tema(in v_Tem_nome varchar(45))
	begin
        insert into temas (Tem_nome) values
        (v_Tem_nome);
	end //
delimiter ;

drop procedure if exists Insert_Vencedor;
delimiter //
create procedure Insert_Vencedor(in v_Ven_Par_nregisto int(11), in v_Ven_Ati_nregisto int(11))
	begin
        insert into vencedores (Ven_Par_nregisto, Ven_Ati_nregisto) values
        (v_Ven_Par_nregisto, v_Ven_Ati_nregisto);
	end //
delimiter ;


drop procedure if exists Update_Atividates;
delimiter //
create procedure Update_Atividates(in v_Ati_nregisto int(11), in v_Ati_sala varchar(45), in v_Ati_titulo varchar(45), in v_Ati_começo varchar(45), 
in v_Ati_final varchar(45), in v_Eve_nome varchar(45), in v_Ati_tipo varchar(45), in v_Ati_tópicos varchar(100))
	begin
		declare v_Ati_Eve_nregisto int;
		select Eve_nregisto into v_Ati_Eve_nregisto from eventos where v_Eve_nome = Eve_nome;
        update atividades set Ati_sala = v_Ati_sala, Ati_titulo = v_Ati_titulo, Ati_começo = CAST(v_Ati_começo AS datetime), 
        Ati_final = CAST(v_Ati_final AS datetime), Ati_Eve_nregisto = v_Ati_Eve_nregisto, Ati_tipo = v_Ati_tipo, Ati_tópicos = v_Ati_tópicos
        where Ati_nregisto = v_Ati_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Avisos;
delimiter //
create procedure Update_Avisos(in v_aviso_id int, in v_aviso_Par_id int(11), in v_aviso_mensagem varchar(200), in v_aviso_datetime varchar(45))
	begin
        update avisos set aviso_Par_id = v_aviso_Par_id, aviso_mensagem = v_aviso_mensagem, aviso_data = CAST(v_aviso_datetime AS datetime)
        where aviso_id = v_aviso_id;
	end //
delimiter ;

drop procedure if exists Update_Conteudo;
delimiter //
create procedure Update_Conteudo(in v_oldEve_nome varchar(45), in v_oldTem_nome varchar(45), in v_newEve_nome varchar(45), in v_newTem_nome varchar(45))
	begin
		declare tempv_oldCon_Eve_nregisto, tempv_oldCon_Tem_nregisto, tempv_newCon_Eve_nregisto, tempv_newCon_Tem_nregisto int;
		select Eve_nregisto into tempv_oldCon_Eve_nregisto from eventos where v_oldEve_nome = Eve_nome;
		select Tem_nregisto into tempv_oldCon_Tem_nregisto from temas where v_oldTem_nome = Tem_nome;
        select Eve_nregisto into tempv_newCon_Eve_nregisto from eventos where v_newEve_nome = Eve_nome;
		select Tem_nregisto into tempv_newCon_Tem_nregisto from temas where v_newTem_nome = Tem_nome;
        update conteudos set Con_Eve_nregisto = tempv_newCon_Eve_nregisto, Con_Tem_nregisto = tempv_newCon_Tem_nregisto
        where Con_Eve_nregisto = tempv_oldCon_Eve_nregisto and Con_Tem_nregisto = tempv_oldCon_Tem_nregisto;
	end //
delimiter ;
    
drop procedure if exists Update_Evento;
delimiter //
create procedure Update_Evento(in v_Eve_nregisto int,in v_Eve_nome varchar(45), in v_Eve_data varchar(20), in v_Eve_local varchar(45))
	begin
		update eventos set Eve_nome = v_Eve_nome, Eve_data = str_to_date(v_Eve_data,'%Y/%m/%d'), Eve_local = v_Eve_local
		where v_Eve_nregisto = Eve_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Inscrito;
delimiter //
create procedure Update_Inscrito(in v_Ins_Par_nregisto int(11), in v_Ins_Ati_registo int(11), in v_Ins_avaliação int(11), in v_Ins_comentário varchar(50))
	begin
		update inscritos set Ins_avaliação = v_Ins_avaliação, Ins_comentário = v_Ins_comentário
        where Ins_Par_nregisto = v_Ins_Par_nregisto and Ins_Ati_registo = v_Ins_Ati_registo;
	end //
delimiter ;

drop procedure if exists Update_Login;
delimiter //
create procedure Update_Login(in v_Log_nregisto int, in v_Log_nome varchar(45), in v_Log_password varchar(45))
	begin
		update login set Log_nome = v_Log_nome, Log_password = v_Log_password where v_Log_nregisto = Log_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Orador;
delimiter //
create procedure Update_Orador(in v_Ora_userName varchar(45), in v_Ora_nome varchar(45))
	begin
		declare v_Ora_Log_nregisto, v_Ora_nregisto int;
		select Log_nregisto into v_Ora_Log_nregisto from login where v_Ora_userName = Log_nome;
		select Ora_nregisto into v_Ora_nregisto from oradores where v_Ora_Log_nregisto = Ora_Log_nregisto;
        update oradores set Ora_nome = v_Ora_nome where v_Ora_nregisto = Ora_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Organizadores;
delimiter //
create procedure Update_Organizadores(in v_oldOrg_Ora_nregisto int(11), in v_oldOrg_Ati_nregisto int(11), in v_newOrg_Ora_nregisto int(11), in v_newOrg_Ati_nregisto int(11))
	begin
		update organizadores set Org_Ora_nregisto = v_newOrg_Ora_nregisto, Org_Ati_nregisto = v_newOrg_Ati_nregisto
        where Org_Ora_nregisto = v_oldOrg_Ora_nregisto and Org_Ati_nregisto = v_oldOrg_Ati_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Participante;
delimiter //
create procedure Update_Participante(in v_Par_nregisto int, in v_Par_nome varchar(45), in v_Par_idade tinyint(2), in v_Par_pode_comentar bit, in v_Par_contagem int(11))
	begin
        update participantes set Par_nome = v_Par_nome, Par_idade = v_Par_idade, Par_pode_comentar = v_Par_pode_comentar, Par_contagem = v_Par_contagem
        where v_Par_nregisto = Par_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Patrocinador;
delimiter //
create procedure Update_Patrocinador(in v_Pat_nregisto int, in v_Pat_marca varchar(45))
	begin
		update patrocinadores set Pat_marca = v_Pat_marca where v_Pat_nregisto = Pat_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Patrocinio;
delimiter //
create procedure Update_Patrocinio(in v_oldNome_Marca varchar(45), in v_oldNome_Evento varchar(45), in v_newNome_Marca varchar(45), in v_newNome_Evento varchar(45))
	begin
        declare v_oldPatr_Eve_nregisto, v_oldPatr_Pat_nregisto, v_newPatr_Eve_nregisto, v_newPatr_Pat_nregisto int;
		select Eve_nregisto into v_oldPatr_Eve_nregisto from eventos where v_oldNome_Evento = Eve_nome;
		select Pat_nregisto into v_oldPatr_Pat_nregisto from patrocinadores where v_oldNome_Marca = Pat_marca;
        select Eve_nregisto into v_newPatr_Eve_nregisto from eventos where v_newNome_Evento = Eve_nome;
		select Pat_nregisto into v_newPatr_Pat_nregisto from patrocinadores where v_newNome_Marca = Pat_marca;
        update patrocinios set Patr_Pat_nregisto = v_newPatr_Pat_nregisto, Patr_Eve_nregisto = v_newPatr_Eve_nregisto
        where Patr_Pat_nregisto = v_oldPatr_Pat_nregisto and Patr_Eve_nregisto = v_oldPatr_Eve_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Tema;
delimiter //
create procedure Update_Tema(in v_Tem_nregisto int, in v_Tem_nome varchar(45))
	begin
		update temas set Tem_nome = v_Tem_nome where v_Tem_nregisto = Tem_nregisto;
	end //
delimiter ;

drop procedure if exists Update_Vencedor;
delimiter //
create procedure Update_Vencedor(in v_Ven_nregisto int, in v_Ven_Par_nregisto int(11), in v_Ven_Ati_nregisto int(11))
	begin
		update vencedores set Ven_Par_nregisto = v_Ven_Par_nregisto, Ven_Ati_nregisto = Ven_Ati_nregisto
        where Ven_nregisto = v_Ven_nregisto;
	end //
delimiter ;


drop procedure if exists Delete_Atividade;
delimiter //
create procedure Delete_Atividade(in v_Ati_nregisto int)
	begin
		delete from atividades where Ati_nregisto = v_Ati_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Aviso;
delimiter //
create procedure Delete_Aviso(in v_aviso_id int)
	begin
        delete from avisos where aviso_id = v_aviso_id;
	end //
delimiter ;

drop procedure if exists Delete_Conteudo;
delimiter //
create procedure Delete_Conteudo(in v_Eve_nome varchar(45), in v_Tem_nome varchar(45))
	begin
		declare v_Con_Eve_nregisto, v_Con_Tem_nregisto int;
		select Eve_nregisto into v_Con_Eve_nregisto from eventos where v_Eve_nome = Eve_nome;
		select Tem_nregisto into v_Con_Tem_nregisto from temas where v_Tem_nome = Tem_nome;
        delete from conteudos where Con_Eve_nregisto = v_Con_Eve_nregisto and Con_Tem_nregisto = v_Con_Tem_nregisto;
	end //
delimiter ;
    
drop procedure if exists Delete_Evento;
delimiter //
create procedure Delete_Evento(in v_Eve_nregisto int)
	begin
		delete from eventos where Eve_nregisto = v_Eve_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Inscrito;
delimiter //
create procedure Delete_Inscrito(in v_Ins_Par_nregisto int(11), in v_Ins_Ati_registo int(11))
	begin
		delete from inscritos where Ins_Par_nregisto = v_Ins_Par_nregisto and Ins_Ati_registo = v_Ins_Ati_registo;
	end //
delimiter ;

drop procedure if exists Delete_Login;
delimiter //
create procedure Delete_Login(in v_Log_nregisto int)
	begin
		delete from login where v_Log_nregisto = Log_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Orador;
delimiter //
create procedure Delete_Orador(in v_Ora_nregisto int)
	begin
        delete from oradores where v_Ora_nregisto = Ora_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Organizadores;
delimiter //
create procedure Delete_Organizadores(in v_Org_Ora_nregisto int(11), in v_Org_Ati_nregisto int(11))
	begin
		delete from organizadores where Org_Ora_nregisto = v_Org_Ora_nregisto and Org_Ati_nregisto = v_Org_Ati_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Participante;
delimiter //
create procedure Delete_Participante(in v_Par_nregisto int)
	begin
        delete from participantes where v_Par_nregisto = Par_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Patrocinador;
delimiter //
create procedure Delete_Patrocinador(in v_Pat_nregisto int)
	begin
		delete from patrocinadores where v_Pat_nregisto = Pat_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Patrocinio;
delimiter //
create procedure Delete_Patrocinio(in v_Nome_Marca varchar(45), in v_Nome_Evento varchar(45))
	begin
        declare v_Patr_Eve_nregisto, v_Patr_Pat_nregisto int;
		select Eve_nregisto into v_Patr_Eve_nregisto from eventos where v_Nome_Evento = Eve_nome;
		select Pat_nregisto into v_Patr_Pat_nregisto from patrocinadores where v_Nome_Marca = Pat_marca;
        delete from patrocinios where Patr_Pat_nregisto = v_Patr_Pat_nregisto and Patr_Eve_nregisto = v_Patr_Eve_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Tema;
delimiter //
create procedure Delete_Tema(in v_Tem_nregisto int)
	begin
		delete from temas where v_Tem_nregisto = Tem_nregisto;
	end //
delimiter ;

drop procedure if exists Delete_Vencedor;
delimiter //
create procedure Delete_Vencedor(in v_Ven_nregisto int)
	begin
		delete from vencedores where Ven_nregisto = v_Ven_nregisto;
	end //
delimiter ;

/********************* Triggers *********************/


-- ---------------------------------------------------------------

DROP TRIGGER IF EXISTS filter_all_wordss;
DELIMITER //
CREATE TRIGGER filter_all_wordss BEFORE INSERT ON inscritos
FOR EACH ROW
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE has_bad_word int DEFAULT 0;
    DECLARE word_ VARCHAR(50);
    DECLARE participante int default -1;
    declare contagem int default 0;
    
    -- DECLARE RESULT VARCHAR(200);
    
    DECLARE word_list CURSOR FOR SELECT word FROM reserved_words;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    select new.Ins_Par_nregisto into participante;
    set has_bad_word = 0;
    -- SET RESULT = UPPER(NEW.comment_text);
    
    OPEN word_list;
    read_words: LOOP
		FETCH word_list INTO word_;
        IF done = 1 THEN
			LEAVE read_words;
		END IF;
        select auxiliar(new.Ins_comentário,word_) into has_bad_word;
        
        if (has_bad_word = 1) then 
			UPDATE participantes SET Par_contagem = Par_contagem + 1 WHERE Par_nregisto = participante;
			INSERT INTO avisos values (null, NEW.Ins_Par_nregisto, 'uso inapropriado de linguagem', now());
            set new.Ins_comentário = "********";
			set done = 1;
		end if;
        
	END LOOP;
    CLOSE word_list;
    select Par_contagem into contagem from participantes where Par_nregisto = participante;
    if(contagem > 4) then
		update participantes set Par_pode_comentar = 0 where Par_nregisto = participante;
	end if;
END//
DELIMITER ;

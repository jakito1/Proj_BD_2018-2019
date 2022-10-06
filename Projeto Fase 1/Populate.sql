insert into login (Log_nome, Log_password) values ('coisas1', 'coisas'), ('coisas2', 'coisas'), ('coisas3', 'coisas'), ('coisas4', 'coisas'), ('coisas5', 'coisas');
insert into participantes (Par_Log_nregisto, Par_nome, Par_idade) values (1, 'Miguel', 17), (2, 'Rodrigo', 20), (3, 'Rodrigo', 18), (4, 'Joao', 20), (5, 'Rafael', 24);
insert into eventos (Eve_nome, Eve_data, Eve_local) values ('Shooters para noobs', '2019-05-15', 'Lisboa'), ('Qualquer coisa', '2019-05-19', 'Beja'), ('Torneio de FPS', '2019-06-15', 'Lisboa'), ('Como não jogar', '2019-05-17', 'Lisboa'), ('MMORPGS', '2019-05-16', 'Faro');
insert into oradores (Ora_Log_nregisto, Ora_nome) values (1, 'Rodrigo'), (2, 'Rafael'), (3, 'Joao'), (4, 'Francisco'), (5, 'Vitor');
insert into atividades (Ati_sala, Ati_começo, Ati_final, Ati_Eve_nregisto, Ati_tipo) values ('A1', now(), now(), 1, 'Torneio'), ('A2', now(), now(), 1, 'Torneio'),
	('A3', now(), now(), 1, 'Torneio'), ('A4', now(), now(), 3, 'Palestra'), ('A5', now(), now(), 2, 'Palestra');
insert into patrocinadores (Pat_marca) values ('coisas1'), ('coisas2'), ('coisas3'), ('coisas4'), ('coisas5');
insert into temas (Tem_nome) values ('jogos1'), ('jogos2'), ('jogos3'), ('jogos4'), ('jogos5');
insert into inscritos (Ins_Par_nregisto, Ins_Ati_registo, Ins_avaliação) values (1, 1, 'Faltava comida'), (2, 1, 'Interessante'), (3, 1, 'Gostei'),
	(4, 3, 'Não gostei'), (5, 4, 'Gostei bastante');
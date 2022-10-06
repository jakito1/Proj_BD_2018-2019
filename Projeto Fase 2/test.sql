use projeto;

select filter_words('test');
select filter_words('hitler');
select* from eventoparticipantes;
select* from EventoPatrocinadores;
select* from EventoInfo;
select* from AtividadeInfo;
select* from comentarios_avaliaçoes;
select* from participantes_evento_atividade;
select * from Media_Cometarios_Classificações_Atividade;
select* from oradores_evento_atividade;
select* from Comentarios_Classificações_evento_atividade;
select* from Ranking_Atividades_Classificações;
select* from Ranking_Atividades_Participantes;
select* from Ranking_Cometários_Participantes;

select* from atividades;
call Insert_Atividates(123, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(124, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(125, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Jogod', 'testeteste');
call Insert_Atividates(126, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(127, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(128, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(129, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(120, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(113, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(1223, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(1255, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(153, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(1253, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(1263, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates('l123', 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates('P123', 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
call Insert_Atividates(1213, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Shooters para noobs', 'Conferencia', 'testeteste');
select* from atividades;

select* from avisos;
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(2, 'Estas atrasado!', now());
call Insert_Avisos(3, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(2, 'Estas atrasado!', now());
call Insert_Avisos(3, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(2, 'Estas atrasado!', now());
call Insert_Avisos(3, 'Atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Agora atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', '2021-12-28 22:19');
call Insert_Avisos(1, 'Teste atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
call Insert_Avisos(1, 'Estas atrasado!', now());
select* from avisos;

select* from conteudos;
call Insert_Conteudo('Shooters para noobs', 'jogos2');
call Insert_Conteudo('Torneio de FPS', 'jogos2');
call Insert_Conteudo('Torneio de FPS', 'jogos1');
call Insert_Conteudo('Shooters para noobs', 'jogos3');
select* from conteudos;

select* from eventos;
call Insert_Evento('Olha teste1', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste2', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste3', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste4', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste5', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste6', '2019/01/29', 'Pluto');
call Insert_Evento('Olha teste7', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste8', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste9', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste10', '2019/01/19', 'Marte');
call Insert_Evento('Olha teste11', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste12', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste13', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste14', '2019/01/29', 'Japao');
call Insert_Evento('Olha teste155', '2019/01/29', 'Mart333e');
call Insert_Evento('Olha teste15', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste61', '2019/01/29', 'Marte');
call Insert_Evento('Olha teste16', '2019/01/24', 'Marte');
call Insert_Evento('Olha teste19', '2019/01/29', 'Marte');
select* from eventos;

select* from inscritos;
call Insert_Inscrito(2, 2, 20, 'nao gostei');
call Insert_Inscrito(3, 4, 20, 'nao merda');
call Insert_Inscrito(4, 2, 20, 'nao gostei');
call Insert_Inscrito(5, 2, 20, 'nao gostei');
call Insert_Inscrito(2, 5, 20, 'nao gostei');
call Insert_Inscrito(2, 4, 20, 'nao gostei');
call Insert_Inscrito(5, 1, 20, 'nao gostei');
call Insert_Inscrito(3, 5, 20, 'nao merda');
call Insert_Inscrito(4, 5, 20, 'nao gostei');
call Insert_Inscrito(5, 5, 20, 'nao gostei');
call Insert_Inscrito(5, 3, 20, 'nao gostei');
call Insert_Inscrito(1, 4, 20, 'nao gostei');
select* from inscritos;

select* from login;
call Insert_Login('teste123', 'teste123;;;');
call Insert_Login('test1e123', 'teste123;;;');
call Insert_Login('test2e123', 'teste123;;;');
call Insert_Login('test4e123', 'teste123;;;');
call Insert_Login('test3e123', 'teste123;;;');
call Insert_Login('tes5te123', 'teste123;;;');
call Insert_Login('tes6te123', 'teste123;;;');
call Insert_Login('tes55te123', 'teste123;;;');
call Insert_Login('tes7te123', 'teste123;;;');
call Insert_Login('test6e123', 'teste123;;;');
call Insert_Login('tes3te123', 'teste123;;;');
call Insert_Login('tes234te123', 'teste123;;;');
call Insert_Login('test4e123', 'teste123;;;');
call Insert_Login('tes235te123', 'teste123;;;');
call Insert_Login('te3sr32te123', 'teste123;;;');
call Insert_Login('tes32te123', 'teste123;;;');
call Insert_Login('tes2335te123', 'teste123;;;');
select* from login;

select* from oradores;
call Insert_Orador('teste123', 'teste123;;;');
call Insert_Orador('test1e123', 'teste123;;;');
call Insert_Orador('test2e123', 'teste123;;;');
call Insert_Orador('test4e123', 'teste123;;;');
call Insert_Orador('test3e123', 'teste123;;;');
call Insert_Orador('tes5te123', 'teste123;;;');
call Insert_Orador('tes6te123', 'teste123;;;');
call Insert_Orador('tes55te123', 'teste123;;;');
call Insert_Orador('tes7te123', 'teste123;;;');
call Insert_Orador('test6e123', 'teste123;;;');
call Insert_Orador('tes3te123', 'teste123;;;');
call Insert_Orador('tes234te123', 'teste123;;;');
call Insert_Orador('test4e123', 'teste123;;;');
call Insert_Orador('tes235te123', 'teste123;;;');
call Insert_Orador('te3sr32te123', 'teste123;;;');
call Insert_Orador('tes32te123', 'teste123;;;');
call Insert_Orador('tes2335te123', 'teste123;;;');
select* from oradores;

select* from organizadores;
call Insert_Organizadores(1,2);
call Insert_Organizadores(1,3);
call Insert_Organizadores(1,4);
call Insert_Organizadores(1,5);
call Insert_Organizadores(1,6);
call Insert_Organizadores(2,1);
call Insert_Organizadores(3,2);
call Insert_Organizadores(4,2);
call Insert_Organizadores(5,2);
call Insert_Organizadores(6,2);
call Insert_Organizadores(2,2);
call Insert_Organizadores(3,2);
call Insert_Organizadores(5,4);
call Insert_Organizadores(6,4);
call Insert_Organizadores(4,1);
call Insert_Organizadores(5,1);
call Insert_Organizadores(5,3);
call Insert_Organizadores(5,5);
call Insert_Organizadores(5,6);
select* from organizadores;

select* from participantes;
call Insert_Participante('teste123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('test1e123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('test2e123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('test4e123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('test3e123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes5te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes6te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes55te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes7te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('test6e123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes3te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes234te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('test4e123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes235te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('te3sr32te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes32te123', 'teste123;;;', 10, 0, 0);
call Insert_Participante('tes2335te123', 'teste123;;;', 10, 0, 0);
select* from participantes;

select* from patrocinadores;
call Insert_Patrocinador('teste1');
call Insert_Patrocinador('1teste1');
call Insert_Patrocinador('t2este1');
call Insert_Patrocinador('te3ste1');
call Insert_Patrocinador('tes4te1');
call Insert_Patrocinador('test5e1');
call Insert_Patrocinador('teste61');
call Insert_Patrocinador('6teste1');
call Insert_Patrocinador('t7este1');
call Insert_Patrocinador('te8ste1');
call Insert_Patrocinador('tes9te1');
call Insert_Patrocinador('test0e1');
call Insert_Patrocinador('teste-1');
call Insert_Patrocinador('ateste1');
call Insert_Patrocinador('tseste1');
call Insert_Patrocinador('tedste1');
call Insert_Patrocinador('tesfte1');
select* from patrocinadores;

select* from patrocinios;
call Insert_Patrocinio('teste1', 'Olha teste2');
call Insert_Patrocinio('1teste1','Olha teste3');
call Insert_Patrocinio('t2este1','Olha teste4');
call Insert_Patrocinio('te3ste1','Olha teste5');
call Insert_Patrocinio('tes4te1','Olha teste6');
call Insert_Patrocinio('test5e1','Olha teste7');
call Insert_Patrocinio('teste61','Olha teste8');
call Insert_Patrocinio('6teste1','Olha teste9');
call Insert_Patrocinio('t7este1','Olha teste10');
call Insert_Patrocinio('te8ste1','Olha teste11');
call Insert_Patrocinio('tes9te1','Olha teste12');
call Insert_Patrocinio('test0e1','Olha teste13');
call Insert_Patrocinio('teste-1','Olha teste14');
call Insert_Patrocinio('ateste1','Olha teste15');
call Insert_Patrocinio('tseste1','Olha teste155');
call Insert_Patrocinio('tedste1','Olha teste61');
call Insert_Patrocinio('tesfte1','Olha teste19');
select* from patrocinadores;

select* from temas;
call Insert_Tema('teste1');
call Insert_Tema('1teste1');
call Insert_Tema('t2este1');
call Insert_Tema('te3ste1');
call Insert_Tema('tes4te1');
call Insert_Tema('test5e1');
call Insert_Tema('teste61');
call Insert_Tema('6teste1');
call Insert_Tema('t7este1');
call Insert_Tema('te8ste1');
call Insert_Tema('tes9te1');
call Insert_Tema('test0e1');
call Insert_Tema('teste-1');
call Insert_Tema('ateste1');
call Insert_Tema('tseste1');
call Insert_Tema('tedste1');
call Insert_Tema('tesfte1');
select* from temas;

select* from vencedores;
call Insert_Vencedor(1,1);
call Insert_Vencedor(1,2);
call Insert_Vencedor(1,3);
call Insert_Vencedor(1,4);
call Insert_Vencedor(1,5);
call Insert_Vencedor(1,6);
call Insert_Vencedor(2,1);
call Insert_Vencedor(3,1);
call Insert_Vencedor(4,1);
call Insert_Vencedor(5,1);
call Insert_Vencedor(2,1);
call Insert_Vencedor(2,2);
call Insert_Vencedor(2,3);
call Insert_Vencedor(2,4);
call Insert_Vencedor(2,5);
call Insert_Vencedor(2,6);
call Insert_Vencedor(3,1);
call Insert_Vencedor(3,2);
call Insert_Vencedor(3,3);
call Insert_Vencedor(3,4);
select* from vencedores;

select* from atividades;
call Update_Atividates(1,1235, 'Teste1', '2020-12-28 21:19', '2020-12-28 22:19', 'Como não jogar', 'teste', 'testeteste');
select* from atividades;

select* from avisos;
call Update_Avisos(1, 1, 'Estas testeee!', '2020-12-28 22:19');
select* from avisos;

select* from conteudos;
call Update_Conteudo('Shooters para noobs', 'jogos2','Shooters para noobs', 'jogos4');
select* from conteudos;

select* from eventos;
call Update_Evento(1, 'Olha teste25', '2019/01/29', 'Juperttte');
select* from eventos;

select* from inscritos;
call Update_Inscrito(2, 2, 10, 'nao teste');
select* from inscritos;

select* from login;
call Update_Login(1,'Francisco', 'Rodrigo');
select* from login;

select* from oradores;
call Update_Orador('teste123', 'Ricardo');
select* from oradores;

select* from organizadores;
call Update_Organizadores(1,2,6,5);
select* from organizadores;

select* from participantes;
call Update_Participante(1, 'teste1235555;;;', 15, 1, 0);
select* from participantes;

select* from patrocinadores;
call Update_Patrocinador(1, 'testezzzz');
select* from patrocinadores;

select* from patrocinios;
call Update_Patrocinio('teste1', 'Olha teste2', 'test0e1', 'Olha teste61');
select* from patrocinios;

select* from temas;
call Update_Tema(1, 'jogozzzz');
select* from temas;

select* from vencedores;
call Update_Vencedor(1,3,5);
select* from vencedores;


select* from eventos;
call Delete_Evento(5);
select* from eventos;

select* from atividades;
call Delete_Atividade(9);
select* from atividades;

select* from avisos;
call delete_Aviso(1);
select* from avisos;

select* from conteudos;
call delete_Conteudo('Torneio de FPS', 'jogos1');
select* from conteudos;

select* from organizadores;
call delete_Organizadores(1,1);
select* from organizadores;

select* from vencedores;
call delete_Vencedor(1);
select* from vencedores;

select* from oradores;
call Delete_Orador(2);
select* from oradores;

select* from patrocinios;
call delete_Patrocinio('tesfte1','Olha teste19');
select* from patrocinios;

select* from login;
call Delete_Login(1);
select* from login;

select* from participantes;
call delete_Participante(1);
select* from participantes;

select* from inscritos;
call delete_Inscrito(2, 2);
select* from inscritos;

select* from patrocinadores;
call delete_Patrocinador(1, 'testezzzz');
select* from patrocinadores;

select* from temas;
call delete_Tema(1);
select* from temas;
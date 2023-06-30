DROP DATABASE IF EXISTS sistema_cineshow;

CREATE DATABASE sistema_cineshow;

use sistema_cineshow;

CREATE TABLE usuario(
	id varchar(6) UNIQUE not null,
    nome varchar(100) not null,
	nome_exibido varchar(40),
    email varchar(255) not null,
    senha varchar(16) not null,
	data_nasc date not null,
	data_registro date not null,
	PRIMARY KEY(id)
);

CREATE TABLE midia(
	id int AUTO_INCREMENT PRIMARY KEY,
    nome_midia varchar(100) not null,
    dir_midia varchar(100) not null,
	dir_capa varchar(100) not null,
	duracao varchar(10) not null,
	data_lancamento date not null,
    visualizacao int,
    genero_id int
);

CREATE TABLE favoritos(
	id int AUTO_INCREMENT PRIMARY KEY,
    usuario_id varchar(6),
    midia_id int
);

CREATE TABLE generos(
	id int AUTO_INCREMENT PRIMARY KEY,
    nome_genero varchar(60)
);

CREATE TABLE retomar(
    id int AUTO_INCREMENT PRIMARY KEY,
    tempo_atual int not null,
    ultimo_acesso date not null,
    usuario_id varchar(6),
    midia_id int
);

ALTER TABLE midia
	ADD FOREIGN KEY(genero_id) REFERENCES generos(id);

ALTER TABLE favoritos
	ADD FOREIGN KEY(usuario_id) REFERENCES usuario(id),
    ADD FOREIGN KEY(midia_id) REFERENCES midia(id);

ALTER TABLE retomar 
	ADD FOREIGN KEY(usuario_id) REFERENCES usuario(id),
    ADD FOREIGN KEY(midia_id) REFERENCES midia(id);

insert into generos values (default,'Ação'),(default,'Romance'),(default,'Aventura'),(default,'Comédia'),(default,'Anime'),(default,'Suspense');

insert into midia values 
(default,'Avatar: O Caminho da Água','avatar.mp4','avatar.png','00:02:27','2022-12-15',0,1),
(default,'Super Mario Bros','mario.mp4','mario.png','00:02:26','2023-04-06',0,3),
(DEFAULT,'Thor: O Mundo Sombrio','thor.mp4','thor.png','00:02:25','2013-11-08',0,1),
(DEFAULT,'Sonic 2 - O Filme','sonic.mp4','sonic.png','00:02:20','2022-04-08',0,3),
(DEFAULT,'Mob Psycho 100','mob.mp4','mob.png','00:01:53','2022-10-05',0,5),
(DEFAULT,'One Piece','piece.mp4','piece.png','00:01:43','1999-10-20',0,5),
(DEFAULT,"Five Nights At Freddy's",'fnaf.mp4','fnaf.png','00:02:26','2023-10-27',0,6),
(DEFAULT,"Homem-Aranha: Através do Aranhaverso",'miles.mp4','miles.png','00:02:22','2023-06-01',0,3),
(DEFAULT,"Gato de Botas 2 - O Último Pedido",'botas.mp4','botas.png','00:03:00','2023-01-05',0,1),
(DEFAULT,"Free Guy - Assumindo o Controle",'freeguy.mp4','freeguy.png','00:03:25','2021-08-19',0,4),
(DEFAULT,"Festa Da Salsicha",'festasalsicha.mp4','festasalsicha.png','00:02:22','2016-08-11',0,4),
(DEFAULT,"A Barraca do Beijo 2",'barraca.mp4','barraca.png','00:02:52','2020-07-24',0,2),
(DEFAULT,"A queda",'queda.mp4','queda.png','00:02:31','2022-09-29',0,6),
(DEFAULT,"Escape Room",'escape.mp4','escape.png','00:02:26','2019-02-07',0,6),
(DEFAULT,"A Cinco Passos de Você",'passos.mp4','passos.png','00:02:19','2019-03-21',0,2),
(DEFAULT,"Flavors of Youth",'flavors.mp4','flavors.png','00:01:17','2018-08-04',0,5),
(DEFAULT,"Vidas ao Vento",'vidas.mp4','vidas.png','00:02:16','2014-02-21',0,2),
(DEFAULT,"John Wick 4: Baba Yaga",'wick.mp4','wick.png','00:02:29','2023-03-23',0,1);
/* 1 - Ação
2 - Romance
3 - Aventura
4 - Comédia
5 - Anime
6 - Suspense
*/ 

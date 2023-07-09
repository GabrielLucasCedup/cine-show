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
    descricao text not null,
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

CREATE TABLE autologin(
	num_disk varchar(30) UNIQUE PRIMARY KEY,
    usuario_id varchar(6),
    data_efeito date
);

ALTER TABLE midia
	ADD FOREIGN KEY(genero_id) REFERENCES generos(id);

ALTER TABLE favoritos
	ADD FOREIGN KEY(usuario_id) REFERENCES usuario(id),
    ADD FOREIGN KEY(midia_id) REFERENCES midia(id);

ALTER TABLE retomar 
	ADD FOREIGN KEY(usuario_id) REFERENCES usuario(id),
    ADD FOREIGN KEY(midia_id) REFERENCES midia(id);
    
ALTER TABLE autologin
	ADD FOREIGN KEY(usuario_id) REFERENCES usuario(id);

INSERT INTO usuario VALUES ('QL6HJz', 'lucas lessa', 'lucas lessa', 'lucaslessa@gmail.com', 'lucasdev', '2005-07-02', '2023-07-03');

INSERT INTO AUTOLOGIN VALUES ('2626937C', 'QL6HJz', '2023-07-03');

insert into generos values (default,'Ação'),(default,'Romance'),(default,'Aventura'),(default,'Comédia'),(default,'Anime'),(default,'Suspense');

insert into midia values 
(default,'Avatar: O Caminho da Água','avatar.mp4','avatar.png','descricao','00:02:27','2022-12-15',0,1),
(default,'Super Mario Bros','mario.mp4','mario.png','descricao','00:02:26','2023-04-06',0,3),
(DEFAULT,'Thor: O Mundo Sombrio','thor.mp4','thor.png','descricao','00:02:25','2013-11-08',0,1),
(DEFAULT,'Sonic 2 - O Filme','sonic.mp4','sonic.png','descricao','00:02:20','2022-04-08',0,3),
(DEFAULT,'Mob Psycho 100','mob.mp4','mob.png','descricao','00:01:53','2022-10-05',0,5),
(DEFAULT,'One Piece','piece.mp4','piece.png','descricao','00:01:43','1999-10-20',0,5),
(DEFAULT,"Five Nights At Freddy's",'fnaf.mp4','fnaf.png','descricao','00:02:26','2023-10-27',0,6),
(DEFAULT,"Homem-Aranha: Através do Aranhaverso",'miles.mp4','miles.png','descricao','00:02:22','2023-06-01',0,3),
(DEFAULT,"Gato de Botas 2 - O Último Pedido",'botas.mp4','botas.png','descricao','00:03:00','2023-01-05',0,1),
(DEFAULT,"Free Guy - Assumindo o Controle",'freeguy.mp4','freeguy.png','descricao','00:03:25','2021-08-19',0,4),
(DEFAULT,"Festa Da Salsicha",'festasalsicha.mp4','festasalsicha.png','descricao','00:02:22','2016-08-11',0,4),
(DEFAULT,"A Barraca do Beijo 2",'barraca.mp4','barraca.png','descricao','00:02:52','2020-07-24',0,2),
(DEFAULT,"A queda",'queda.mp4','queda.png','descricao','00:02:31','2022-09-29',0,6),
(DEFAULT,"Escape Room",'escape.mp4','escape.png','descricao','00:02:26','2019-02-07',0,6),
(DEFAULT,"A Cinco Passos de Você",'passos.mp4','passos.png','descricao','00:02:19','2019-03-21',0,2),
(DEFAULT,"Flavors of Youth",'flavors.mp4','flavors.png','descricao','00:01:17','2018-08-04',0,5),
(DEFAULT,"Vidas ao Vento",'vidas.mp4','vidas.png','descricao','00:02:16','2014-02-21',0,2),
(DEFAULT,"John Wick 4: Baba Yaga",'wick.mp4','wick.png','descricao','00:02:29','2023-03-23',0,1);

/* 
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '100' WHERE (`id` = '7');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '33' WHERE (`id` = '13');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '14' WHERE (`id` = '14');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '190' WHERE (`id` = '5');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '150' WHERE (`id` = '6');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '41' WHERE (`id` = '16');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '77' WHERE (`id` = '10');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '91' WHERE (`id` = '11');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '111' WHERE (`id` = '2');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '140' WHERE (`id` = '4');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '202' WHERE (`id` = '8');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '96' WHERE (`id` = '12');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '23' WHERE (`id` = '15');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '26' WHERE (`id` = '17');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '149' WHERE (`id` = '1');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '68' WHERE (`id` = '3');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '105' WHERE (`id` = '9');
UPDATE `sistema_cineshow`.`MIDIA` SET `visualizacao` = '57' WHERE (`id` = '18');
*/


/* 1 - Ação
2 - Romance
3 - Aventura
4 - Comédia
5 - Anime
6 - Suspense
*/ 

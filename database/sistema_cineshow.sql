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
(default,'Avatar: O Caminho da Água','avatar.mp4','avatar.png','Após formar uma família, Jake Sully e Neytiri fazem de tudo para ficarem juntos. No entanto, eles devem sair de casa e explorar as regiões de Pandora quando uma antiga ameaça ressurge, e Jake deve travar uma guerra difícil contra os humanos.','00:02:27','2022-12-15',0,1),
(default,'Super Mario Bros','mario.mp4','mario.png','Mario é um encanador junto com seu irmão Luigi. Um dia, eles vão parar no reino dos cogumelos, governado pela Princesa Peach, mas ameaçado pelo rei dos Koopas, que faz de tudo para conseguir reinar em todos os lugares.','00:02:26','2023-04-06',0,3),
(DEFAULT,'Thor: O Mundo Sombrio','thor.mp4','thor.png','Thor precisa contar com a ajuda de seus companheiros e até de seu traiçoeiro irmão Loki em um plano audacioso para salvar o universo. Entretanto, os caminhos de Thor se cruzam com Jane Foster e, dessa vez, a vida dela está realmente em perigo.','00:02:25','2013-11-08',0,1),
(DEFAULT,'Sonic 2 - O Filme','sonic.mp4','sonic.png','O Dr. Robotnik retorna à procura de uma esmeralda mística que tem o poder de destruir civilizações. Para detê-lo, Sonic se une a seu antigo parceiro, Tails, e parte em uma jornada para encontrar a joia antes que ela caia em mãos erradas.','00:02:20','2022-04-08',0,3),
(DEFAULT,'Mob Psycho 100','mob.mp4','mob.png','O protagonista do anime é Shigeo Kageyama, também conhecido como Mob, um jovem garoto tímido e com poderes paranormais. Nenhum espírito ou paranormal consegue se igualar ao poder de Mob, mas todo esse poder imenso é limitado pelas suas emoções.','00:01:53','2022-10-05',0,5),
(DEFAULT,'One Piece','piece.mp4','piece.png','Monkey D. Luffy, um jovem feito de borracha, que, inspirado em seu ídolo de infância, o poderoso pirata Shanks, o Ruivo, parte em uma jornada do mar do East Blue para encontrar o tesouro mítico, o One Piece, e proclamar-se o Rei dos Piratas.','00:01:43','1999-10-20',0,5),
(DEFAULT,"Five Nights At Freddy's",'fnaf.mp4','fnaf.png','Adaptação do jogo homônimo  que acontece em um restaurante familiar tipicamente americano chamado Freddy Fazbears Pizza, onde robôs animados fazem a festa das crianças durante o dia. Mas, quando chega a noite, eles se transformam em assassinos psicopatas.','00:02:26','2023-10-27',0,6),
(DEFAULT,"Homem-Aranha: Através do Aranhaverso",'miles.mp4','miles.png','Depois de se reunir com Gwen Stacy, Homem-Aranha é jogado no multiverso, onde ele encontra uma equipe encarregada de proteger sua própria existência.','00:02:22','2023-06-01',0,3),
(DEFAULT,"Gato de Botas 2 - O Último Pedido",'botas.mp4','botas.png','O Gato de Botas descobre que sua paixão pela aventura cobrou seu preço: ele já gastou oito de suas nove vidas. Ele então parte em uma jornada épica para encontrar o mítico Último Desejo e restaurar suas nove vidas.','00:03:00','2023-01-05',0,1),
(DEFAULT,"Free Guy - Assumindo o Controle",'freeguy.mp4','freeguy.png','Um caixa de banco preso a uma entediante rotina tem sua vida virada de cabeça para baixo quando descobre que é um personagem em um jogo interativo. Agora ele precisa aceitar sua realidade e lidar com o fato de que é o único que pode salvar o mundo.','00:03:25','2021-08-19',0,4),
(DEFAULT,"Festa Da Salsicha",'festasalsicha.mp4','festasalsicha.png','Frank, a salsicha, e seus amigos tentam evitar serem comprados e comidos por humanos em um supermercado.','00:02:22','2016-08-11',0,4),
(DEFAULT,"A Barraca do Beijo 2",'barraca.mp4','barraca.png','Em seu último ano na escola, Elle precisa que lidar com o namoro à distância com Noah, mudanças na amizade com Lee e uma paixão inesperada.','00:02:52','2020-07-24',0,2),
(DEFAULT,"A queda",'queda.mp4','queda.png','Para as melhores amigas Becky e Hunter, a vida é sobre vencer medos e ultrapassar limites. No entanto, depois de subir 600 metros até o topo de uma torre de rádio remota e abandonada, elas acabam presas lá em cima.','00:02:31','2022-09-29',0,6),
(DEFAULT,"Escape Room",'escape.mp4','escape.png','Seis estranhos estão em circunstâncias fora de controle e devem usar sua inteligência e encontrar as pistas para escapar ou morrer na tentativa.','00:02:26','2019-02-07',0,6),
(DEFAULT,"A Cinco Passos de Você",'passos.mp4','passos.png','Stella passa muito tempo no hospital por causa de uma fibrose cística. Lá, ela conhece Will, que sofre da mesma doença. Eles são obrigados a manter distância, mas mesmo assim se apaixonam.','00:02:19','2019-03-21',0,2),
(DEFAULT,"Flavors of Youth",'flavors.mp4','flavors.png','Três histórias nostálgicas na China se desenrolam em recordações evocadas por uma tigela de macarrão, a decadência de uma bela modelo e um primeiro amor com sabor agridoce.','00:01:17','2018-08-04',0,5),
(DEFAULT,"Vidas ao Vento",'vidas.mp4','vidas.png','Jiro Horikoshi é um jovem que vive em uma cidade no interior do Japão. Ele tem o sonho de voar em um avião com formato de pássaro.','00:02:16','2014-02-21',0,2),
(DEFAULT,"John Wick 4: Baba Yaga",'wick.mp4','wick.png','Com o preço por sua cabeça cada vez maior, o lendário assassino de aluguel John Wick leva sua luta contra o High Table global enquanto procura os jogadores mais poderosos do submundo, de Nova York a Paris, do Japão a Berlim.','00:02:29','2023-03-23',0,1);

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

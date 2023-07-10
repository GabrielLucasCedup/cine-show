use sistema_cineshow;

/*       USUARIO          */
SELECT * FROM USUARIO;


/*        MIDIA          */
select * from midia;
SELECT * FROM midia join generos on midia.genero_id = generos.id;
SELECT nome_midia,dir_midia,dir_capa,duracao,data_lancamento,genero_id FROM MIDIA WHERE ID = 9;
SELECT id FROM MIDIA WHERE YEAR(DATA_LANCAMENTO) = YEAR(CURDATE());
SELECT * FROM MIDIA WHERE visualizacao >= (SELECT (visualizacao + 50) as views FROM MIDIA ORDER BY visualizacao DESC LIMIT 4,1) ORDER BY visualizacao DESC;
SELECT visualizacao,(SELECT (visualizacao + 50) FROM MIDIA ORDER BY visualizacao DESC LIMIT 4,1) FROM MIDIA order by VISUALIZACAO DESC;

/*          RETOMAR          */
SELECT * FROM RETOMAR;

/*        AUTOLOGIN           */
SELECT * FROM AUTOLOGIN;  
SELECT * FROM AUTOLOGIN WHERE usuario_id = 'sYuQIN';
UPDATE AUTOLOGIN SET DATA_EFEITO = '2023-05-15' WHERE NUM_DISK = '2626937C';
SELECT * FROM AUTOLOGIN WHERE datediff(curdate(),data_efeito) <= 30

/*
1-Escape Room
2-A Cinco Passos de Você
3-Flavors of Youth
4-Vidas ao Vento
5-A queda
6-Avatar: O Caminho da Água
7-Super Mario Bros
8-Thor: O Mundo Sombrio
9-Sonic 2 - O Filme
10-Mob Psycho 100
11-
12-
13-
14-
15-
16-
17-
18-
*/

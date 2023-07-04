use sistema_cineshow;

/*       USUARIO          */
SELECT * FROM USUARIO;


/*        MIDIA          */
select * from midia;
SELECT * FROM midia join generos on midia.genero_id = generos.id;
SELECT nome_midia,dir_midia,dir_capa,duracao,data_lancamento,genero_id FROM MIDIA WHERE ID = 9;
SELECT id FROM MIDIA WHERE YEAR(DATA_LANCAMENTO) = YEAR(CURDATE());


/*          RETOMAR          */
SELECT * FROM RETOMAR;

/*        AUTOLOGIN           */
SELECT * FROM AUTOLOGIN;  
SELECT * FROM AUTOLOGIN WHERE usuario_id = 'sYuQIN';
UPDATE AUTOLOGIN SET DATA_EFEITO = '2023-05-15' WHERE NUM_DISK = '2626937C';
SELECT * FROM AUTOLOGIN WHERE datediff(curdate(),data_efeito) <= 30


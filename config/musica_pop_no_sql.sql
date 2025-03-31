--
-- Create schema musica
--

CREATE DATABASE IF NOT EXISTS musica;
USE musica;

--
-- Definition of table fornitore
--

CREATE TABLE cd (
  cod_cd int(6) NOT NULL,
  autore varchar(75) NOT NULL,
  casa_disco varchar(30) NOT NULL,
  PRIMARY KEY (cod_cd)
);


--
-- Definition of table cliente
--

CREATE TABLE cliente (
  ntess char(5) NOT NULL,
  nome varchar(75) NOT NULL,
  indirizzo varchar(45) NOT NULL,
  PRIMARY KEY (ntess)
); 

--
-- Definition of table acquisto
--

CREATE TABLE acquisto (
  cod_cd_a int(6) NOT NULL,
  ntess_a char(5) NOT NULL,
  data_acquisto date NOT NULL,
  qty int(2) NOT NULL,
  PRIMARY KEY (cod_cd_a, ntess_a),
  FOREIGN KEY (cod_cd_a) REFERENCES cd(cod_cd),
  FOREIGN KEY (ntess_a) REFERENCES cliente(ntess)	
);

-- il cliente identificato da ntess ha acquistato, in una certa data_acquisto,
-- un certo numero qty di copie del compact disk cod_cd_a

--
-- populating the DB
--
INSERT INTO cd VALUES(1, 'Orazio', 'DiscoJolli');
INSERT INTO cd VALUES(2, 'Ernesto', 'DiscoLuna');
INSERT INTO cd VALUES(3, 'Francesco Guccini', 'DiscoLuna');
INSERT INTO cd VALUES(4, 'Francesco Guccini', 'DiscoLuna');
INSERT INTO cliente VALUES('T1', 'Giovanna', 'Viale Michelino');
INSERT INTO cliente VALUES('T2', 'Ludovica', 'Via Roma');
INSERT INTO cliente VALUES('T3', 'Luca', 'Via Napoli');
INSERT INTO acquisto VALUES(1, 'T1', '1998-04-06', 2);
INSERT INTO acquisto VALUES(2, 'T2', '2001-01-28', 1);
INSERT INTO acquisto VALUES(1, 'T2', '1996-01-28', 1);
INSERT INTO acquisto VALUES(3, 'T3', '1991-01-04', 1);
INSERT INTO acquisto VALUES(3, 'T1', '1993-05-23', 1);
INSERT INTO acquisto VALUES(4, 'T1', '1996-01-21', 1);
--
-- QUERY (ALGEBRA RELAZIONALE a), b))
-- 

-- a) selezionare tutti i dati dei clienti che dopo il 1/1/1997 non hanno acquistato
-- nessun cd prodotto dalla casa discografica 'DiscoJolli'


-- b) selezionare il numero tessera dei clienti che hanno acquistato tuttii cd
-- dell'autore 'Francesco Guccini'


-- c) selezionare, per ogni cd, il numero totale delle copie vendute

-- d) selezionare, per ogni casa discografica, il numero tessera del cliente che ha 
-- acquistato il maggior numero di copie di cd di quella casa


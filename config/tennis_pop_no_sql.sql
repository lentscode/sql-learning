--
-- Create schema tennis
--

CREATE DATABASE IF NOT EXISTS tennis;
USE tennis;

--
-- Definition of table campo
--

CREATE TABLE campo (
  nome_campo varchar(75) NOT NULL,
  tipo varchar(10) NOT NULL,
  indirizzo varchar(45) NOT NULL,
  PRIMARY KEY (nome_campo)
);

--
-- Definition of table tennista
--

CREATE TABLE tennista (
  cf char(16) NOT NULL,
  nome varchar(75) NOT NULL,
  nazione char(3) NOT NULL,
  PRIMARY KEY (cf)
); 

--
-- Definition of table incontro
--

CREATE TABLE incontro (
  cod_i char(6) NOT NULL,
  nome_campo_i varchar(75) NOT NULL,
  giocatore1 char(16) NOT NULL,
  giocatore2 char(16) NOT NULL,
  set1 int NOT NULL,
  set2 int NOT NULL,
  PRIMARY KEY (cod_i),
  FOREIGN KEY (nome_campo_i) REFERENCES campo(nome_campo),
  FOREIGN KEY (giocatore1) REFERENCES tennista(cf),
  FOREIGN KEY (giocatore2) REFERENCES tennista(cf)
);

-- incontro, svolto nel campo nome_campo_i, tra i tennisti giocatore1 e giocatore2:
-- in set1 e set2 sono riportati il numero di set vinti da giocatore1 e giocatore2 rispettivamente   

--
-- populating the DB
--

INSERT INTO campo VALUES ('Arthur Ashe Stadium', 'Cemento', 'Queens'),
('Rochus Club', 'Terra', 'Via Berlino'),
('Comet Club', 'Erba', 'Via Roma'),
('Tennis Club', 'Erba', 'Via Milano'),
('Crazy Tennis', 'Erba', 'Via Palermo');
INSERT INTO tennista VALUES ('N', 'Nadal', 'SPA'),
('A', 'Agassi', 'USA'),
('F', 'Federer', 'SVI'),
('L', 'Laver', 'AUS');
INSERT INTO incontro VALUES (1, 'Arthur Ashe Stadium', 'N', 'F', 6, 4),
(2, 'Arthur Ashe Stadium', 'A', 'N', 6, 0),
(3, 'Arthur Ashe Stadium', 'L', 'A', 2, 6),
(4, 'Arthur Ashe Stadium', 'F', 'L', 4, 6),
(5, 'Comet Club', 'A', 'F', 6, 2),
(6, 'Comet Club', 'L', 'N', 6, 1),
(7, 'Tennis Club', 'F', 'N', 6, 3);

--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
-- 

-- a)selezionare gli incontri disputati sull'erba (campo con tipo 'erba')

-- b)selezionare i campi in erba sui quali non c'è stato nessun incontro

-- c)selezionare i dati dei tennisti vincitori di almeno una partita sull'erba

-- d)selezionare i dati delle nazioni in cui tutti i giocatori hanno sempre
-- vinto le partite disputate

-- e)selezionare il campo in erba che ha ospitato il maggior numero di incontri


    
    
    
    
--
-- Create schema golf
--

CREATE DATABASE IF NOT EXISTS golf;
USE golf;

--
-- Definition of table gara
--

CREATE TABLE gara (
  cod_g char(5) NOT NULL,
  nome_campo varchar(45) NOT NULL,
  livello varchar(20),
  PRIMARY KEY (cod_g)
); 

--
-- Definition of table giocatore
--

CREATE TABLE giocatore (
  cf char(16) NOT NULL,
  nome varchar(75) NOT NULL,
  nazione char(3) NOT NULL,
  PRIMARY KEY (cf)
);

--
-- Definition of table partecipa
--

CREATE TABLE partecipa (
  cod_g_p char(5) NOT NULL,
  cf_p char(16) NOT NULL,
  punteggio int(3) NOT NULL,
  PRIMARY KEY (cod_g_p, cf_p),
  FOREIGN KEY (cod_g_p) REFERENCES gara(cod_g),
  FOREIGN KEY (cf_p) REFERENCES giocatore(cf)	
);

-- il giocatore cf partecipa alla gara cod_g totalizzando un certo punteggio.
-- la gara è vinta dal giocatore che totalizza il punteggio più basso

--
-- populating the DB
--

INSERT INTO gara VALUES('G1', 'Golf Club', 'Nazionale');
INSERT INTO gara VALUES('G2', 'Star Golf Club', 'Internazionale');
INSERT INTO gara VALUES('G3', 'ABC Golf', 'Nazionale');
INSERT INTO giocatore VALUES('GCC', 'Orazio Genova', 'ITA');
INSERT INTO giocatore VALUES('MRR', 'Mario Rossi', 'ITA');
INSERT INTO giocatore VALUES('OSS', 'Osvaldo Marconi', 'ITA');
INSERT INTO giocatore VALUES('COO', 'Carlo Orazio', 'ITA');
INSERT INTO giocatore VALUES('MAA', 'Michele Antonelli', 'ITA');
INSERT INTO giocatore VALUES('LMM', 'Lorenzo Meucci', 'ITA');
INSERT INTO giocatore VALUES('SSH', 'John Smith', 'USA');
INSERT INTO partecipa VALUES('G2', 'GCC', -13);
INSERT INTO partecipa VALUES('G2', 'MRR', -19);
INSERT INTO partecipa VALUES('G1', 'MRR', -1);
INSERT INTO partecipa VALUES('G3', 'MRR', -2);
INSERT INTO partecipa VALUES('G2', 'SSH', 1);
INSERT INTO partecipa VALUES('G2', 'OSS', -15);
INSERT INTO partecipa VALUES('G2', 'COO', -24);
INSERT INTO partecipa VALUES('G2', 'MAA', -20);
INSERT INTO partecipa VALUES('G2', 'LMM', -19);
--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
-- 

-- a) selezionare i dati dei giocatori di golf che hanno partecipato ad almeno
-- una gara disputata a livello 'nazionale'


-- b) selezionare le nazioni in cui tutti i giocatori hanno ottenuto un punteggio
-- minore o uguale a 0 nelle gare disputate

-- c) selezionare i dati dei giocatori di golf che hanno partecipato a tutte le 
-- gare disputate a livello 'nazionale'


-- d) selezionare i dati dei giocatori di golf che hanno vinto almeno una gara
-- disputata a livello 'internazionale'


-- e) selezionare, per ogni nazione che nelle gare di livello 'internazionale' ha
-- schierato più di 5 giocatori distinti, il punteggio medio ottenuto dai giocatori
-- in tali gare; si ordini il risultato in modo decrescente rispetto al punteggio medio


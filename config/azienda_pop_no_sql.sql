--
-- Create schema azienda
--

CREATE DATABASE IF NOT EXISTS azienda;
USE azienda;

--
-- Definition of table dipendente
--

CREATE TABLE dipendente (
  cf char(16) NOT NULL,
  nome varchar(75) NOT NULL,
  citta varchar(30) NOT NULL,
  PRIMARY KEY (cf)
);


--
-- Definition of table progetto
--

CREATE TABLE progetto (
  cod_p char(5) NOT NULL,
  nome_progetto varchar(45) NOT NULL,
  anno int(4),
  durata int(2),
  PRIMARY KEY (cod_p)
); 

--
-- Definition of table lavora
--

CREATE TABLE lavora (
  cod_p_l char(5) NOT NULL,
  cf_l char(16) NOT NULL,
  mesi int(2) NOT NULL,
  ruolo varchar (30) NOT NULL,
  PRIMARY KEY (cod_p_l, cf_l),
  FOREIGN KEY (cod_p_l) REFERENCES progetto(cod_p),
  FOREIGN KEY (cf_l) REFERENCES dipendente(cf)	
);

-- nel progetto cod_p il dipendente cf lavora per un certo numero di mesi, svolgendo un certo ruolo

--
-- populating the DB
--
INSERT INTO dipendente VALUES('CFF', 'Carlo Fontana', 'Milano');
INSERT INTO dipendente VALUES('OSA', 'Osvaldo Acqua', 'Modena');
INSERT INTO dipendente VALUES('MRR', 'Mario Rossi', 'Modena');
INSERT INTO dipendente VALUES('GMR', 'Gugliemo Marconi', 'Modena');
INSERT INTO progetto VALUES('P1', 'Progetto Ludovico', 1994, 4);
INSERT INTO progetto VALUES('P2', 'Progetto Stella', 1991, 6);
INSERT INTO progetto VALUES('P3', 'Progetto Sole', 1995, 2);
INSERT INTO lavora VALUES('P1', 'CFF', 2, 'Analista');
INSERT INTO lavora VALUES('P3', 'CFF', 2, 'Responsabile');
INSERT INTO lavora VALUES('P2', 'CFF', 3, 'Progettista');
INSERT INTO lavora VALUES('P3', 'MRR', 2, 'Progettista');
INSERT INTO lavora VALUES('P3', 'OSA', 2, 'Progettista');


--
-- QUERY (ALGEBRA RELAZIONALE a), b))
-- 

-- a) selezionare i dati dei dipendenti di Modena che non hanno lavorato
-- in alcun progetto dell'anno 1995
 


-- b) selezionare i dti dei dipendenti che non hanno mai lavorato insieme
-- ad un dipoendente di Modena, cioè nello stesso progetto in cui lavorava
-- anche un dipendente di Modena



-- c) selezionare le coppie (cf1, cf2) tali che i dipendenti con codice fiscale
-- cf1 e cf2 hanno lavorato nello stesso progetto



-- d) selezionare i dipendenti che hanno lavorato in almeno 3 ruoli distinti



-- e) selezionare, per ogni dipendente, il progetto in cui esso ha lavorato
-- il maggior numero di mesi


--
-- Create schema universita
--

CREATE DATABASE IF NOT EXISTS universita;
USE universita;

--
-- Definition of table dipartimento
--
-- Rappresenta i dipartimenti accademici
--
CREATE TABLE dipartimento (
  cod_dip char(3) NOT NULL,
  nome_dip varchar(100) NOT NULL,
  sede varchar(50),
  PRIMARY KEY (cod_dip)
);

--
-- Definition of table docente
--
-- Rappresenta i docenti universitari
--
CREATE TABLE docente (
  cod_doc char(5) NOT NULL,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  ufficio varchar(20),
  cod_dip_d char(3) NOT NULL,
  PRIMARY KEY (cod_doc),
  FOREIGN KEY (cod_dip_d) REFERENCES dipartimento (cod_dip)
);

--
-- Definition of table studente
--
-- Rappresenta gli studenti iscritti
--
CREATE TABLE studente (
  matricola varchar(10) NOT NULL,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  data_nascita date,
  email varchar(100) UNIQUE,
  PRIMARY KEY (matricola)
);

--
-- Definition of table corso
--
-- Rappresenta i corsi offerti dall'università
--
CREATE TABLE corso (
  cod_corso char(6) NOT NULL,
  nome_corso varchar(100) NOT NULL,
  crediti int NOT NULL,
  anno_accademico varchar(9), -- es. '2024/2025'
  cod_doc_titolare char(5) NOT NULL,
  cod_dip_c char(3) NOT NULL,
  PRIMARY KEY (cod_corso),
  FOREIGN KEY (cod_doc_titolare) REFERENCES docente (cod_doc),
  FOREIGN KEY (cod_dip_c) REFERENCES dipartimento (cod_dip)
);

--
-- Definition of table iscrizione
--
-- Rappresenta l'iscrizione di uno studente a un corso e l'eventuale voto finale
--
CREATE TABLE iscrizione (
  matricola_s varchar(10) NOT NULL,
  cod_corso_i char(6) NOT NULL,
  data_iscrizione date NOT NULL,
  voto int, -- Voto finale conseguito (NULL se non ancora sostenuto/registrato)
  PRIMARY KEY (matricola_s, cod_corso_i),
  FOREIGN KEY (matricola_s) REFERENCES studente (matricola),
  FOREIGN KEY (cod_corso_i) REFERENCES corso (cod_corso),
  CONSTRAINT chk_voto CHECK (voto IS NULL OR (voto >= 18 AND voto <= 30)) -- Voto tra 18 e 30
);


--
-- Populating the DB
--

INSERT INTO dipartimento (cod_dip, nome_dip, sede) VALUES
('INF', 'Informatica', 'Edificio Stecca'),
('ING', 'Ingegneria', 'Edificio Principale'),
('MAT', 'Matematica', 'Edificio Polo Scientifico'),
('LET', 'Lettere', 'Edificio Umanistico');

INSERT INTO docente (cod_doc, nome, cognome, ufficio, cod_dip_d) VALUES
('D0001', 'Paolo', 'Bianchi', 'Uff. 101', 'INF'),
('D0002', 'Maria', 'Rossi', 'Uff. 102', 'INF'),
('D0003', 'Giovanni', 'Verdi', 'Uff. 205', 'ING'),
('D0004', 'Laura', 'Neri', 'Uff. 310', 'MAT'),
('D0005', 'Antonio', 'Gialli', 'Uff. 15', 'LET'),
('D0006', 'Serena', 'Bruni', 'Uff. 312', 'MAT');

INSERT INTO studente (matricola, nome, cognome, data_nascita, email) VALUES
('S1001', 'Carlo', 'Fontana', '2003-05-15', 'carlo.fontana@email.it'),
('S1002', 'Elisa', 'Rizzo', '2004-01-20', 'elisa.rizzo@email.it'),
('S1003', 'Marco', 'Conti', '2003-11-08', 'marco.conti@email.it'),
('S1004', 'Sofia', 'Galli', '2002-07-30', 'sofia.galli@email.it'),
('S1005', 'Luca', 'Ferrari', '2004-03-12', 'luca.ferrari@email.it');

INSERT INTO corso (cod_corso, nome_corso, crediti, anno_accademico, cod_doc_titolare, cod_dip_c) VALUES
('INF001', 'Programmazione 1', 9, '2024/2025', 'D0001', 'INF'),
('INF002', 'Basi di Dati', 6, '2024/2025', 'D0002', 'INF'),
('ING001', 'Analisi Matematica 1', 12, '2024/2025', 'D0004', 'ING'),
('MAT001', 'Algebra Lineare', 6, '2024/2025', 'D0006', 'MAT'),
('LET001', 'Letteratura Italiana', 6, '2024/2025', 'D0005', 'LET'),
('INF003', 'Algoritmi e Strutture Dati', 9, '2024/2025', 'D0001', 'INF');

INSERT INTO iscrizione (matricola_s, cod_corso_i, data_iscrizione, voto) VALUES
('S1001', 'INF001', '2024-10-01', 28),
('S1001', 'INF002', '2024-10-01', 25),
('S1001', 'ING001', '2024-10-01', NULL), -- Esame non ancora sostenuto
('S1002', 'INF001', '2024-10-05', 30),
('S1002', 'LET001', '2024-10-05', 22),
('S1003', 'INF001', '2024-10-10', 24),
('S1003', 'INF002', '2024-10-10', 27),
('S1003', 'MAT001', '2024-10-10', 29),
('S1004', 'ING001', '2024-10-12', 26),
('S1004', 'MAT001', '2024-10-12', NULL),
('S1005', 'INF001', '2024-10-15', 18),
('S1005', 'INF002', '2024-10-15', 24),
('S1005', 'INF003', '2024-10-15', 20);

-- a)  Selezionare la matricola, il nome e il cognome degli studenti nati dopo il '2003-01-01'.

-- b)  Selezionare il nome dei corsi (tabella corso) offerti dal dipartimento di 'Informatica' (codice 'INF') che valgono più di 6 crediti.

-- c)  Selezionare il nome e il cognome dei docenti che appartengono al dipartimento di 'Matematica' e il nome del corso di cui sono titolari.

-- d)  Selezionare la matricola degli studenti che sono iscritti al corso 'INF001' ma non al corso 'INF002'.

-- e)  Selezionare la matricola e l'email degli studenti che hanno ottenuto un voto pari a 30 in almeno un esame.

-- f)  Per ogni dipartimento, contare quanti docenti vi appartengono. Selezionare il nome del dipartimento e il numero di docenti.

-- g)  Selezionare il codice del corso (o dei corsi) che ha il maggior numero di studenti iscritti (indipendentemente dal voto).

-- h)  Selezionare la matricola, il nome e il cognome degli studenti che si sono iscritti a tutti i corsi offerti dal dipartimento di 'Informatica' ('INF').

-- i)  Calcolare la media dei voti (escludendo i NULL) per ogni studente. Selezionare matricola, nome, cognome e media voti, ordinando per media decrescente. (Attenzione: uno studente potrebbe non avere voti registrati).

-- j)  Selezionare il nome e il cognome dei docenti che non sono titolari di nessun corso con meno di 9 crediti.
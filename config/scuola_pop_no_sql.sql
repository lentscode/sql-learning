--
-- Create schema scuola
--

CREATE DATABASE IF NOT EXISTS scuola;
USE scuola;

--
-- Definition of table docente
--

CREATE TABLE docente (
  cf_doc char(16) NOT NULL,
  nome_d varchar(45) NOT NULL,
  cognome_d varchar(45) NOT NULL,
  PRIMARY KEY (cf_doc)
);

--
-- Definition of table studente
--

CREATE TABLE studente (
  cf_stud char(16) NOT NULL,
  nome_s varchar(45) NOT NULL,
  cognome_s varchar(45) NOT NULL,
  PRIMARY KEY (cf_stud)
); 

--
-- Definition of table argomento
--

CREATE TABLE argomento (
  cod_arg char(5) NOT NULL,
  descrizione varchar(45) NOT NULL,
  PRIMARY KEY (cod_arg)
);

--
-- Definition of table lezione
--

CREATE TABLE lezione (
  cod_arg_l char(5) NOT NULL,
  data_lezione date NOT NULL,
  cf_doc_l char(16) NOT NULL,
  numstudenti int(30) NOT NULL,
  PRIMARY KEY (cod_arg_l, data_lezione),
  FOREIGN KEY (cod_arg_l) REFERENCES argomento (cod_arg),
  FOREIGN KEY (cf_doc_l) REFERENCES docente (cf_doc)
);

-- dove numstudenti è il numero di studenti presenti alla lezione

--
-- Definition of table interrogazione
--

CREATE TABLE interrogazione (
  cod_arg_i char(5) NOT NULL,
  data_lezione_i date NOT NULL,
  cf_stud_i char(16) NOT NULL,
  voto numeric(3,1),
  PRIMARY KEY (cod_arg_i, data_lezione_i, cf_stud_i),
  FOREIGN KEY (cod_arg_i, data_lezione_i) REFERENCES lezione (cod_arg_l, data_lezione),
  FOREIGN KEY (cf_stud_i) REFERENCES studente (cf_stud)
);

-- Interrogazione e voto relativo dello studente cf_stud_i durante una lezione

--
-- populating the DB
--

INSERT INTO docente VALUES
('001','Albert','Einstein'),
('002','Galileo', 'Galilei'),
('003','Karl', 'Marx');

INSERT INTO studente VALUES
('999', 'Mario', 'Rossi'),
('998', 'Maria', 'Neri'),
('997', 'Piero', 'Gialli'),
('996', 'Giorgio', 'Verdi');

INSERT INTO argomento VALUES
('555', 'Fisica'),
('666', 'Religione'),
('777', 'Fisica'),
('888', 'Matematica'),
('444', 'Filosofia');

INSERT INTO lezione VALUES 
('555', '1-1-1', '001', 15),
('555', '2-1-1', '002', 15),
('555', '3-1-1', '002', 15),
('555', '4-1-1', '002', 15),
('555', '5-1-1', '002', 15),
('555', '6-1-1', '002', 15),
('666', '7-1-1', '003', 15),
('666', '8-1-1', '002', 15),
('555', '9-1-1', '003', 15),
('777', '1-1-1', '002', 15),
('888', '2-1-1', '002', 15),
('444', '2-1-1', '003', 15);

INSERT INTO interrogazione VALUES -- cod arg, data, cod stud, voto
('555', '1-1-1', '999', 10),
('555', '2-1-1', '999', 6),
('555', '3-1-1', '998', 6),
('555', '4-1-1', '999', 6),
('555', '5-1-1', '999', 6),
('555', '6-1-1', '998', 8),
('666', '7-1-1', '998', 6),
('666', '8-1-1', '998', 5),
('555', '9-1-1', '997', 6),
('777', '1-1-1', '999', 4),
('888', '2-1-1', '996', 4),
('444', '2-1-1', '998', 7);

--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
-- 

-- a) selezionare il codice fiscale, il nome ed il cognome degli studenti che non
-- sono mai stati interrogati su un argomento con descrizione 'Fisica'



-- b) selezionare il codice fiscale del docente che ha svolto lezioni su tutti
-- gli argomenti con descrizione 'Fisica'



-- c) selezionare il codice fiscale del docente che ha sempre interrogato,
-- cioè che durante ogni sua lezione ha fatto almeno una interrogazione
                      

-- d) selezionare, per ogni argomento, la media dei voti riportati dagli
-- studenti interrogati
-- sull'argomento, considerando solo gli studenti che sono stati interrogati
 -- almeno tre
-- volte sull'argomento in questione



-- e) selezionare, per ogni studente, il codice fiscale del docente con 
-- il quale ha effettuato
-- il maggior numero di interrogazioni


    
    
    
    
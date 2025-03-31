--
-- Create schema acquisti
--

CREATE DATABASE IF NOT EXISTS acquisti;
USE acquisti;

--
-- Definition of table operatore
--

CREATE TABLE operatore (
  cod_op char(16) NOT NULL,
  nome varchar(45) NOT NULL,
  indirizzo varchar(45) NOT NULL,
  qualifica varchar(30) NOT NULL,
  costo_orario int(2) NOT NULL,
  PRIMARY KEY (cod_op)
);

--
-- Definition of table articolo
--

CREATE TABLE articolo (
  cod_a char(5) NOT NULL,
  descrizione varchar(45) NOT NULL,
  PRIMARY KEY (cod_a)
); 

--
-- Definition of table lotto
--

CREATE TABLE lotto (
  cod_a_l char(5) NOT NULL,
  cod_op_l char(16) NOT NULL,
  tot_esem int(2),
  PRIMARY KEY (cod_a_l, cod_op_l),
  FOREIGN KEY (cod_a_l) REFERENCES articolo (cod_a),
  FOREIGN KEY (cod_op_l) REFERENCES operatore (cod_op)
);

-- dove tot_esem è il umero di pezzi dell'articolo cod_a_l

--
-- Definition of table reclamo
--

CREATE TABLE reclamo (
  cod_a_r char(5) NOT NULL,
  cod_op_r char(16) NOT NULL,
  n_esemplare varchar(45) NOT NULL,
  nome_cl varchar (75) NOT NULL,
  PRIMARY KEY (cod_a_r, cod_op_r, n_esemplare),
  FOREIGN KEY (cod_a_r, cod_op_r) REFERENCES Lotto (cod_a_l, cod_op_l)
);


-- reclamo effettuato dal cliente nome_cl sull'esemplare n_esemplare del lotto confezionato
-- dall'opertore cod_op_r relativo all'articolo cod_a_r


--
-- populating the DB
--

INSERT INTO operatore (cod_op, nome, indirizzo, qualifica, costo_orario)
VALUES ('mclfnc81c27g273q', 'Francesco Macellaro', 'via Strada 1', 'Metalmeccanico', '10'),
('rssmro82c27g273q', 'Mario Rossi', 'via Piazza 1', 'Impiegato', '15'),
('bncmrc83c27g273q', 'Marco Bianchi', 'via Incrocio 11', 'Dirigente', '25'),
('gllgvn84c27g273q', 'Giovanni Gialli', 'via Ponte 51', 'Presidente', '40'),
('nrigrg85c27g273q', 'Giorgio Neri', 'via Rotonda 18', 'Amministratore', '35');

INSERT INTO articolo (cod_a, descrizione)
VALUES ('12345', 'Divano'),
('23456', 'Cuscino'),
('34567', 'Copridivano'),
('15387', 'Materasso'),
('25879', 'Rete matrimoniale');

INSERT INTO lotto (cod_a_l, cod_op_l, tot_esem)
VALUES ('12345', 'rssmro82c27g273q', '6'),
('23456', 'gllgvn84c27g273q', '10'),
('34567', 'bncmrc83c27g273q', '8');

INSERT INTO reclamo (cod_a_r, cod_op_r, n_esemplare, nome_cl)
VALUES ('12345', 'rssmro82c27g273q', '2', 'Giovanni Genua'),
('23456', 'gllgvn84c27g273q', '5', 'Andrea Di Maso'),
('34567', 'bncmrc83c27g273q', '8', 'Lorenzo Pascucci');

--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
-- 

-- a)selezionare il codice ed il nome degli operatori per i quali non esiste alcun reclamo,
-- cioè per i quali nessun esemplare di nessun lotto da essi confezionato ha ricevuto un reclamo



-- b)selezionare il codice degli operatori per i quali ogni lotto da essi confezionato contiene almeno
-- un esemplare al quale si riferisce un reclamo



-- c)selezionare il nome del cliente che ha fatto reclami per tutti gli operatori



-- d)selezionare, per ogni articolo, il codice dell'operatore che ha confezionato il lotto con il 
-- maggior numero di esemplari, senza considerare i lotti con un numero di esemplari tot_esem non specificato



-- e)selezionare il lotto cha ha ricevuto più reclami



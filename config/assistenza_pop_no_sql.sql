--
-- Create schema assistenza
--

CREATE DATABASE IF NOT EXISTS assistenza5;
USE assistenza5;

--
-- Definition of table tecnico
--

CREATE TABLE tecnico (
  cf char(4) NOT NULL,
  indirizzo varchar(45) NOT NULL,
  qualifica varchar(30) NOT NULL,
  costo_orario int(2) NOT NULL,
  PRIMARY KEY (cf)
);


--
-- Definition of table pc
--

CREATE TABLE pc (
  cod_pc char(4) NOT NULL,
  nome varchar(45) NOT NULL,
  tipo varchar(20),
  nome_proprietario varchar(75) NOT NULL,
  PRIMARY KEY (cod_pc)
); 

--
-- Definition of table riparazione
--

CREATE TABLE riparazione (
  data_riparazione date NOT NULL,
  cf_r char(4) NOT NULL,
  cod_pc_r char(4) NOT NULL,
  ore int(2) NOT NULL,
  PRIMARY KEY (data_riparazione, cf_r, cod_pc_r),
  FOREIGN KEY (cf_r) REFERENCES tecnico(cf),
  FOREIGN KEY (cod_pc_r) REFERENCES pc(cod_pc)	
);

-- nella data-riparazione specificata, il tecnico cf ha riparato il personal computer
-- cod_pc impiegando un certo numero di ore

--
-- populating the DB
--

INSERT INTO pc VALUES('G223', 'Golf Club', 'Mac','Luigi Mario');
INSERT INTO pc VALUES('G122', 'Kuilo', 'Mac','Mario Mario');
INSERT INTO pc VALUES('G123', 'Truttle', 'Mac','Mario Neri');
INSERT INTO pc VALUES('d122', 'Gob', 'IBM','Lori Delano');
INSERT INTO pc VALUES('G132', 'GoClaM', 'HP','Trusty Patches');
INSERT INTO pc VALUES('h122', 'Golberd', 'Asus','Almond Nutt');

INSERT INTO tecnico VALUES('aaaa', 'Via limone', 'tecnico',30);
INSERT INTO tecnico VALUES('aada', 'Via Pesca', 'tecnico',11);
INSERT INTO tecnico VALUES('adaa', 'Via Ananas', 'tecnico',99);
INSERT INTO tecnico VALUES('daaa', 'Via dei chierici', 'tecnico',3);


INSERT INTO riparazione VALUES('1998-04-06','daaa','h122','30');
INSERT INTO riparazione VALUES('1998-5-06','aaaa','G122','10');
INSERT INTO riparazione VALUES('1997-07-07','adaa','G122','1');
INSERT INTO riparazione VALUES('1999-04-06','aaaa','d122','30');
INSERT INTO riparazione VALUES('1999-04-06','daaa','G132','30');
INSERT INTO riparazione VALUES('1999-04-06','daaa','G122','30');
INSERT INTO riparazione VALUES('1999-04-06','daaa','G123','30');
INSERT INTO riparazione VALUES('1999-04-06','daaa','G223','30');


-- QUERY (ALGEBRA RELAZIONALE a), b))
-- 

-- a) selezionare i personal di tipo 'Mac' che non sono stati riparati tra il 1/7/97
-- e il 1/11/97


-- b) selezionare i tecnici che hanno riparato tutti i personal di tipo 'Mac'



-- c) selezionare le coppie (PC1, PC2) tali che i personal con codice PC1 e PC2
-- sono stati riparati nella stessa data dallo stesso tecnico



-- d) selezionare i dati dei personal che hanno richiesto almeno 10 ore di riparazione



-- e) selezionare, per ogni data, il tecnico che ha riparato ilmaggior numero di personal



-- f) selezionare il personal che ha totalizzato il maggior costo di riparazione,
-- considerando le ore di riparazione e il relativo costo orario


            
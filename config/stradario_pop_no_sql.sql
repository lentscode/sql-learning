--
-- Create schema stradario
--

CREATE DATABASE IF NOT EXISTS stradario;
USE stradario;

--
-- Definition of table via
--

CREATE TABLE via (
  cod_via char(5) NOT NULL,
  nome varchar(75) NOT NULL,
  quartiere varchar(45) NOT NULL,
  lunghezza numeric(6,3),
  PRIMARY KEY (cod_via)
);

--
-- Definition of table incrocio
--

CREATE TABLE incrocio (
  cod_via_a char(5) NOT NULL,
  cod_via_b char(5) NOT NULL,
  n_volte int,
  PRIMARY KEY (cod_via_a, cod_via_b),
  FOREIGN KEY (cod_via_a) REFERENCES via(cod_via),
  FOREIGN KEY (cod_via_b) REFERENCES via(cod_via)
); 

-- la via cod_via_a incrocia n_volte la via cod_via_b
-- si assume che se nella rlazione incrocio è presente la tupla (cod_via_a, cod_via_b, 5) 
-- non sia presente la tupla simmetrica (cod_via_b, cod_via_a, 5) 

--
-- populating the DB
--

INSERT INTO via VALUES -- cod_via, nome, quartiere, lung
('01','Main St','Pastena',100),
('02','2nd Av','Pastena',101),
('03','3rd St','02',102),
('04','4th St','03',103),
('05','5th St','03',104),
('06','6th St','03',105),
('07','Wall St','02',106),
('08','New St','04',107),
('09','Old St','03',108),
('10','Marco Polo','Pastena',109);

INSERT INTO incrocio VALUES
('01','02',3),--
('03','02',5),--
('04','03',1),
('10','07',2),--
('05','03',2),
('01','10',31),--
('09','06',3),
('07','08',4),
('02','09',5),--
('01','05',12),--
('05','06',10);
--
-- QUERY (ALGEBRA RELAZIONALE a), b))
-- 

-- a)selezionare le vie che incrociano almeno una via del quartiere 'Pastena'

-- b)selezionare le vie che non incrociano via 'Marco Polo'

-- c)selezionare le coppie (codice1, codice2) tali che le vie con codice codice1
-- e codice2 abbiano la steessa lunghezza

-- d)selezionare il quartiere che ha il maggior numero di vie

-- e)selezionare per ogni quartiere, la via di lunghezza maggiore

-- f)selezionare le vie che incrociano tutte le vie del quartiere 'Pastena'


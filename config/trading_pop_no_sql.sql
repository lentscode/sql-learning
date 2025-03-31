--
-- Create schema trading
--

CREATE DATABASE IF NOT EXISTS trading;
USE trading;

--
-- Definition of table prodotto
--

CREATE TABLE prodotto (
  cod_p char(5) NOT NULL,
  descrizione varchar(45) NOT NULL,
  PRIMARY KEY (cod_p)
);

--
-- Definition of table socio
--

CREATE TABLE socio (
  cod_s char(16) NOT NULL,
  nome varchar(45) NOT NULL,
  cognome varchar(45) NOT NULL,
  PRIMARY KEY (cod_s)
); 

--
-- Definition of table offerta
--

CREATE TABLE offerta (
  cod_o char(5) NOT NULL,
  validita date NOT NULL,
  PRIMARY KEY (cod_o)
);

--
-- Definition of table comprende
--

CREATE TABLE comprende (
  cod_o_c char(5) NOT NULL,
  cod_p_c char(5) NOT NULL,
  quantita int(4) NOT NULL, -- E' IL NUMERO DI UNITA' DEL PRODOTTO cod_p_c COMPRESE NELL'OFFERTA cod_o_c
  PRIMARY KEY (cod_o_c, cod_p_c),
  FOREIGN KEY (cod_o_c) REFERENCES offerta (cod_o),
  FOREIGN KEY (cod_p_c) REFERENCES prodotto (cod_p)
);

--
-- Definition of table ritira
--

CREATE TABLE ritira (
  cod_o_r char(5) NOT NULL,
  cod_s_r char(16) NOT NULL,
  giorno date NOT NULL, -- E' IL GIORNO IN CUI IL SOCIO cod_s_r RITIRA L'OFFERTA cod_o_r
  PRIMARY KEY (cod_o_r, cod_s_r),
  FOREIGN KEY (cod_o_r) REFERENCES offerta (cod_o),
  FOREIGN KEY (cod_s_r) REFERENCES socio (cod_s)
);

--
-- populating the DB
--

INSERT INTO prodotto VALUES
('01', 'Uva'),
('02', 'Pera'),
('03', 'Mela'),
('04', 'Uva'),
('05', 'Miele'),
('06', 'Banana');

INSERT INTO socio VALUES
('99', 'Mario', 'Rossi'),
('98', 'Mario', 'Bonolis'),
('97', 'Mario', 'Brutti'),
('96', 'Mario', 'Belli'),
('95', 'Mario', 'Bianchi'),
('94', 'Mario', 'Verdi'),
('93', 'Mario', 'Gialli'),
('92', 'Mario', 'Neri');

INSERT INTO offerta VALUES
('55','1-1-1'),
('66','1-3-1'),
('44','1-2-1');

INSERT INTO comprende VALUES
('55','01',12),
('55','02',14),
('55','06',15),
('44','01',12),
('44','04',11),
('44','05',12),
('66','06',25);

INSERT INTO ritira VALUES
('55','99','1-1-1'),
('44','99','1-1-1'),
('55','98','1-1-1'),
('66','97','1-1-1'),
('66','93','1-1-1'),
('66','96','1-1-1'),
('44','92','1-1-1');

--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
-- 

-- a) selezionare il codice e la descrizione dei prodotti che non sono mai stati offerti
-- insieme con un prodotto con descrizione = 'Uva'

-- b) selezionare il codice, il nome ed il cognome dei soci che non hanno ritirato alcuna
-- offerta che comprende un prodotto con descrizione = 'Uva'

-- c) selezionare il codice, il nome ed il cognome dei soci che hanno ritirato tutte
-- le offerte che comprendono un prodotto con descrizione = 'Uva'

-- d) selezionare, per ogni socio, il numero delle offerte ritirate che comprendono 
-- un prodotto con descrizione = 'Uva'


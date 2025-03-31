a--
-- Create schema rifornimenti
--

CREATE DATABASE IF NOT EXISTS rifornimenti;
USE rifornimenti;

--
-- Definition of table fornitore
--

CREATE TABLE fornitore (
  cf char(16) NOT NULL,
  nome_fornitore varchar(75) NOT NULL,
  citta varchar(30) NOT NULL,
  PRIMARY KEY (cf)
);

--
-- Definition of table prodotto
--

CREATE TABLE prodotto (
  cod_p char(5) NOT NULL,
  descrizione varchar(45) NOT NULL,
  prezzo numeric(6,2),
  PRIMARY KEY (cod_p)
); 

--
-- Definition of table fornisce
--

CREATE TABLE fornisce (
  anno int(4) NOT NULL, -- nell'anno specificato, il prodotto cod_p è stato fornito dal fornitore cod_f in quantità qty
  cod_p_f char(5) NOT NULL,
  cf_f char(16) NOT NULL,
  qty int(2) NOT NULL,
  PRIMARY KEY (anno, cod_p_f, cf_f),
  FOREIGN KEY (cod_p_f) REFERENCES prodotto(cod_p),
  FOREIGN KEY (cf_f) REFERENCES fornitore(cf)	
);

--
-- populating the DB
--

INSERT INTO fornitore VALUES ('A', 'Antonio', 'Padova');
INSERT INTO fornitore VALUES ('B', 'Michele', 'Perugia');
INSERT INTO fornitore VALUES ('C', 'Ernesto', 'Modena');
INSERT INTO prodotto VALUES ('P1', 'Pasta', 3.40);
INSERT INTO prodotto VALUES ('P2', 'Pizza', 5.00);
INSERT INTO prodotto VALUES ('P3', 'Acqua', 2.00);
INSERT INTO fornisce VALUES ('1994', 'P1', 'A', 2000);
INSERT INTO fornisce VALUES ('1995', 'P1', 'B', 6420);
INSERT INTO fornisce VALUES ('1998', 'P2', 'B', 1200);
INSERT INTO fornisce VALUES ('1995', 'P1', 'C', 800);
INSERT INTO fornisce VALUES ('1997', 'P3', 'A', 800);
INSERT INTO fornisce VALUES ('1994', 'P3', 'C', 6300);

--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
--

-- a) selezionare i prodotti che nell'anno 1995 sono stati forniti da almeno un fornitore di Modena



-- b) selezionare i prodottinon forniti da nessun fornitore di Modena



-- c) selezionare i prodotti che nell'anno 1994 sono stati forniti
-- esclusivamente da fornitori di Modena



-- d) selezionare, per ogni anno, la quantità totale dei prodotti forniti dai fornitori di Modena



-- e) selezionare, per ogni anno, il codice del fornitore che ha fornito in totale la maggiore quantità di prodotti


--
-- Create schema meeting
--

CREATE DATABASE IF NOT EXISTS meeting2;
USE meeting2;

--
-- Definition of table nazione
--

CREATE TABLE nazione (
  cod_n char(3) NOT NULL,
  presidente varchar(75) NOT NULL,
  continente varchar(16) NOT NULL,
  PRIMARY KEY (cod_n)
);


--
-- Definition of table conferenza
--

CREATE TABLE conferenza (
  cod_c char(5) NOT NULL,
  descrizione varchar(45) NOT NULL,
  cod_n_sede char(3) NOT NULL, -- rappresenta la nazione in cui si è tenuta la conferenza  cod_c
  PRIMARY KEY (cod_c),
  FOREIGN KEY (cod_n_sede) REFERENCES nazione(cod_n)
); 

--
-- Definition of table partecipa
--

CREATE TABLE partecipa (
  cod_c_p char(5) NOT NULL,
  cod_n_p char(3) NOT NULL,
  numerop int(3) NOT NULL,
  PRIMARY KEY (cod_c_p, cod_n_p),
  FOREIGN KEY (cod_c_p) REFERENCES conferenza(cod_c),
  FOREIGN KEY (cod_n_p) REFERENCES nazione(cod_n)	
);

-- numerop è il numero di rappresentanti della nazione cod_n_p partecipanti
-- alla conferenza cod_c_p

--
-- populating the DB
--
INSERT INTO Nazione VALUES
('ITA','Mattarella','Europa'),
('RUS','Putin','Russia'),
('GER','Merkel','Europa');

INSERT INTO Conferenza VALUES
('Chr3','Conferenza sulle ciliege','ITA'),
('H300','Conferenza Sui delfini ','RUS'),
('Ru3m','Conferenza sull importazione di alcolici','RUS'),
('C03r','Conferenza sulla salute','ITA'),
('C68r','Conferenza sulla Corruzione','GER');

INSERT INTO Partecipa VALUES
('C03r','RUS',75),
('C68r','RUS',75),
('Chr3','ITA',785),
('Chr3','GER',75),
('Ru3m','RUS',75);








--
-- QUERY (ALGEBRA RELAZIONALE a), b), c))
-- 

-- a) selezionare i dati relativi alle nazioni che hanno parecipato ad una
-- conferenza tenutasi in una nazione del continente Europa



-- b) selezionare i dati relativi alle nazioni che hanno partecipato ad una
-- conferenza tenutasi nella nazione stessa



-- c) selezionare i dati relativi alle nazioni che non hanno mai partecipato ad una
-- conferenza assieme ad una nazione del continente Europa



-- d) selezionare i dati relativi alla nazione in cui si è tyenuta la conferenza
-- con il maggior numero di rappresentanti complessivo



-- e) selezionare, per ogni nazione, la conferenza in cui vi ha partecipato con il
-- maggior numero di rappresentanti


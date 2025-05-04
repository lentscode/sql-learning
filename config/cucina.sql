--
-- Create schema cucina
--

CREATE DATABASE IF NOT EXISTS cucina;
USE cucina;

--
-- Definition of table chef
--
-- Rappresenta gli chef che creano le ricette
--
CREATE TABLE chef (
  cod_chef char(10) NOT NULL,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  specialita varchar(40),
  anni_esperienza int(2) NOT NULL,
  PRIMARY KEY (cod_chef)
);

--
-- Definition of table categoria
--
-- Rappresenta le categorie a cui possono appartenere le ricette (es. Antipasto, Primo, Dessert)
--
CREATE TABLE categoria (
  cod_categoria char(3) NOT NULL,
  nome_categoria varchar(50) NOT NULL,
  PRIMARY KEY (cod_categoria)
);

--
-- Definition of table ricetta
--
-- Rappresenta le ricette create dagli chef
--
CREATE TABLE ricetta (
  cod_ricetta char(5) NOT NULL,
  nome_ricetta varchar(100) NOT NULL,
  descrizione text,
  difficolta int(1) NOT NULL, -- Livello di difficoltà da 1 a 5
  tempo_preparazione int(3) NOT NULL, -- Tempo in minuti
  cod_chef_creatore char(10) NOT NULL,
  cod_categoria_r char(3) NOT NULL,
  PRIMARY KEY (cod_ricetta),
  FOREIGN KEY (cod_chef_creatore) REFERENCES chef (cod_chef),
  FOREIGN KEY (cod_categoria_r) REFERENCES categoria (cod_categoria)
);

--
-- Definition of table ingrediente
--
-- Rappresenta gli ingredienti utilizzabili nelle ricette
--
CREATE TABLE ingrediente (
  cod_ingrediente char(5) NOT NULL,
  nome_ingrediente varchar(80) NOT NULL,
  unita_misura varchar(20) NOT NULL, -- es. gr, ml, cucchiai, pz
  PRIMARY KEY (cod_ingrediente)
);

--
-- Definition of table composizione
--
-- Tabella di collegamento: indica quali ingredienti compongono una ricetta e in che quantità
--
CREATE TABLE composizione (
  cod_ricetta_c char(5) NOT NULL,
  cod_ingrediente_c char(5) NOT NULL,
  quantita numeric(7,2) NOT NULL, -- Quantità dell'ingrediente per la ricetta
  PRIMARY KEY (cod_ricetta_c, cod_ingrediente_c),
  FOREIGN KEY (cod_ricetta_c) REFERENCES ricetta (cod_ricetta),
  FOREIGN KEY (cod_ingrediente_c) REFERENCES ingrediente (cod_ingrediente)
);


--
-- Populating the DB
--

INSERT INTO chef (cod_chef, nome, cognome, specialita, anni_esperienza) VALUES
('CHEF001', 'Mario', 'Rossi', 'Pasta Fresca', 15),
('CHEF002', 'Anna', 'Verdi', 'Dessert', 22),
('CHEF003', 'Luca', 'Bianchi', 'Pesce', 8),
('CHEF004', 'Giulia', 'Neri', 'Vegetariano', 12),
('CHEF005', 'Marco', 'Gialli', 'Carne', 18);

INSERT INTO categoria (cod_categoria, nome_categoria) VALUES
('ANT', 'Antipasto'),
('PRI', 'Primo Piatto'),
('SEC', 'Secondo Piatto'),
('DES', 'Dessert'),
('CON', 'Contorno');

INSERT INTO ingrediente (cod_ingrediente, nome_ingrediente, unita_misura) VALUES
('I0001', 'Farina 00', 'gr'),
('I0002', 'Uova', 'pz'),
('I0003', 'Zucchero', 'gr'),
('I0004', 'Sale', 'pizzico'),
('I0005', 'Olio Extra Vergine Oliva', 'ml'),
('I0006', 'Pomodoro Pelato', 'gr'),
('I0007', 'Cipolla', 'pz'),
('I0008', 'Basilico', 'foglie'),
('I0009', 'Cioccolato Fondente', 'gr'),
('I0010', 'Panna Fresca', 'ml'),
('I0011', 'Patate', 'gr'),
('I0012', 'Rosmarino', 'rametto'),
('I0013', 'Orata', 'gr'),
('I0014', 'Limone', 'pz'),
('I0015', 'Prezzemolo', 'ciuffo'),
('I0016', 'Peperoncino', 'pz');

INSERT INTO ricetta (cod_ricetta, nome_ricetta, descrizione, difficolta, tempo_preparazione, cod_chef_creatore, cod_categoria_r) VALUES
('R0001', 'Tagliatelle al Ragù', 'Classico primo piatto emiliano', 3, 120, 'CHEF001', 'PRI'),
('R0002', 'Torta al Cioccolato', 'Soffice torta al cioccolato fondente', 2, 60, 'CHEF002', 'DES'),
('R0003', 'Orata al Limone', 'Secondo di pesce leggero e gustoso', 2, 45, 'CHEF003', 'SEC'),
('R0004', 'Patate al Forno', 'Contorno classico con rosmarino', 1, 50, 'CHEF004', 'CON'),
('R0005', 'Sugo al Pomodoro Semplice', 'Base per molti piatti italiani', 1, 30, 'CHEF001', 'PRI'),
('R0006', 'Mousse al Cioccolato', 'Dessert veloce e goloso', 3, 25, 'CHEF002', 'DES'),
('R0007', 'Pasta Aglio Olio e Peperoncino', 'Primo piatto veloce e piccante', 1, 15, 'CHEF005', 'PRI'),
('R0008', 'Insalata Caprese', 'Antipasto fresco con pomodoro e mozzarella (mozzarella non in lista ingredienti!)', 1, 10, 'CHEF004', 'ANT');


INSERT INTO composizione (cod_ricetta_c, cod_ingrediente_c, quantita) VALUES
('R0001', 'I0001', 300.00), -- Tagliatelle: Farina
('R0001', 'I0002', 3.00),   -- Tagliatelle: Uova
('R0001', 'I0006', 400.00), -- Ragù: Pomodoro
('R0001', 'I0007', 1.00),   -- Ragù: Cipolla
('R0001', 'I0005', 50.00),  -- Ragù: Olio
('R0002', 'I0001', 150.00), -- Torta: Farina
('R0002', 'I0002', 3.00),   -- Torta: Uova
('R0002', 'I0003', 200.00), -- Torta: Zucchero
('R0002', 'I0009', 150.00), -- Torta: Cioccolato
('R0003', 'I0013', 500.00), -- Orata: Orata
('R0003', 'I0014', 1.00),   -- Orata: Limone
('R0003', 'I0015', 1.00),   -- Orata: Prezzemolo
('R0003', 'I0005', 30.00),  -- Orata: Olio
('R0004', 'I0011', 800.00), -- Patate: Patate
('R0004', 'I0012', 2.00),   -- Patate: Rosmarino
('R0004', 'I0005', 40.00),  -- Patate: Olio
('R0004', 'I0004', 1.00),   -- Patate: Sale
('R0005', 'I0006', 500.00), -- Sugo: Pomodoro
('R0005', 'I0007', 0.50),   -- Sugo: Cipolla
('R0005', 'I0005', 40.00),  -- Sugo: Olio
('R0005', 'I0008', 5.00),   -- Sugo: Basilico
('R0006', 'I0009', 200.00), -- Mousse: Cioccolato
('R0006', 'I0010', 250.00), -- Mousse: Panna
('R0006', 'I0002', 2.00),   -- Mousse: Uova (solo tuorli magari, ma semplifichiamo)
('R0007', 'I0005', 60.00),  -- Aglio Olio: Olio
('R0007', 'I0016', 1.00),   -- Aglio Olio: Peperoncino
('R0007', 'I0015', 1.00);  -- Aglio Olio: Prezzemolo (aglio non in lista!)

-- a)  Selezionare il nome e la descrizione delle ricette che appartengono alla categoria 'Primo Piatto' e hanno una difficoltà maggiore di 1.

-- b)  Selezionare il nome e il cognome degli chef che non hanno creato nessuna ricetta di categoria 'Dessert'.

-- c)  Selezionare il codice e il nome delle ricette che utilizzano l'ingrediente 'Uova' (codice 'I0002') ma non utilizzano l'ingrediente 'Farina 00' (codice 'I0001').

-- d)  Selezionare il codice e il nome degli ingredienti che sono utilizzati in tutte le ricette create dallo chef 'Mario Rossi' (codice 'CHEF001').

-- e)  Per ogni categoria, calcolare il tempo di preparazione medio delle ricette appartenenti a quella categoria. Selezionare il nome della categoria e il tempo medio.

-- f)  Selezionare il nome della ricetta (o delle ricette, in caso di parità) che richiede il maggior numero di ingredienti diversi.

-- g)  Selezionare le coppie di codici di ricetta (cod_ricetta1, cod_ricetta2) tali che le due ricette appartengono alla stessa categoria e sono state create dallo stesso chef. Assicurarsi che una coppia non compaia due volte invertita (es. ('R0001', 'R0005') e ('R0005', 'R0001')) e che una ricetta non sia accoppiata con se stessa.
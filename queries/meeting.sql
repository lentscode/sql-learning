-- schema:
-- nazione(**cod_n**, presidente, continente)
-- conferenza(**cod_c**, descrizione, con_n_sede)
-- partecipa(~~cod_c_p, cod_n_p~~, numero_p)

-- QUERY A
-- selezionare i dati relativi alle nazioni che hanno partecipato ad una conferenza tenutasi in una nazione del continente Europa

SELECT n.cod_n, n.presidente, n.continente
FROM Nazione n, Conferenza c, Partecipa p
WHERE n.cod_n = p.cod_n_p AND c.cod_c = p.cod_c_p
  AND c.cod_n_sede = ANY (
    SELECT n1.cod_n 
    FROM Nazione n1
    WHERE n1.continente = 'Europa'
  );

-- (Prof)
SELECT n1.cod_n, n1.presidente, n1.continente
FROM Nazione n1, Conferenza c, Partecipa p, Nazione n2
WHERE n1.cod_n = p.cod_n_p AND c.cod_c = p.cod_c_p AND
  c.cod_n_sede = n2.cod_n AND n2.continente = 'Europa';

-- QUERY B
-- selezionare i dati relativi alle nazioni che hanno partecipato ad una conferenza tenutasi nella nazione stessa

SELECT n.cod_n, n.presidente, n.continente
FROM Nazione n, Conferenza c, Partecipa p
WHERE n.cod_n = p.cod_n_p AND c.cod_c = p.cod_c_p
  AND n.cod_n = c.cod_n_sede;

-- QUERY C
-- selezionare i dati relativi alle nazioni che non hanno mai partecipato ad una conferenza assieme ad una nazione del continente Europa

SELECT n.cod_n, n.presidente, n.continente
FROM Nazione n
WHERE n.cod_n NOT IN (
  SELECT n.cod_n
  FROM Partecipa p1, Nazione n, Partecipa p2
  WHERE p1.cod_c_p = p2.cod_c_p
   AND p2.cod_n_p = n.cod_n
   AND n.continente = 'Europa'
);

-- QUERY D
-- selezionare i dati relativi alla nazione in cui si è tenuta la conferenza con il maggior numero di rappresentanti complessivo

SELECT n.cod_n, n.presidente, n.continente
FROM Nazione n, Conferenza c
WHERE n.cod_n = c.cod_n_sede AND
  c.cod_c IN (
    SELECT p1.cod_c_p
    FROM Partecipa p1
    GROUP BY p1.cod_c_p
    HAVING SUM(p1.numerop) >= ALL (
      SELECT SUM(p2.numerop)
      FROM Partecipa p2
      GROUP BY p2.cod_c_p
    )
  );

-- QUERY E
-- selezionare, per ogni nazione, la conferenza in cui vi ha partecipato con il maggior numero di rappresentanti


SELECT p.cod_n_p, p.cod_c_p, p.numerop
FROM Partecipa p
WHERE p.numerop = (
  SELECT MAX(p2.numerop)
  FROM Partecipa p2
  WHERE p2.cod_n_p = p.cod_n_p
);
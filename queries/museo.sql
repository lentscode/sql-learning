-- QUERY A
-- selezionare le sale nelle quali è stato esposto, nell'anno 1997, un quadro di Picasso

SELECT DISTINCT m.*
FROM espone e, quadro q, mostra m
WHERE e.cod_q_e = q.cod_q
  AND e.cod_m_e = m.cod_m
  AND q.autore = 'Picasso'
  AND m.anno = 1997;

-- QUERY B
-- selezionare tutti i dati dei quadri di Picasso che non sono mai stati esposti nell'anno 1997

SELECT q.*
FROM quadro q
WHERE q.autore = 'Picasso'
  AND q.cod_q <> ALL (
  SELECT q.cod_q
  FROM quadro q, mostra m, espone e
  WHERE q.cod_q = e.cod_q_e
    AND m.cod_m = e.cod_m_e
    AND q.autore = 'Picasso'
    AND m.anno = 1997
);

-- QUERY C
-- selezionare tutti i dati dei quadri che non sono mai stati esposti insieme con un quadro di Picasso, cioè nella stessa mostra in cui compariva anche un quadro di Picasso

SELECT q.*
FROM quadro q
WHERE q.autore <> 'Picasso'
  AND q.cod_q <> ALL (
    SELECT q1.cod_q
    FROM quadro q1, quadro q2, espone e1, espone e2
    WHERE q1.cod_q = e1.cod_q_e
      AND q2.cod_q = e2.cod_q_e
      AND e1.cod_m_e = e2.cod_m_e
      AND q1.cod_q > q2.cod_q
      AND q2.autore = 'Picasso'
);

-- QUERY D
-- selezionare tutti i dati delle mostre in cui sono stati esposti quadri di almeno 5 autori distinti

SELECT m.*
FROM mostra m
WHERE m.cod_m = ANY (
  SELECT m.cod_m
  FROM mostra m, quadro q, espone e
  WHERE q.cod_q = e.cod_q_e
    AND m.cod_m = e.cod_m_e
  GROUP BY m.cod_m
  HAVING COUNT(DISTINCT q.autore) >= 5
);

-- QUERY E
-- selezionare, per ogni mostra, l'autore di cui si esponeva il maggior numero di quadri

SELECT m.cod_m, q.autore
FROM mostra m, quadro q, espone e
WHERE m.cod_m = e.cod_m_e
  AND q.cod_q = e.cod_q_e
GROUP BY m.cod_m, q.autore
HAVING COUNT(q.autore) >= ALL (
  SELECT COUNT(q1.autore)
  FROM mostra m1, quadro q1, espone e1 
  WHERE m1.cod_m = m.cod_m
    AND m1.cod_m = e1.cod_m_e
    AND q1.cod_q = e1.cod_q_e
    GROUP BY m1.cod_m, q1.autore
);
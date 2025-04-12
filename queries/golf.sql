-- QUERY A
-- selezionare i dati dei giocatori di golf che hanno partecipato ad almeno una gara disputata a livello 'nazionale'

SELECT DISTINCT gi.*
FROM giocatore gi, gara ga, partecipa p
WHERE gi.cf = p.cf_p
  AND ga.cod_g = p.cod_g_p
  AND ga.livello = 'Nazionale';

-- QUERY B
-- selezionare le nazioni in cui tutti i giocatori hanno ottenuto un punteggio minore o uguale a 0 nelle gare disputate

SELECT DISTINCT gi.nazione
FROM giocatore gi
WHERE NOT EXISTS (
  SELECT 1
  FROM partecipa p
  WHERE p.cf_p = gi.cf
    AND p.punteggio > 0
);

-- QUERY C
-- selezionare i dati dei giocatori di golf che hanno partecipato a tutte le gare disputate a livello 'nazionale'

SELECT gi.*
FROM giocatore gi
WHERE NOT EXISTS (
  SELECT 1
  FROM gara ga
  WHERE ga.livello = 'Nazionale'
  AND NOT EXISTS (
    SELECT 1
    FROM partecipa p
    WHERE p.cod_g_p = ga.cod_g
      AND p.cf_p = gi.cf
  )
);

-- QUERY D
-- selezionare i dati dei giocatori di golf che hanno vinto almeno una gara disputata a livello 'internazionale'

SELECT gi.*
FROM giocatore gi
WHERE gi.cf = ANY (
  SELECT p.cf_p
  FROM partecipa p, gara g
  WHERE p.cod_g_p = g.cod_g
    AND g.livello = 'Internazionale'
    AND p.punteggio <= ALL (
    SELECT p1.punteggio
    FROM partecipa p1
    WHERE p1.cod_g_p = p.cod_g_p
  )
);

-- QUERY E
-- selezionare, per ogni nazione che nelle gare di livello 'internazionale' ha schierato più di 5 giocatori distinti, il punteggio medio ottenuto dai giocatori in tali gare; si ordini il risultato in modo decrescente rispetto al punteggio medio

SELECT gi.nazione, AVG(p.punteggio)
FROM giocatore gi, gara ga, partecipa p
WHERE gi.cf = p.cf_p
  AND ga.cod_g = p.cod_g_p
  AND ga.livello = 'Internazionale'
GROUP BY gi.nazione
HAVING COUNT(*) > 5;
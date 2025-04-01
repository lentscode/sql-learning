-- SCHEMA
-- ciclista(**nome_ciclista**, nazionalita, eta)
-- gara(**nome_corsa, anno**, partenza, arrivo)
-- partecipa(~~nome_corsa_p, anno_p, nome_ciclista~~, posizione)

-- QUERY A
-- selezionare i ciclisti che si sono classificati in prima posizione in una gara ciclistica partita da Milano

SELECT c.*, g.anno, g.arrivo
FROM ciclista c, gara g, partecipa p
WHERE c.nome_ciclista = p.nome_ciclista_p 
  AND g.anno = p.anno_p
  AND g.nome_corsa = p.nome_corsa_p
  AND g.partenza = 'Milano'
  AND p.posizione = '1';

-- QUERY B
-- selezionare il nome dei ciclisti che non si sono mai ritirati al Giro (corsa con nome Giro)

SELECT c1.nome_ciclista
FROM ciclista c1
WHERE c1.nome_ciclista NOT IN (
  SELECT p.nome_ciclista_p
  FROM partecipa p
  WHERE p.nome_corsa_p LIKE 'Giro%'
    AND p.posizione = 'R'
);

-- QUERY C
-- selezionare le corse per le quali in ogni edizione c'è stato almeno un ritirato

SELECT g1.*
FROM gara g1
WHERE NOT EXISTS (
  SELECT 1
  FROM gara g2
  WHERE g2.nome_corsa = g1.nome_corsa
    AND NOT EXISTS (
      SELECT 1
      FROM partecipa p
      WHERE p.nome_corsa_p = g2.nome_corsa
        AND p.anno_p = g2.anno
        AND p.posizione = 'R'
    )
);

-- QUERY D
-- selezionare, per ogni corsa ciclistica, l'anno in cui c'è stato il maggior numero di ciclisti ritirati

SELECT p1.nome_corsa_p, p1.anno_p
FROM partecipa p1
WHERE p1.posizione = 'R'
GROUP BY p1.nome_corsa_p, p1.anno_p
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM partecipa p2
  WHERE p2.nome_corsa_p = p1.nome_corsa_p
  AND p2.posizione = 'R'
  GROUP BY p2.anno_p
);
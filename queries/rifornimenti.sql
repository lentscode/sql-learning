-- QUERY A
-- selezionare i prodotti che nell'anno 1995 sono stati forniti da almeno un fornitore di Modena

SELECT DISTINCT p.*
FROM prodotto p, fornisce fs, fornitore fo
WHERE p.cod_p = fs.cod_p_f AND fo.cf = fs.cf_f
  AND fs.anno = '1995' AND fo.citta = 'Modena';

-- QUERY B
-- selezionare i prodottinon forniti da nessun fornitore di Modena

SELECT p.*
FROM prodotto p
WHERE p.cod_p NOT IN (
  SELECT p.cod_p
  FROM prodotto p, fornisce fs, fornitore fo
  WHERE p.cod_p = fs.cod_p_f AND fo.cf = fs.cf_f
    AND fo.citta = 'Modena'
);

-- QUERY C
-- selezionare i prodotti che nell'anno 1994 sono stati forniti esclusivamente da fornitori di Modena

SELECT DISTINCT p.*
FROM prodotto p, fornisce fs, fornitore fo
WHERE p.cod_p = fs.cod_p_f AND fo.cf = fs.cf_f
  AND fs.anno = '1994' AND fo.citta = 'Modena'
  AND p.cod_p NOT IN (
    SELECT p.cod_p
    FROM prodotto p, fornisce fs, fornitore fo
    WHERE p.cod_p = fs.cod_p_f AND fo.cf = fs.cf_f
      AND fs.anno = '1994' AND fo.citta <> 'Modena' 
  );

-- QUERY D
-- selezionare, per ogni anno, la quantità totale dei prodotti forniti dai fornitori di Modena

SELECT fs.anno, SUM(fs.qty)
FROM fornisce fs, fornitore fo
WHERE fo.cf = fs.cf_f AND fo.citta = 'Modena'
GROUP BY fs.anno;
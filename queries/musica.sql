-- QUERY A
-- selezionare tutti i dati dei clienti che dopo il 1/1/1997 non hanno acquistato nessun cd prodotto dalla casa discografica 'DiscoJolli'

SELECT cl.*
FROM cliente cl
WHERE cl.ntess <> ALL (
  SELECT cl.ntess
  FROM cliente cl, acquisto a, cd
    WHERE cl.ntess = a.ntess_a
    AND cd.cod_cd = a.cod_cd_a
    AND a.data_acquisto > '1997-1-1'
    AND cd.casa_disco = 'DiscoJolli'
);

-- QUERY B
-- selezionare il numero tessera dei clienti che hanno acquistato tuttii cd dell'autore 'Francesco Guccini'

SELECT cl.ntess
FROM cliente cl
WHERE NOT EXISTS (
  SELECT 1
  FROM cd
  WHERE cd.autore = 'Francesco Guccini'
    AND NOT EXISTS (
    SELECT 1
    FROM acquisto a
    WHERE cl.ntess = a.ntess_a
      AND cd.cod_cd = a.cod_cd_a
  )
);

-- QUERY C
-- selezionare, per ogni cd, il numero totale delle copie vendute

SELECT cd.cod_cd, SUM(a.qty)
FROM cd, acquisto a
WHERE cd.cod_cd = a.cod_cd_a
GROUP BY cd.cod_cd;

-- QUERY D
-- selezionare, per ogni casa discografica, il numero tessera del cliente che ha  acquistato il maggior numero di copie di cd di quella casa

SELECT cd.casa_disco, a.ntess_a, SUM(a.qty)
FROM cd, acquisto a
WHERE cd.cod_cd = a.cod_cd_a
GROUP BY cd.casa_disco, a.ntess_a
HAVING SUM(a.qty) >= ALL (
  SELECT SUM(a1.qty)
  FROM cd cd1, acquisto a1
  WHERE cd1.cod_cd = a1.cod_cd_a
    AND cd1.casa_disco = cd.casa_disco
  GROUP BY cd1.casa_disco, a1.ntess_a
);

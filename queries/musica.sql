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
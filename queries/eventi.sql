-- QUERY A
-- selezionare il codice e il nome delle manifestazioni che non hanno interessato luoghi della città di Modena

SELECT m.cod_m, m.nome_m
FROM manifestazione m
WHERE m.cod_m <> ALL (
  SELECT m.cod_m
  FROM manifestazione m, luogo l, spettacolo s
  WHERE m.cod_m = s.cod_m_s
    AND l.nome_l = s.nome_l_s
    AND l.citta = 'Modena'
);

-- QUERY B
-- selezionare i nomi dei luoghi che hanno ospitato tutte le manifestazioni (hanno ospitato almeno uno spettacolo di ciascuna manifestazione)

SELECT l.nome_l
FROM luogo l
WHERE NOT EXISTS (
  SELECT 1
  FROM manifestazione m
  WHERE NOT EXISTS (
    SELECT 1
    FROM spettacolo s
    WHERE s.cod_m_s = m.cod_m
    AND s.nome_l_s = l.nome_l
  )
);

-- QUERY C
-- selezionare il nome dei luoghi che, in una certa data, ospitano più di tre spettacoli dopo le ore 15

SELECT s.giorno, s.nome_l_s
FROM spettacolo s
WHERE s.ora_inizio > 15
GROUP BY s.giorno, s.nome_l_s
HAVING COUNT(*) > 3;

-- QUERY D
-- selezionare, per ogni luogo, il numero totale delle manifestazioni e il numero totale degli spettacoli ospitati

SELECT s.nome_l_s,
  COUNT(DISTINCT s.cod_m_s) AS numero_manifestazioni, 
  COUNT(*) AS numero_spettacoli
FROM spettacolo s
GROUP BY s.nome_l_s;
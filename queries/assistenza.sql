-- QUERY A
-- selezionare i personal di tipo 'Mac' che non sono stati riparati tra il 1/7/97 e il 1/11/97

SELECT p.cod_pc, p.nome, p.nome_proprietario
FROM pc p
WHERE p.tipo = 'Mac'
  AND p.cod_pc NOT IN (
    SELECT p.cod_pc
    FROM pc p, riparazione r
    WHERE p.cod_pc = r.cod_pc_r
      AND r.data_riparazione > '1997-07-01'
      AND r.data_riparazione < '1997-11-01'
  );

-- QUERY B
-- selezionare i tecnici che hanno riparato tutti i personal di tipo 'Mac'

SELECT t.*
FROM tecnico t
WHERE NOT EXISTS (
  SELECT 1
  FROM pc p
  WHERE p.tipo = 'Mac'
    AND NOT EXISTS (
      SELECT 1
      FROM riparazione r
      WHERE r.cod_pc_r = p.cod_pc
        AND r.cf_r = t.cf
    )
);

-- QUERY C
-- selezionare le coppie (PC1, PC2) tali che i personal con codice PC1 e PC2 sono stati riparati nella stessa data dallo stesso tecnico

SELECT p1.cod_pc, p2.cod_pc
FROM pc p1, pc p2, riparazione r1, riparazione r2
WHERE p1.cod_pc = r1.cod_pc_r
  AND p2.cod_pc = r2.cod_pc_r
  AND r1.cf_r = r2.cf_r
  AND p1.cod_pc > p2.cod_pc
  AND r1.data_riparazione = r2.data_riparazione;

-- QUERY D
-- selezionare i dati dei personal che hanno richiesto almeno 10 ore di riparazione

SELECT DISTINCT p.*
FROM pc p, riparazione r
WHERE p.cod_pc = r.cod_pc_r
  AND r.ore >= 10;

-- QUERY E
-- selezionare, per ogni data, il tecnico che ha riparato ilmaggior numero di personal

-- QUERY F
-- selezionare il personal che ha totalizzato il maggior costo di riparazione, considerando le ore di riparazione e il relativo costo orario

SELECT p.cod_pc, SUM(r.ore * t.costo_orario) AS costo_totale
FROM pc p, tecnico t, riparazione r
WHERE p.cod_pc = r.cod_pc_r
  AND t.cf = r.cf_r
GROUP BY p.cod_pc
HAVING costo_totale >= ALL (
  SELECT SUM(r.ore * t.costo_orario)
  FROM pc p, tecnico t, riparazione r
  WHERE p.cod_pc = r.cod_pc_r
    AND t.cf = r.cf_r
  GROUP BY p.cod_pc
)
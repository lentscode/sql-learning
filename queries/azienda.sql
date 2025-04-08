-- QUERY A
-- selezionare i dati dei dipendenti di Modena che non hanno lavorato in alcun progetto dell'anno 1995

SELECT d.*
FROM dipendente d
WHERE d.citta = 'Modena'
  AND d.cf NOT IN (
  SELECT d.cf
  FROM dipendente d, lavora l, progetto p
  WHERE d.cf = l.cf_l AND p.cod_p = l.cod_p_l
    AND p.anno = 1995
);
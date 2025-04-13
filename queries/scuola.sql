-- QUERY A
-- selezionare il codice fiscale, il nome ed il cognome degli studenti che non sono mai stati interrogati su un argomento con descrizione 'Fisica'

SELECT s.*
FROM studente s
WHERE s.cf_stud <> ALL (
  SELECT s.cf_stud
  FROM studente s, interrogazione i, argomento a
  WHERE s.cf_stud = i.cf_stud_i
    AND a.cod_arg = i.cod_arg_i
    AND a.descrizione = 'Fisica'
);

-- QUERY B
-- selezionare il codice fiscale del docente che ha svolto lezioni su tutti gli argomenti con descrizione 'Fisica'

SELECT d.cf_doc
FROM docente d
WHERE NOT EXISTS (
  SELECT 1
  FROM argomento a
  WHERE a.descrizione = 'Fisica'
    AND NOT EXISTS (
      SELECT 1
      FROM lezione l
      WHERE l.cf_doc_l = d.cf_doc
        AND l.cod_arg_l = a.cod_arg
    )
);

-- QUERY C
-- selezionare il codice fiscale del docente che ha sempre interrogato, cioè che durante ogni sua lezione ha fatto almeno una interrogazione

SELECT d.cf_doc
FROM docente d
WHERE NOT EXISTS (
  SELECT 1
  FROM lezione l
  WHERE l.cf_doc_l = d.cf_doc
    AND NOT EXISTS (
    SELECT 1
    FROM interrogazione i
    WHERE i.cod_arg_i = l.cod_arg_l
      AND i.data_lezione_i = l.data_lezione
  )
);

-- QUERY D
-- selezionare, per ogni argomento, la media dei voti riportati dagli studenti interrogati sull'argomento, considerando solo gli studenti che sono stati interrogati almeno tre volte sull'argomento in questione

SELECT i.cod_arg_i, i.cf_stud_i, AVG(i.voto)
FROM interrogazione i
GROUP BY i.cod_arg_i, i.cf_stud_i
HAVING COUNT(*) >= 3;

-- QUERY E
-- selezionare, per ogni studente, il codice fiscale del docente con il quale ha effettuato il maggior numero di interrogazioni

SELECT i.cf_stud_i, l.cf_doc_l, COUNT(*)
FROM interrogazione i, lezione l
WHERE i.cod_arg_i = l.cod_arg_l
  AND i.data_lezione_i = l.data_lezione
GROUP BY i.cf_stud_i, l.cf_doc_l
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM interrogazione i1, lezione l
  WHERE i1.cod_arg_i = l.cod_arg_l
    AND i1.data_lezione_i = l.data_lezione
    AND i1.cf_stud_i = i.cf_stud_i
  GROUP BY i.cf_stud_i, l.cf_doc_l
);
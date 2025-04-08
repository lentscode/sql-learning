-- a) selezionare il codice ed il nome degli operatori per i quali non esiste alcun reclamo,
-- cioè per i quali nessun esemplare di nessun lotto da essi confezionato ha ricevuto un reclamo

SELECT o.cod_op, o.nome
FROM operatore o
WHERE NOT EXISTS (
	SELECT *
	FROM reclamo r
	WHERE r.cod_op_r = o.cod_op
);

-- b) selezionare il codice degli operatori per i quali ogni lotto da essi confezionato contiene almeno
-- un esemplare al quale si riferisce un reclamo

SELECT o.cod_op
FROM operatore o
WHERE NOT EXISTS (
  SELECT *
  FROM lotto l
  WHERE l.cod_op_l = o.cod_op
    AND NOT EXISTS (
      SELECT *
      FROM reclamo r
      WHERE r.cod_a_r = l.cod_a_l
        AND r.cod_op_r = l.cod_op_l
    )
);


-- c) selezionare il nome del cliente che ha fatto reclami per tutti gli operatori

SELECT r.nome_cl
FROM reclamo r
WHERE NOT EXISTS (
  SELECT 1
  FROM operatore o
  WHERE NOT EXISTS (
    SELECT 1
      FROM reclamo r1
      WHERE r1.cod_op_r = o.cod_op
      AND r.cod_op_r = o.cod_op
  )
);

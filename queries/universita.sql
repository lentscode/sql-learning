-- a)  Selezionare la matricola, il nome e il cognome degli studenti nati dopo il '2003-01-01'.

select s.matricola, s.nome, s.cognome
from studente s
where s.data_nascita > '2003-01-01';

-- b)  Selezionare il nome dei corsi (tabella corso) offerti dal dipartimento di 'Informatica' (codice 'INF') che valgono più di 6 crediti.

select c.cod_corso, c.nome_corso
from corso c, dipartimento d
where c.cod_dip_c = d.cod_dip
  and d.nome_dip = 'Informatica'
  and c.crediti > 6;

-- c)  Selezionare il nome e il cognome dei docenti che appartengono al dipartimento di 'Matematica' e il nome del corso di cui sono titolari.

select do.cod_doc, do.nome, do.cognome, c.nome_corso
from docente do, dipartimento di, corso c
where do.cod_dip_d = di.cod_dip
  and c.cod_doc_titolare = do.cod_doc
  and di.nome_dip = 'Matematica';

-- d)  Selezionare la matricola degli studenti che sono iscritti al corso 'INF001' ma non al corso 'INF002'.

select s.matricola
from studente s
where exists (
  select 1
  from iscrizione i
  where i.cod_corso_i = 'INF001'
    and i.matricola_s = s.matricola
) and not exists (
  select 1
  from iscrizione i
  where i.cod_corso_i = 'INF002'
    and i.matricola_s = s.matricola
);

-- e)  Selezionare la matricola e l'email degli studenti che hanno ottenuto un voto pari a 30 in almeno un esame.

select distinct s.matricola, s.email
from studente s, iscrizione i
where s.matricola = i.matricola_s
  and i.voto = 30;

-- f)  Per ogni dipartimento, contare quanti docenti vi appartengono. Selezionare il nome del dipartimento e il numero di docenti.

select di.nome_dip, count(*)
from dipartimento di, docente do
where di.cod_dip = do.cod_dip_d
group by di.nome_dip;

-- g)  Selezionare il codice del corso (o dei corsi) che ha il maggior numero di studenti iscritti (indipendentemente dal voto).

select c.cod_corso, count(*)
from corso c, iscrizione i
where c.cod_corso = i.cod_corso_i
group by c.cod_corso
having count(*) >= all (
  select count(*)
  from corso c, iscrizione i
  where c.cod_corso = i.cod_corso_i
  group by c.cod_corso
);

-- h)  Selezionare la matricola, il nome e il cognome degli studenti che si sono iscritti a tutti i corsi offerti dal dipartimento di 'Informatica' ('INF').

select s.matricola, s.nome, s.cognome
from studente s
where not exists (
  select 1
  from corso c, dipartimento d
  where c.cod_dip_c = d.cod_dip
    and d.nome_dip = 'Informatica'
    and not exists (
      select 1
      from iscrizione i
      where i.matricola_s = s.matricola
        and i.cod_corso_i = c.cod_corso
    )
);

-- i)  Calcolare la media dei voti (escludendo i NULL) per ogni studente. Selezionare matricola, nome, cognome e media voti, ordinando per media decrescente. (Attenzione: uno studente potrebbe non avere voti registrati).

select s.matricola, s.nome, s.cognome, avg(i.voto) as media_voti, count(*) as numero_voti
from studente s, iscrizione i
where s.matricola = i.matricola_s
  and i.voto is not null
group by s.matricola, s.nome, s.cognome
order by media_voti desc;

-- j)  Selezionare il nome e il cognome dei docenti che non sono titolari di nessun corso con meno di 9 crediti.

select d.cod_doc, d.nome, d.cognome
from docente d
where d.cod_doc <> all (
  select d.cod_doc
  from docente d, corso c
  where d.cod_doc = c.cod_doc_titolare
  and c.crediti < 9
);
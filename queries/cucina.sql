-- a)  Selezionare il nome e la descrizione delle ricette che appartengono alla categoria 'Primo Piatto' e hanno una difficoltà maggiore di 1.

select r.cod_ricetta, r.nome_ricetta, r.descrizione
from ricetta r, categoria c
where r.cod_categoria_r = c.cod_categoria
  and difficolta > 1 
  and c.nome_categoria = 'Primo Piatto';

-- b)  Selezionare il nome e il cognome degli chef che non hanno creato nessuna ricetta di categoria 'Dessert'.

select ch.cod_chef, ch.nome, ch.cognome
from chef ch
where ch.cod_chef <> all (
  select ch.cod_chef
  from chef ch, ricetta r, categoria ca
  where ch.cod_chef = r.cod_chef_creatore
    and r.cod_categoria_r = ca.cod_categoria
    and ca.nome_categoria = 'Dessert'
);

-- c)  Selezionare il codice e il nome delle ricette che utilizzano l'ingrediente 'Uova' (codice 'I0002') ma non utilizzano l'ingrediente 'Farina 00' (codice 'I0001').

select r.cod_ricetta, r.nome_ricetta
from ricetta r
where exists (
  select 1
  from composizione c
  where c.cod_ricetta_c = r.cod_ricetta
    and c.cod_ingrediente_c = 'I0002'
) and not exists (
    select 1
    from composizione c
    where c.cod_ricetta_c = r.cod_ricetta
      and c.cod_ingrediente_c = 'I0001'
  );

-- d)  Selezionare il codice e il nome degli ingredienti che sono utilizzati in tutte le ricette create dallo chef 'Mario Rossi' (codice 'CHEF001').

select i.cod_ingrediente, i.nome_ingrediente
from ingrediente i
where not exists (
  select 1
  from ricetta r
  where r.cod_chef_creatore = 'CHEF001'
    and not exists (
      select 1
      from composizione c
      where c.cod_ricetta_c = r.cod_ricetta
        and c.cod_ingrediente_c = i.cod_ingrediente
    )
);

-- e)  Per ogni categoria, calcolare il tempo di preparazione medio delle ricette appartenenti a quella categoria. Selezionare il nome della categoria e il tempo medio.

select c.nome_categoria, AVG(r.tempo_preparazione)
from categoria c, ricetta r
where c.cod_categoria = r.cod_categoria_r
group by c.nome_categoria;

-- f)  Selezionare il nome della ricetta (o delle ricette, in caso di parità) che richiede il maggior numero di ingredienti diversi.

select r.cod_ricetta, r.nome_ricetta, count(*)
from ricetta r, composizione c
where r.cod_ricetta = c.cod_ricetta_c
group by r.cod_ricetta, r.nome_ricetta
having count(*) >= all (
  select count(*)
  from ricetta r, composizione c
  where r.cod_ricetta = c.cod_ricetta_c
  group by r.cod_ricetta, r.nome_ricetta
);

-- g)  Selezionare le coppie di codici di ricetta (cod_ricetta1, cod_ricetta2) tali che le due ricette appartengono alla stessa categoria e sono state create dallo stesso chef. Assicurarsi che una coppia non compaia due volte invertita (es. ('R0001', 'R0005') e ('R0005', 'R0001')) e che una ricetta non sia accoppiata con se stessa.

select r1.cod_ricetta as cod_ricetta1,
  r2.cod_ricetta as cod_ricetta2
from ricetta r1, ricetta r2, chef ch,
  categoria ca
where r1.cod_chef_creatore = ch.cod_chef
  and r2.cod_chef_creatore = ch.cod_chef
  and r1.cod_categoria_r = ca.cod_categoria
  and r2.cod_categoria_r = ca.cod_categoria
  and r1.cod_ricetta < r2.cod_ricetta;
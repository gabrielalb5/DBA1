-- 1. Quantas linguagens diferentes existem?
select count(distinct language) 'Qtd. Línguas existentes'
from countrylanguage;

-- 2. Quantas linguagens oficiais existem no mundo?
select count(distinct language) 'Qtd. Línguas oficiais'
from countrylanguage
where isofficial = 'T';

-- 3. Quantos países falam a linguagem Portuguesa?
select count(language) 'Qtd. Países falantes de português'
from countrylanguage
where language = 'portuguese';

-- 4. Quais os nomes dos países que falam a linguagem Portuguesa?
select c.Name 'Países falantes de português'
from countrylanguage cl, country c
where cl.countrycode = c.code
and language = 'portuguese';

-- 5. Qual a linguagem (em número de países) mais falada no mundo?
select count(c.name) 'Qtd. países', cl.language 'Língua'
from countrylanguage cl, country c
where cl.CountryCode = c.code
group by cl.language
order by count(c.name) desc
limit 1;

-- 6. Qual a linguagem (em número de habitantes) mais falada no mundo?
select sum(c.population*cl.percentage/100) 'Qtd. Habitantes falantes', cl.language 'Língua'
from country c, countrylanguage cl
where c.code = cl.countrycode
group by cl.language
order by sum(c.population*cl.percentage/100) desc
limit 1;

-- 7. Em qual país é falado o maior número de linguagens diferentes?
select count(cl.language) 'Qtd. línguas', c.name 'País'
from countrylanguage cl, country c
where cl.CountryCode = c.Code
group by c.code
order by count(cl.language)  desc;

-- 8. Quantas linguagens não oficiais existem no mundo?
select count(distinct cl.language) 'Qtd. Línguas não oficiais'
from countrylanguage cl
where cl.isofficial = 'F';


-- 9. Quais as 5 cidades mais populosas do mundo?
select name 'Cidade', population 'População'
from city
order by population desc
limit 5;

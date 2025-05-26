use world;

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

-- 10. Em quais países estão as 5 cidades mais populosas do mundo?
select ct.name 'Cidade', ct.population 'População', c.name 'País'
from city ct, country c
where ct.countrycode = c.code
order by ct.population desc
limit 5;

-- 11. Qual a cidade do mundo tem a menor população?
select ct.name 'Cidade', ct.population 'População'
from city ct
order by ct.population
limit 1;

-- 12. Em qual país está a cidade que tem a menor população do mundo?
select c.name 'País'
from country c, city ct
where ct.countrycode = c.code
order by ct.population
limit 1;

-- 13. Qual a cidade da Europa tem a menor população?
select ct.name 'Cidade', ct.population 'População', c.name 'País'
from city ct, country c
where ct.countrycode = c.code
and c.continent = 'Europe'
order by ct.population
limit 1;

-- 14. Exiba os continentes e suas populações em ordem decrescente.
select continent, sum(population) 'População'
from country
group by continent
order by sum(population);

-- 15. Qual a expectativa de vida média no mundo?
select avg(lifeexpectancy)
from country;

-- 16. Quais países têm expectativa de vida maior do que a média mundial?
select name 'País', lifeexpectancy 'Expectativa de vida'
from country
where lifeexpectancy > (select avg(lifeexpectancy) from country)
order by lifeexpectancy desc;

-- 17. Qual o país que tem a menor expectativa de vida no mundo?
select name 'País', lifeexpectancy 'Expectativa de vida'
from country
where lifeexpectancy is not null
order by lifeexpectancy asc
limit 1;

-- 18. Quais os 5 maiores países do mundo em relação ao seu tamanho de área?
select name 'País', surfacearea 'Tamanho do território'
from country
order by surfacearea desc
limit 5;

-- 19. Quais os 3 maiores países da Europa em relação ao seu tamanho de área?
select name 'País', surfacearea 'Tamanho do território'
from country
where continent = 'Europe'
order by surfacearea desc
limit 3;

-- 20. Exiba os nomes dos países (e de suas capitais) da América do Sul.
select c.name 'País', ct.name 'Capital'
from country c, city ct
where c.capital = ct.id
and continent = 'South America'
order by c.name;

-- 21. Qual o nome do país que tem como capital Toskent?
select c.name 'País', ct.name 'Capital'
from country c, city ct
where c.capital = ct.id
and ct.name = 'Toskent';

-- 22. Existe algum país no mundo que não tenha capital?
select name 'País'
from country
where capital is null;
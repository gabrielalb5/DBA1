--  Gabriel Albino (AQ3029085) - 3 Semestre TSI 2025 | SQL: Select e junção (lista 1)

-- 1. Consultar pelo nome e salário dos funcionários que trabalham no departamento com nome = ‘Pesquisa’, ordenando os resultados do menor para o maior salário.
select f.nome 'Funcionário', f.salario 'Salário'
from funcionario f, departamento d
where d.dnumero = f.dnumero
and d.dnome = 'Pesquisa'
order by f.salario asc;

-- 2. Recuperar nome dos departamentos localizados em São Paulo.
select d.dnome 'Departamento', l.nomelocal 'Local'
from departamento d, deptolocal l
where d.dnumero = l.dnumero
and l.nomelocal = 'São Paulo';

-- 3. Consultar nome dos projetos controlados pelos departamentos de pesquisa ou de administração.
select p.projnome 'Projeto', d.dnome 'Departamento'
from departamento d, projeto p
where  d.dnumero = p.dnumero
and (dnome = 'Pesquisa' or dnome = 'Administração');

-- 4. Recuperar os nomes de departamentos que controlam projetos localizados em São Paulo.
select d.dnome 'Departamentos', p.projlocal 'Local do projeto'
from departamento d, projeto p
where d.dnumero = p.dnumero
and p.projlocal = 'São paulo';

-- 5. Recuperar CPF e carga horária dos funcionários atribuídos para o projeto com nome = ‘Novos benefícios’, ordenando os resultados da maior para a menor carga horária.
select a.cpf 'CPF', a.horas 'Carga horária', p.projnome 'Projeto'
from projeto p, atribuicao a
where p.projnumero = a.projnumero
and p.projnome = 'novos benefícios'
order by a.horas desc;

-- 6. Recuperar CPF e carga horária dos funcionários atribuídos para os projetos com nome contendo o termo ‘Produto’, ordenando os resultados da maior para a menor carga horária.
select a.cpf 'CPF', a.horas 'Carga horária', p.projnome 'Projeto'
from projeto p, atribuicao a
where p.projnumero = a.projnumero
and p.projnome like '%produto%'
order by a.horas desc;

-- 7. Calcule o total de horas atribuídas em projetos para o funcionário com nome = 'Fernando Wong'.
select f.nome as 'Funcionário', sum(a.horas) 'Total de horas em projetos'
from funcionario f, atribuicao a
where f.cpf = a.cpf
and nome = 'Fernando Wong';

-- 8. Calcule a quantidade de funcionários atribuídos para o projeto com nome = ‘Produto Y’.
select count(distinct a.CPF) 'Quantidade de funcionarios'
from atribuicao a, projeto p
where a.projnumero = p.projnumero
and p.projnome = 'Produto Y';

-- 9. Recuperar a quantidade de funcionários atribuídos por nome de projeto.
select count(a.cpf) 'Quantidade de funcionarios', p.projnome
from atribuicao a, projeto p 
where a.projnumero = p.projnumero
group by p.projnome;

-- 10. Recuperar o total de horas atribuídas em projetos por nome de funcionário.
select f.nome 'Funcionário', sum(a.horas) 'Total de horas em projetos'
from funcionario f, atribuicao a
where a.cpf = f.cpf
group by f.cpf
order by sum(a.horas);

-- 11. Recuperar nome, salário e carga horária dos funcionários atribuídos para os projetos com nome contendo o termo ‘Produto’, ordenando os resultados da maior para a menor carga horária.
select f.nome 'Funcionário', f.salario 'Salário', a.horas 'Carga horária', p.projnome 'Projeto'
from funcionario f, atribuicao a, projeto p
where a.cpf = f.cpf
and a.projnumero = p.projnumero
and p.projnome like '%produto%'
order by a.horas desc;

-- 12. Consultar nome dos projetos controlados por departamentos localizados em São Paulo.
select p.projnome 'Projeto', p.projlocal 'Local do projeto', l.nomelocal 'Local do departamento'
from projeto p, deptolocal l
where p.dnumero = l.dnumero
and  l.nomelocal = 'São Paulo';

-- 13. Recuperar a média de salário dos funcionários que trabalham em departamentos localizados em São Paulo.
select round(avg(salario),2) as 'Média salarial'
from funcionario f, deptolocal l
where f.dnumero = l.dnumero
and l.nomelocal = 'São Paulo';

-- 14. Consultar o nome dos projetos em que trabalham funcionários do sexo feminino.
select distinct p.projnome 'Projetos com mulheres'
from projeto p, funcionario f, atribuicao a
where p.projnumero = a.projnumero
and f.cpf = a.cpf
and f.sexo = 'F';

-- 15. Consultar o nome dos projetos controlados por departamentos gerenciados por funcionários do sexo masculino.
select p.projnome 'Projetos controlados por departamentos gerenciados por homens'
from projeto p, funcionario f, departamento d
where d.cpfgerente = f.cpf
and d.dnumero = p.dnumero
and f.sexo

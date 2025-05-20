create database pizzaria;
use pizzaria ;
drop table if exists Item_pedido;
drop table if exists Ingredientes_pizza;
drop table if exists Pedido;
drop table if exists Cliente;
drop table if exists Pizza;
drop table if exists Funcionario;

create table Cliente(
	telefone varchar(12) primary key,
    nome varchar(50) not null,
    rua varchar(50) not null,
    numero int,
    compl varchar(50),
    bairro varchar(50)
);

create table Pizza(
	codigo varchar(5) primary key,
    nome varchar(20),
    descricao varchar(100),
    preco numeric(5,2)
);

create table Ingredientes_pizza(
	nome_ingrediente varchar(20),
    cod_pizza varchar(5),
    primary key(nome_ingrediente, cod_pizza),
    foreign key (cod_pizza) references Pizza (codigo)
);

create table Funcionario(
	cpf varchar(11) primary key,
    nome varchar(20) not null
);

create table Pedido(
	codigo int primary key,
    data_hora datetime,
    tel_cliente varchar(12),
    cpf_funcionario varchar(11),
    foreign key (tel_cliente) references Cliente(telefone),
    foreign key (cpf_funcionario) references Funcionario(cpf)
);

create table Item_pedido(
	cod_pedido int,
    cod_pizza varchar(5),
    quantidade int,
    primary key (cod_pedido, cod_pizza),
    foreign key (cod_pedido) references Pedido(codigo),
    foreign key (cod_pizza) references Pizza(codigo)
);

-- >>> EXERCÍCIO 2 <<< 

-- INSERTS | 2) a. Inserir uma linha para cada tabela do banco de dados PIZZARIA, respeitando as restrições de integridade;
insert into Cliente
values  ('16988550240','Gabriel Albino','Av. Carlos','98',NULL,'Yolanda'),
        ('16999999999','Ana Beatriz','Rua Miguel','100',NULL,'Cecap'),
        ('16988888888','Bruna Lima','Av. Bahia','523','Apto. 200 - Bloco II', 'Centro'),
        ('16977777777','Caio Lopes','Rua Mauá','362','Apto. 510 - Bloco I', 'Centro');

insert into Pizza
values  ('PM1', 'Calabresa (M)', 'Pizza Média de calabresa suculenta e levemente picante', 39.90),
        ('PM2', 'Bauru (M)', 'Pizza Média de presunto e queijo cremosa e tradicional', 39.90),
        ('PM3', 'Frangostoso (M)', 'Pizza Média de frango desfiado com sabor suave e envolvente', 39.90),
        ('PM4', 'Quatro Queijos (M)', 'Pizza Média com queijos derretidos e sabor marcante', 39.90),
        ('PG1', 'Atum (G)', 'Pizza Grande de atum suave e saboroso', 59.90),
        ('PG2', 'Doritos (G)', 'Pizza Grande com doritos crocante e cheddar cremoso', 59.90),
        ('PG3', 'Marguerita (G)', 'Pizza Grande com manjericão fresco e toque clássico', 59.90),
        ('PG4', 'Espinafre (G)', 'Pizza Grande do Popeye', 59.90);

insert into Ingredientes_pizza
values  ('Molho de tomate','PM1'), ('Mussarela','PM1'), ('Calabresa','PM1'), ('Cebola', 'PM1'), ('Azeitona', 'PM1'),
        ('Molho de tomate','PM2'), ('Mussarela','PM2'), ('Presunto','PM2'), ('Azeitona','PM2'),
        ('Molho de tomate','PM3'), ('Mussarela','PM3'), ('Frango Desfiado','PM3'), ('Milho','PM3'), ('Catupiry','PM3'),
        ('Molho de tomate','PM4'), ('Mussarela','PM4'), ('Provolone','PM4'), ('Gorgonzola','PM4'), ('Parmesão','PM4'),
        ('Molho de tomate','PG1'), ('Mussarela','PG1'), ('Atum','PG1'), ('Cebloa','PG1'),
        ('Molho de tomate','PG2'), ('Mussarela','PG2'), ('Doritos','PG2'), ('Cheddar','PG2'),
        ('Molho de tomate','PG3'), ('Mussarela','PG3'), ('Manjericão','PG3'), ('Tomate seco','PG3');

insert into Funcionario
values  ('4444444444','Lucas silva'),
        ('5555555555','Bruno Vilas');

insert into Pedido 
values  ('1','2025-05-05 19:00','16988550240','5555555555'),
        ('2','2025-05-06 20:00','16999999999','4444444444'),
        ('3','2025-05-06 21:00','16977777777','5555555555'),
        ('4','2025-05-07 18:30','16988888888','4444444444'),
        ('5','2025-05-07 19:45','16988550240','5555555555'),
        ('6','2025-05-08 20:15','16999999999','4444444444'),
        ('7','2025-05-08 21:10','16977777777','5555555555'),
        ('8','2025-05-11 20:00','16988550240','5555555555');

insert into Item_pedido
values  ('1','PM3',1), ('1','PM2',1),
        ('2','PM1',1), ('2','PG1',1),
        ('3','PG3',2), ('3','PM4',1),
        ('4','PM1',1), ('4','PM4',1),
        ('5','PG3',2),
        ('6','PM2',1), ('6','PG1',1),
        ('7','PG3',1),
        ('8','PM3',2), ('8','PM4',1), ('8','PG1',1); 

-- UPDATE | 2) b. Atualizar o endereço de um cliente, informando o número de telefone dele;
update Cliente set rua = 'Rua dos Bobos', numero = '0', compl = NULL where telefone =  '16977777777';

-- DELETE | 2) c. Excluir todos ingredientes de uma pizza, informando o código da pizza.
delete from Ingredientes_pizza where cod_pizza = 'PG2';

-- >>> EXERCÍCIO 3 <<<
--  a) Elaborar uma consulta que contenha duas condições na cláusula WHERE;
select p.codigo 'ID', p.data_hora 'Data e hora', c.nome 'Cliente', c.telefone 'Telefone', f.nome 'Atendido por', pz.nome 'Pizza', ip.quantidade 'Quantidade'
from Pedido p
join Cliente c on c.telefone = p.tel_cliente
join Funcionario f on f.cpf = p.cpf_funcionario
join Item_pedido ip on ip.cod_pedido = p.codigo
join Pizza pz on pz.codigo = ip.cod_pizza
where data_hora > '2025-05-05 00:00' and data_hora <= '2025-05-06 23:59'

--  b) Elaborar uma consulta que contenha operações aritméticas na cláusula SELECT;
select p.codigo 'ID', p.data_hora 'Data e hora', c.nome 'Cliente', c.telefone 'Telefone', f.nome 'Atendido por', group_concat(pz.nome separator ', ') 'Pizzas', sum(ip.quantidade * pz.preco) as 'Total em R$'
from Pedido p
join Cliente c on c.telefone = p.tel_cliente
join Funcionario f on f.cpf = p.cpf_funcionario
join Item_pedido ip on ip.cod_pedido = p.codigo
join Pizza pz on pz.codigo = ip.cod_pizza
group by p.codigo

--  c) Elaborar uma consulta que contenha ORDER BY;
select nome 'Pizza', codigo 'ID'
from Pizza
order by nome

--  d) Elaborar uma consulta que contenha operador LIKE;
select nome 'Pizza', codigo 'ID'
from pizza
where nome like '%(M)%'

--  e) Elaborar uma consulta que contenha operador IS NULL;
select nome as 'Cliente', rua, numero, bairro
from cliente
where compl is null;

--  f) Elaborar uma consulta que contenha função de agregação;
select c.nome 'Cliente', c.telefone AS 'Telefone', COUNT(*) AS 'Total de Pedidos'
from pedido p
join cliente c on c.telefone = p.tel_cliente
group by tel_cliente

-- g) Elaborar uma consulta contendo subconsulta de única linha;
select nome 'Cliente', telefone
from cliente
where telefone = (
    select tel_cliente
    from pedido
    group by tel_cliente
    order by count(*) desc
    limit 1
);

--  h) Elaborar uma consulta contendo subconsulta de múltiplas linhas.
select nome 'Pizzas nunca pedidas', codigo 'ID'
from pizza
where codigo not in (
    select cod_pizza
    from item_pedido
);
create database if not exists exercicios;
use exercicios;

drop table if exists cidades;
create table cidades(
	idCidade int,
    Nome char(255),
    UF char(2)
);

drop table if exists agenda;
create table agenda(
	idContato int,
    Nome char(255),
    Celular char(255),
    idCidade int default 1,
    Classe char(255)
);

insert into agenda (idContato, Nome, Celular, idCidade, Classe) values (1, "Caio","16 997852204", 2, "Família");
insert into agenda (idContato, Nome, Celular, Classe) values (2, "Laura","16 997852205", "Amizade");
insert into agenda (idContato, Nome, Celular, idCidade, Classe) values (2, "Eduardo","16 997852305", 1, "IFSP");
select * from agenda;
create database if not exists cantinaIFSP;
use cantinaIFSP;

drop table if exists Salgados;
drop table if exists Valores;
drop table if exists Categorias;
drop table if exists Tamanhos;

create table if not exists Valores(
    cor char(50) unique,
    valor float check (valor>0),
	constraint cor primary key (cor)
);

create table if not exists Categorias(
	idCategoria int auto_increment,
    categoria char(50) not null,
    constraint idCategoria primary key (idCategoria)
);

create table if not exists Tamanhos(
	idTamanho int auto_increment,
    tamanho char(50) not null,
	constraint idTamanho primary key (idTamanho)
);

create table if not exists Salgados(
	idSalgado int auto_increment,
    nome char(50) not null,
    tamanho int not null,
    cor char(50) not null,
    categoria int not null,
	constraint idSalgado primary key (idSalgado),
    foreign key (tamanho) references Tamanhos(idTamanho),
    foreign key (cor) references Valores(cor),
    foreign key (categoria) references Categorias(idCategoria)
);

insert into Valores(cor, valor)
values ("vermelho", 10),
		("amarelo", 8), 
        ("verde", 6), 
        ("azul", 5);
        
insert into Categorias(categoria)
values ("Frito"),
		("Assado");
        
insert into Tamanhos(tamanho)
values ("Pequeno"),
		("Médio"),
        ("Grande");
        
insert into Salgados(nome, tamanho, cor, categoria)
values ("Coxinha de frango",2,"verde",1),
("Esfiha de carne",2,"azul",2),
("Risóles de presunto e queijo",2,"verde",1),
("Joelho de presunto e queijo",3,"vermelho",2),
("Kibe com catupiry",1,"amarelo",1),
("Bolinha de queijo",1,"azul",1),
("Espetinho de frango",1,"amarelo",1);

select s.idSalgado, s.nome as "Salgado", t.tamanho, v.valor, c.categoria
from Salgados s
inner join Tamanhos t on s.tamanho = t.idTamanho
inner join Valores v on s.cor = v.cor
inner join Categorias c on s.categoria = c.idCategoria
order by v.valor desc;
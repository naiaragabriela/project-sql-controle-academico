create DATABASE CONTROLE_ACADEMICO;

CREATE TABLE Aluno(
    RA int NOT NULL,
    Nome varchar (100) NOT NULL,

    CONSTRAINT PK_Aluno PRIMARY KEY (RA)
);
GO

CREATE TABLE Disciplina(
    Codigo INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    CargaHoraria INT NOT NULL,

    CONSTRAINT PK_Disciplina PRIMARY KEY (Codigo)
);
GO

Create Table Matricula(
    ID INT identity (1,1),
    RA int NOT NULL,
    Ano INT NOT NULL,
    Semestre INT NOT NULL,

    CONSTRAINT PK_Matricula PRIMARY KEY (ID),
    CONSTRAINT FK_Matricula_Aluno FOREIGN KEY (RA) references Aluno(RA),
    CONSTRAINT UN_Matricula UNIQUE (RA, Ano, Semestre)
);
GO

Create Table Item_Matricula(
    ID int NOT NULL,
    Codigo INT NOT NULL,
    Nota_1 DECIMAL (4,2),
    Nota_2 DECIMAL (4,2),
    Sub DECIMAL (4,2),
    Faltas INT NOT NULL,
    Situacao VARCHAR (19) NOT NULL,

    CONSTRAINT PK_Item_Matricula PRIMARY KEY (ID,Codigo),
    CONSTRAINT FK_Item_Matricula_Matricula FOREIGN KEY (ID) references Matricula (ID),
    CONSTRAINT FK_Item_Matricula_Discipina FOREIGN KEY (Codigo) references Disciplina (Codigo),

);
GO

--inserção de alunos 

Insert into Aluno values (1,'Giovani');
Insert into Aluno (Nome,RA) VALUES ('Ana Maria',2);
insert into Aluno values (3, 'Felipe');

select * from Aluno
order by Nome desc 


--inserção de disciplinas

insert into Disciplina VALUES (1,'Banco de dados', 80), 
(2,'IA', 80), (3,'SO', 60);
select * from Disciplina

--inserção de matricula

insert into Matricula VALUES (1, 2023, 1);
SELECT * from Matricula;

insert into Matricula VALUES (2, 2023, 1);
SELECT * from Matricula;
insert into Matricula VALUES (3, 2023, 1);
SELECT * from Matricula;

-- alteração da disciplina

update Disciplina set nome = 'Inteligencia Artificial', cargaHoraria =100
where codigo = 2

update Disciplina set nome = 'Banco de Dados', cargaHoraria =80
where codigo = 1

delete Disciplina
where codigo = 3
select * from Disciplina

--Disciplinas da Matricula de cada Aluno

    insert into Item_Matricula (id, codigo, faltas, situacao) values (1, 1, 0, 'matriculado')
    SELECT * from Item_Matricula;
    insert into Item_Matricula (id, codigo, faltas, situacao) values (1, 2, 0, 'matriculado')
    insert into Item_Matricula (id, codigo, faltas, situacao) values (2, 1, 0, 'matriculado')
    SELECT * from Item_Matricula;


    select m.Ano, m.Semestre, m.id, a.Nome, d.Nome 
    from Aluno a JOIN Matricula m on a.RA = m.RA 
    JOIN Item_Matricula im on m.ID = im.ID
    JOIN Disciplina d on im.Codigo = d.Codigo


    select m.Ano, m.Semestre, m.id, a.Nome, d.Nome, im.Nota_1, im.Nota_2, im.Sub, im.Faltas
    from Aluno a JOIN Matricula m on a.RA = m.RA 
    JOIN Item_Matricula im on m.ID = im.ID
    JOIN Disciplina d on im.Codigo = d.Codigo
    where a.nome = 'Giovani'


--Cadastros de Notas na tabela

    UPDATE Item_Matricula SET Nota_1 = 9, Nota_2 = 7, Sub = Null
    Where Id = 1 and Codigo = 2
    SELECT * from Item_Matricula;
    UPDATE Item_Matricula SET Nota_1 = 4, Nota_2 = 5, Sub = 6
    Where Id = 1 and Codigo = 1
    SELECT * from Item_Matricula;
    UPDATE Item_Matricula SET Nota_1 = 4, Nota_2 = 2, Sub = 8
    Where Id = 2 and Codigo = 1
    SELECT * from Item_Matricula;


    select m.Ano, m.Semestre, m.id, a.Nome, d.Nome, im.Nota_1, im.Nota_2, im.Sub, im.Faltas
    from Aluno a JOIN Matricula m on a.RA = m.RA 
    JOIN Item_Matricula im on m.ID = im.ID
    JOIN Disciplina d on im.Codigo = d.Codigo
    where a.nome = 'Giovani'



--calculo da media

    SELECT m.Ano, m.Semestre, m.id, a.Nome, d.Nome, im.Nota_1, im.Nota_2, im.Sub, im.Faltas,
    CASE 
    WHEN (Sub is Null) then (Nota_1 + Nota_2)/2
    WHEN (Sub > Nota_1) and (Nota_1 < Nota_2) then (Sub + Nota_2)/2
    WHEN (Sub > Nota_2) and (Nota_2 < Nota_1) then (Sub+ Nota_1)/2
    END AS 'Media'
    FROM Aluno a JOIN Matricula m ON a.RA = m.RA
    JOIN Item_Matricula im on m.ID = im.ID
    JOIN Disciplina d ON im.Codigo = d.Codigo 
    Where a.Nome = 'Giovani'


--cadastro de faltas na tabela 

    UPDATE Item_Matricula SET Faltas = 20
    Where Id = 1 and Codigo = 2
    UPDATE Item_Matricula SET Faltas = 40
    Where Id = 1 and Codigo = 1
    UPDATE Item_Matricula SET Faltas = 70
    Where Id = 2 and Codigo = 1
    SELECT * from Item_Matricula;

--calculo reprovacao por falta

    SELECT m.Ano, m.Semestre, m.id, a.Nome, d.Nome, im.Nota_1, im.Nota_2, im.Sub, im.Faltas,
    CASE 
    WHEN (CargaHoraria*0.25<Faltas) then 'Reprovado por falta'
    WHEN (CargaHoraria*0.25>Faltas) then 'Aprovado por falta, ver media'
    END AS 'Situação'
    FROM Aluno a JOIN Matricula m ON a.RA = m.RA
    JOIN Item_Matricula im on m.ID = im.ID
    JOIN Disciplina d ON im.Codigo = d.Codigo 
    Where a.Nome = 'Ana Maria'
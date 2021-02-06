/* INSERINDO VALORES PARA O DOADOR */
INSERT INTO Doador(NomePai, NomeMae, DataNascimento, Sexo, RG, Nome, Rua, Bairro, Cidade, Estado, NumeroResidencial, CEP) VALUES ('Francisco Pires', 'Claudia Pires', '1996-12-09', 'M', 330993653, 'Matheus Pires', 'Rua Adolfo Valentini', 'Osasco', 'Sao Paulo', 'SP', 35, '06018-060'), ('Gabriel Martins', 'Gabriela Martins', '1998-12-09', 'F', 181821679, 'Maria Martins', 'Travessa Adrião Henrique dos Reis', 'Centro', 'Osasco', 'SP', 315, '06110-020'), ('Carlos Souza', 'Naty Souza', '1992-10-10', 'M', 268305316, 'Waldyr Souza', 'Rua Afonso Schmidt', 'Centro', 'Osasco', 'SP', 50, '06083-250'), ('Adam Augusto', 'Scarlet Augusto', '2000-01-22', 'F', 453303924, 'Joana Augusto', 'Rua Albino Guilherme Esteves', 'Centro', 'Osasco', 'SP', 501, '06018-130'), ('Andrey Sutil', 'Isabela Sutil', '1990-05-27', 'F', 299882743, 'Paloma Sutil', 'Rua Albino dos Santos', 'Centro', 'Osasco', 'SP', 150, '06093-060'), ('Diogo Nascimento', 'Josiane Nascimento', '2001-02-10', 'M', 214956982, 'Mbappé Nascimento', 'Rua Alexandre Rossi', 'Centro', 'Osasco', 'SP', 43, '06110-010');

/* INSERINDO VALORES PARA DOACAO */
INSERT INTO Doacao(IDDoador, DataDoacao, QtdColetada) VALUES (1, '2017-11-22 10:20:32', 330), (2, '2018-05-13 09:50:50', 450), (3, '2019-06-19 16:00:15', 400), (4, '2016-08-10 17:19:20', 380), (5, '2015-03-15 14:07:36', 330), (6, '2019-10-10 10:30:44', 395);

/* INSERINDO VALORES PARA MEDICOS */
INSERT INTO Medico(Nome, CRM, EstadoCRM) VALUES ('Dr. César Gruppi', 254845, 'SP'), ('Dr. Cristiano Faria Pisani', 118484, 'SP'), ('Dra. Luciana Sacilotto Fernandes', 499579, 'SP'), ('Dra. Paola Pretti Nunes Ferreira Falochio', 639332, 'SP'), ('Dra. Sissy de Melo', 293586, 'SP'), ('Dr. Mateus Paiva Marques Feitosa', 223227, 'SP');

/* INSERINDO VALORES PARA TESTESANGUE */
INSERT INTO TesteSangue (Nome, ValorRef) VALUES ('Hepatite B', '145.81'), ('Hepatite C', '130.10'), ('AIDS', '300.71'), ('Chagas', '300.71'), ('Sifilis B', '95.11'), ('Hepatite C', '480.10'), ('HTLV I', '57.61'), ('HTLV II', '205.07');
INSERT INTO TesteSangue (TipoSanguineo, FatorRH, Anticorpos) VALUES ('O', '-', 'Antiglobulina'), ('O', '+', 'Antiglobulina'), ('A', '+', 'Antiglobulina'), ('A', '-', 'Antiglobulina'), ('B', '+', 'Antiglobulina'), ('B', '-', 'Antiglobulina'), ('AB', '+', 'Antiglobulina'), ('AB', '-', 'Antiglobulina');

/* INSERINDO VALORES PARA EXAMESANGUE; PRECISO VERIFICAR O ATRIBUTO RESULTADO (CREIO QUE ATRAVES DO IDTESTESANGUE JA CONSIGO OBTER TODOS OS RESULTADOS */
INSERT INTO ExameSangue (IDDoacao, IDTesteSangue, Resultado, DataExameSangue) VALUES (1, 2, 'Hepatite B' , '2017-11-24 10:00:15'), (2, 4, 'Hepatite C', '2018-05-15 09:30:32'), (3, 6, 'Sifilis', '2019-06-21 16:15:03'), (4, 1, 'HTLV I', '2016-08-12 17:22:48'), (5, 3, 'AIDS', '2015-03-17 14:14:14'), (6, 5, 'Chagas', '2019-10-12 10:40:20');

/* INSERINDO VALORES PARA CONSULTA */
INSERT INTO Consulta (IDMedico, IDExameSangue, IDDoacao, IDTesteSangue, DataConsulta) VALUES (1, 1, 1, 2, '2018-10-11 10:27:05'), (2, 4, 4, 1, '2019-01-21 11:39:49'), (4, 6, 6, 5, '2017-03-20 15:04:21'), (3, 2, 2, 4, '2015-06-11 18:30:59'), (5, 3, 3, 6, '2016-07-30 16:15:15'), (6, 5, 5, 3, '2019-02-15 09:09:09');

/* INSERINDO VALORES PARA EXAMES */
INSERT INTO Exames (Pergunta) VALUES ('ultima vez que fumou?'), ('ultima vez que bebeu?'), ('ultima vez que doou sangue?'), ('tem alguma doenca?'), ('ja foi operado?'), ('Tomou vacina para gripe?'), ('Possui diabete?'), ('Colocou piercing?'), ('Usou drogas?'), ('Fez tatuagem?'), ('Fez endoscopia?'), ('Ja possuiu malaria?');


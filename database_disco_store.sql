--A dataBase of a Disco store

CREATE DATABASE dbDiscos;

--CRIANDO A TABELA QUE VAI ARMAZENAR OS DADOS DOS PRODUTORES

CREATE TABLE Produtor(
Pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
Nome VARCHAR(120) NOT NULL UNIQUE); --AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.


CREATE INDEX index_nome_produtor ON TABLE Produtor(Nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.


--criando a entidade Gravadora que armazena os dados de cada gravadora.

CREATE TABLE gravadora(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome VARCHAR(45) NOT NULL UNIQUE); -- AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.

CREATE INDEX index_nome_gravadora ON TABLE gravadora(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.



--criando a tabela gênero que fornecera o tipo do edtilo musical para os discos e as músicas simultâneamente

CREATE TABLE genero(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
n6ome VARCHAR(45) NOT NULL UNIQUE); -- AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.

CREATE INDEX index_tipo_genero ON TABLE genero(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.


--CRIANDO A TABELA PRINCIPAL QUE VAI ARMAZENAR OS DISCOS


CREATE TABLE disco(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome VARCHAR(100) NOT NULL,
ano_lancamento DATE DEFAULT '00-00-0000',
preco DECIMAL NOT NULL,
fk_id_gravadora INT NOT NULL FOREING KEY REFERENCES Gravadora(Pk_id),
fk_id_produtor INT NOT NULL FOREING KEY Produtor REFERENCES (Pk_id),
fk_id_genero INT NOT NULL FOREING KEY Genero REFERENCES(Pk_id));

CREATE INDEX index_nome_disco ON TABLE disco(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.

CREATE INDEX index_Lancamento ON TABLE disco(ano_lancamento);
--criando index para a coluna ano_lancamento(coluna com altas possibilidade de utilização para queries)facilitando as buscas e otimizando em resposta das queries.

CREATE INDEX index_Lancamento ON TABLE disco(preco);
--criando index para a coluna preco(coluna com altas possibilidade de utilização para queries)facilitando as buscas e otimizando em resposta das queries.


--Criando a entidade que receberá as músicas dos discos 

CREATE TABLE musicas(
pk_id INT IDENTIFY(1,1) PRIMARY KEY,
nome VARCHAR(80) NOT NULL,
minutos TIME DEFAULT '00:00',
fk_id_genero INT NOT NULL FOREING KEY Genero REFERENCES (Pk_id));

CREATE INDEX index_nome_musicas ON TABLE musicas(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.

CREATE INDEX index_Minutos ON TABLE musicas(minutos);
--criando index para a coluna minutos (coluna com altas possibilidade de utilização para queries)facilitando as buscas e otimizando em resposta das queries.



--criando a entidade para receber a informação das faixas (posições)

CREATE TABLE faixas(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
fk_id_musica INT NOT NULL FOREING KEY musicas REFERENCES (Pk_id));

--Não criamos um index nonclustered aqui porque qualquer querie realizada nessa entidade deve ser feita apens pelo id que já possui um clustered


--Criando a entidade que utilizará a relação muitos para muitos, para relacionar cada música em cada disco diferente.

CREATE TABLE faixas_disco(
pfk_id_faixas INT NOT NULL FOREING KEY Faixas REFERENCES (pk_id),
pfk_id_musicas INT NOT NULL FOREING KEY Faixas REFERENCES (fk_id_musica),
pfk_id_disco INT NOT NULL FOREING KEY Disco REFERENCES (Pk_id));



--criando a entidade que liga os discos e as músicas em uma relação muitos para muitos

CREATE TABLE disco_musicas(
pfk_id_musicas INT NOT NULL FOREING KEY musicas REFERENCES (pk_id),
pfk_id_disco INT NOT NULL FOREING KEY disco REFERENCES (pk_id));



--criando a entidade para receber a informação dos compositores das musicas

CREATE TABLE compositores(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome VARCHAR(80) NOT NULL UNIQUE, -- AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.
idade INT);

CREATE INDEX index_nome_compositores ON TABLE compositores(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.

CREATE INDEX index_idade ON TABLE compositores(idade);
--criando index para a coluna idade(coluna com altas possibilidade de utilização para queries)facilitando as buscas e otimizando em resposta das queries.



--Criando a entidade que utilizará a relação muitos para muitos, para relacionar em cada música o compositor.

CREATE TABLE musicas_compositores(
pfk_id_musicas INT NOT NULL FOREING KEY musicas REFERENCES (pk_id),
pfk_id_compositores INT NOT NULL FOREING KEY compositores REFERENCES (pk_id));


--criando a entidade para receber a informação dos interpretes das musicas em cada disco. 

CREATE TABLE interpretes(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome VARCHAR(80) NOT NULL UNIQUE); -- AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.

CREATE INDEX index_nome_interpretes ON TABLE interpretes(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.



--Criando a entidade que utilizará a relação muitos para muitos, para relacionar em cada música o interprete, aproveitando a relação já existente disco_musica.


CREATE TABLE interpretes_disco_musicas(
pfk_id_musicas INT NOT NULL FOREING KEY disco_musicas REFERENCES pfk_id_discos),
pfk_id_disco INT NOT NULL FOREING KEY disco_musicas REFERENCES (pfk_id_musicas));
pfk_id_interpretes INT NOT NULL FOREING KEY Interpretes REFERENCES (pk_id));


//criando a entidade para receber a informação dos interpretes das musicas em cada disco. 

CREATE TABLE instrumentos(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome_instrumento VARCHAR(80) NOT NULL UNIQUE); -- AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.

CREATE INDEX index_nome_funcao ON TABLE instrumentos(nome_instrumento);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.

CREATE TABLE instrumentista(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome_instrumentista VARCHAR(80) NOT NULL); 

CREATE INDEX index_nome_instrumentista ON TABLE instrumentista(nome_instrumentista);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.

--Criando a entidade que relacionará o tipo de instrumento de cada instrumentista

CREATE TABLE instrumentista_instrumentos(
pfk_id_instrumentista INT NOT NULL FOREING KEY instrumentista REFERENCES (pk_id),
pfk_id_instrumento INT NOT NULL FOREING KEY instrumento REFERENCES (pk_id));

--Criando a entidade que utilizará a relação muitos para muitos, para relacionar em cada música o instrumento que o instrumentisrta toca e em cada disco (aproveitando a entidade Disco_musicas)


CREATE TABLE instrumentista_disco_musicas(
pfk_id_instrumentista INT NOT NULL FOREING KEY instrumentista REFERENCES (pfk_id_instrumento),
pfk_id_instrumento INT NOT NULL FOREING KEY instumentista_Instrumentos REFERENCES (pfk_id_instrumentista),
pfk_id_musicas INT NOT NULL FOREING KEY disco_musicas REFERENCES (pfk_id_discos),
pfk_id_disco INT NOT NULL FOREING KEY disco_musicas REFERENCES (pfk_id_musicas));




//criando a entidade para receber a informação do tipo(s) de disco. 

CREATE TABLE tipo_midia(
pk_id INT IDENTIFY(1,1) PRIMARY KEY, --AO CRIAR UMA PRIMARY KEY UM ÍNDICE CLUSTERED (ÍNDICE UNICO E ORGANIZADO LINHA A LINHA) É CRIADO "AUTOMATICAMENTE"
nome VARCHAR(45) NOT NULL UNIQUE); -- AO SETAR A CONSTRAIN UNIQUE CRIA-SE "AUTOMATICAMENTE" UM INDÍCE DE RESTRIÇÃO DE NOME ÚNICO.


CREATE INDEX index_tipo_midia ON TABLE tipo_midia(nome);
--criando index para a coluna nome (coluna com maior requisição para queries depois do id) para facilitar as buscas e otimizações de resposta das queries.

--Criando a entidade que utilizará a relação muitos para muitos, para relacionar cada música em cada disco diferente.

CREATE TABLE tipo_midia_disco(
pfk_id_tipo_midia INT NOT NULL FOREING KEY Tipo_midia REFERENCES (pk_id),
pfk_id_disco INT NOT NULL FOREING KEY disco REFERENCES (pk_id));


-- POVOANDO O BANCO 

INSERT INTO produtor(nome)
VALUES("Caio Macedo");

INSERT INTO gravadora(nome)
VALUES("MacedoMusics");

INSERT INTO genero(nome)
VALUES("Rock");

INSERT INTO disco(nome,ano_lancamento,preco,fk_id_gravadora,fk_id_produtor,fk_id_genero)
VALUES("Hot Pink",'07/09/20222',295.00,1,1,1);


INSERT INTO musicas(nome,minutos,fk_id_genero)
VALUES("Like That",'02:43:00',1);


INSERT INTO faixas(fk_id_musica)
VALUES(1);

INSERT INTO faixas_disco(pfk_id_faixas,pfk_id_musicas)
VALUES(1,1,1);


INSERT INTO disco_musicas(pfk_id_musicas,pfk_id_disco)
VALUES(1,1);

INSERT INTO compositores(nome,idade)
VALUES("Marcelo Bezeirra",52);

INSER INTO musicas_compositores(pfk_id_musicas,pfk_id_compositores)
VALUES (1,1);

INSERT INTO interpretes(nome)
VALUES("Doja Cat");


INSERT INTO interpretes_disco_musicas(pfk_id_musicas,pfk_id_disco,pfk_id_interpretes)
VALUES(1,1,1);


INSERT INTO instrumentos(nome_instrumento )
VALUES("Guitarra");

INSERT INTO instrumentista(nome_instrumentista)
VALUES("Willian Borges");


INSERT INTO instrumentista_instrumentos(pfk_id_instrumentista,pfk_id_instrumento)
VALUES(1,1);

INSERT INTO interpretes_disco_musicas(pfk_id_instrumentista,pfk_id_instrumento,pfk_id_musicas,pfk_id_disco)
VALUES(1,1,1,1);

INSERT INTO tipo_midia(nome)
VALUES("vinil");

INSER INTO tipo_midia_disco(pfk_id_tipo_midia,pfk_id_disco)
VALUES(1,1);


INSERT INTO genero(nome)
VALUES("Pop");


INSERT INTO musicas(nome,minutos,fk_id_genero)
VALUES("Say So",'03:40:00',2);


INSERT INTO faixas(fk_id_musica)
VALUES(2);

INSERT INTO faixas_disco(pfk_id_faixas,pfk_id_musicas)
VALUES(2,2,1);


INSERT INTO gravadora(nome)
VALUES("MacedoMusics");

INSERT INTO genero(nome)
VALUES("Rock");

INSERT INTO disco(nome,ano_lancamento,preco,fk_id_gravadora,fk_id_produtor,fk_id_genero)
VALUES("Hot Pink",'07/09/20222',295.00,1,1,1);


INSERT INTO musicas(nome,minutos,fk_id_genero)
VALUES("Like That",'02:43:00',1);


INSERT INTO faixas(fk_id_musica)
VALUES(1);

INSERT INTO faixas_disco(pfk_id_faixas,pfk_id_musicas)
VALUES(1,1,1);


INSERT INTO disco_musicas(pfk_id_musicas,pfk_id_disco)
VALUES(2,1);


INSER INTO musicas_compositores(pfk_id_musicas,pfk_id_compositores)
VALUES (2,1);



INSERT INTO interpretes_disco_musicas(pfk_id_musicas,pfk_id_disco,pfk_id_interpretes)
VALUES(2,1,1);


INSERT INTO instrumentista(nome_instrumentista)
VALUES("Baiacu","Borges");


INSERT INTO instrumentista(pfk_id_instrumentista,pfk_id_instrumento)
VALUES(1,1);

INSERT INTO interpretes_disco_musicas(pfk_id_instrumentista,pfk_id_instrumento,pfk_id_musicas,pfk_id_disco)
VALUES(2,1,2,1);


INSER INTO tipo_midia_disco(pfk_id_tipo_midia,pfk_id_disco)
VALUES(1,1);




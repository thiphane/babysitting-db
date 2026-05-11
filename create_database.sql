

DROP TRIGGER trg_utilizam_stock;
DROP TRIGGER trg_trabalham_horas;
DROP TRIGGER trg_babysitting_hora_dormir;


DROP TABLE Utilizam         CASCADE CONSTRAINTS;
DROP TABLE Trabalham        CASCADE CONSTRAINTS;
DROP TABLE Participam       CASCADE CONSTRAINTS;
DROP TABLE Avaliacoes       CASCADE CONSTRAINTS;
DROP TABLE PagamentoCliente CASCADE CONSTRAINTS;
DROP TABLE Inventario       CASCADE CONSTRAINTS;
DROP TABLE Eventos          CASCADE CONSTRAINTS;
DROP TABLE Festas           CASCADE CONSTRAINTS;
DROP TABLE Babysitting      CASCADE CONSTRAINTS;
DROP TABLE Servicos         CASCADE CONSTRAINTS;
DROP TABLE Alergias         CASCADE CONSTRAINTS;
DROP TABLE TiposAlergia     CASCADE CONSTRAINTS;
DROP TABLE Criancas         CASCADE CONSTRAINTS;
DROP TABLE Disponibilidade  CASCADE CONSTRAINTS;
DROP TABLE Trabalhadores    CASCADE CONSTRAINTS;
DROP TABLE Clientes         CASCADE CONSTRAINTS;
DROP TABLE Adultos          CASCADE CONSTRAINTS;
DROP TABLE Pessoas          CASCADE CONSTRAINTS;


CREATE TABLE Pessoas (
    nCC         VARCHAR2(20)    NOT NULL,
    nome        VARCHAR2(100)   NOT NULL,
    CONSTRAINT pk_pessoas PRIMARY KEY (nCC)
);

CREATE TABLE Adultos (
    nCC             VARCHAR2(20)    NOT NULL,
    email           VARCHAR2(150)   NOT NULL,
    num_telefone    VARCHAR2(20)    NOT NULL,
    CONSTRAINT pk_adultos   PRIMARY KEY (nCC),
    CONSTRAINT fk_adultos_pessoas FOREIGN KEY (nCC) REFERENCES Pessoas(nCC)
        ON DELETE CASCADE
);

CREATE TABLE Clientes (
    nCC     VARCHAR2(20)    NOT NULL,
    morada  VARCHAR2(255)   NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (nCC),
    CONSTRAINT fk_clientes_adultos FOREIGN KEY (nCC) REFERENCES Adultos(nCC)
        ON DELETE CASCADE
);

CREATE TABLE Trabalhadores (
    nCC     VARCHAR2(20)    NOT NULL,
    cv      CLOB,
    CONSTRAINT pk_trabalhadores PRIMARY KEY (nCC),
    CONSTRAINT fk_trabalhadores_adultos FOREIGN KEY (nCC) REFERENCES Adultos(nCC)
        ON DELETE CASCADE
);

CREATE TABLE Disponibilidade (
    id_disp         NUMBER          GENERATED ALWAYS AS IDENTITY,
    nCC             VARCHAR2(20)    NOT NULL,
    dia_semana      VARCHAR2(15)    NOT NULL,
    hora_inicio     DATE            NOT NULL,
    hora_fim        DATE            NOT NULL,
    CONSTRAINT pk_disponibilidade PRIMARY KEY (id_disp),
    CONSTRAINT fk_disp_trabalhadores FOREIGN KEY (nCC) REFERENCES Trabalhadores(nCC)
        ON DELETE CASCADE,
    CONSTRAINT ck_disp_horas CHECK (hora_fim > hora_inicio),
    CONSTRAINT ck_dia_semana CHECK (dia_semana IN (
        'Segunda','Terca','Quarta','Quinta','Sexta','Sabado','Domingo'
    ))
);

CREATE TABLE Criancas (
    nCC             VARCHAR2(20)    NOT NULL,
    nCC_cliente     VARCHAR2(20)    NOT NULL,
    data_nascimento DATE            NOT NULL,
    CONSTRAINT pk_criancas PRIMARY KEY (nCC),
    CONSTRAINT fk_criancas_pessoas  FOREIGN KEY (nCC)         REFERENCES Pessoas(nCC)
        ON DELETE CASCADE,
    CONSTRAINT fk_criancas_clientes FOREIGN KEY (nCC_cliente) REFERENCES Clientes(nCC)
);

CREATE TABLE TiposAlergia (
    alergia     VARCHAR2(100)   NOT NULL,
    CONSTRAINT pk_tipos_alergia PRIMARY KEY (alergia)
);

CREATE TABLE Alergias (
    nCC         VARCHAR2(20)    NOT NULL,
    alergia     VARCHAR2(100)   NOT NULL,
    CONSTRAINT pk_alergias PRIMARY KEY (nCC, alergia),
    CONSTRAINT fk_alergias_criancas FOREIGN KEY (nCC)     REFERENCES Criancas(nCC)
        ON DELETE CASCADE,
    CONSTRAINT fk_alergias_tipos    FOREIGN KEY (alergia) REFERENCES TiposAlergia(alergia)
);

CREATE TABLE Servicos (
    id_servico      NUMBER          GENERATED ALWAYS AS IDENTITY,
    nCC             VARCHAR2(20)    NOT NULL,
    data            DATE            NOT NULL,
    local           VARCHAR2(255)   NOT NULL,
    hora_inicio     DATE            NOT NULL,
    hora_fim        DATE            NOT NULL,
    preco           NUMBER(10,2)    NOT NULL,
    CONSTRAINT pk_servicos PRIMARY KEY (id_servico),
    CONSTRAINT fk_servicos_clientes FOREIGN KEY (nCC) REFERENCES Clientes(nCC),
    CONSTRAINT ck_servicos_horas    CHECK (hora_fim > hora_inicio),
    CONSTRAINT ck_servicos_preco    CHECK (preco >= 0)
);

CREATE TABLE Babysitting (
    id_servico      NUMBER  NOT NULL,
    horas_dormir    DATE    NOT NULL,
    CONSTRAINT pk_babysitting PRIMARY KEY (id_servico),
    CONSTRAINT fk_babysitting_servicos FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
        ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER trg_babysitting_hora_dormir
BEFORE INSERT OR UPDATE ON Babysitting
FOR EACH ROW
DECLARE
    v_inicio    DATE;
    v_final     DATE;
BEGIN
    SELECT hora_inicio, hora_fim
    INTO v_inicio, v_final
    FROM Servicos
    WHERE id_servico = :NEW.id_servico;

    IF :NEW.horas_dormir < v_inicio OR :NEW.horas_dormir > v_fim THEN
        RAISE_APPLICATION_ERROR(-20001,
            'horas_dormir deve estar entre hora_inicio e hora_final do serviço.');
    END IF;
END;
/

CREATE TABLE Festas (
    id_servico  NUMBER          NOT NULL,
    tema_festa  VARCHAR2(100)   NOT NULL,
    CONSTRAINT pk_festas PRIMARY KEY (id_servico),
    CONSTRAINT fk_festas_servicos FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
        ON DELETE CASCADE
);

CREATE TABLE Eventos (
    id_servico      NUMBER          NOT NULL,
    tipo_evento     VARCHAR2(100)   NOT NULL,
    CONSTRAINT pk_eventos PRIMARY KEY (id_servico),
    CONSTRAINT fk_eventos_servicos FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
        ON DELETE CASCADE
);

CREATE TABLE Inventario (
    id_item     NUMBER          GENERATED ALWAYS AS IDENTITY,
    nome_item   VARCHAR2(150)   NOT NULL,
    quantidade  NUMBER(10)      NOT NULL,
    CONSTRAINT pk_inventario PRIMARY KEY (id_item),
    CONSTRAINT ck_inventario_qtd CHECK (quantidade >= 0)
);

CREATE TABLE PagamentoCliente (
    id_pagamento    NUMBER          GENERATED ALWAYS AS IDENTITY,
    id_servico      NUMBER          NOT NULL,
    nCC             VARCHAR2(20)    NOT NULL,
    valor           NUMBER(10,2)    NOT NULL,
    metodo          VARCHAR2(50)    NOT NULL,
    data_pag        DATE            NOT NULL,
    CONSTRAINT pk_pagamento     PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pag_servicos  FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico),
    CONSTRAINT fk_pag_clientes  FOREIGN KEY (nCC)        REFERENCES Clientes(nCC),
    CONSTRAINT ck_pag_valor     CHECK (valor > 0),
    CONSTRAINT ck_pag_metodo    CHECK (metodo IN ('Multibanco','MBWay','Transferencia','Numerario','Credito'))
);

CREATE TABLE Avaliacoes (
    id_avaliacao    NUMBER          GENERATED ALWAYS AS IDENTITY,
    id_servico      NUMBER          NOT NULL,
    nCC             VARCHAR2(20)    NOT NULL,
    classificacao   NUMBER(1)       NOT NULL,
    comentario      VARCHAR2(1000),
    data_avaliacao  DATE            NOT NULL,
    CONSTRAINT pk_avaliacoes            PRIMARY KEY (id_avaliacao),
    CONSTRAINT fk_aval_servicos         FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico),
    CONSTRAINT fk_aval_clientes         FOREIGN KEY (nCC)        REFERENCES Clientes(nCC),
    CONSTRAINT uq_aval_cliente_servico  UNIQUE (id_servico, nCC),
    CONSTRAINT ck_aval_classificacao    CHECK (classificacao BETWEEN 1 AND 5)
);

CREATE TABLE Participam (
    id_servico  NUMBER          NOT NULL,
    nCC         VARCHAR2(20)    NOT NULL,
    CONSTRAINT pk_participam        PRIMARY KEY (id_servico, nCC),
    CONSTRAINT fk_part_servicos     FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico),
    CONSTRAINT fk_part_criancas     FOREIGN KEY (nCC)        REFERENCES Criancas(nCC)
);

CREATE TABLE Trabalham (
    nCC             VARCHAR2(20)    NOT NULL,
    id_servico      NUMBER          NOT NULL,
    valor_recebido  NUMBER(10,2)    NOT NULL,
    horas_trabalho  NUMBER(4,2)     NOT NULL,
    CONSTRAINT pk_trabalham             PRIMARY KEY (nCC, id_servico),
    CONSTRAINT fk_trab_trabalhadores    FOREIGN KEY (nCC)        REFERENCES Trabalhadores(nCC),
    CONSTRAINT fk_trab_servicos         FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico),
    CONSTRAINT ck_trab_valor            CHECK (valor_recebido >= 0),
    CONSTRAINT ck_trab_horas            CHECK (horas_trabalho > 0)
);

CREATE OR REPLACE TRIGGER trg_trabalham_horas
BEFORE INSERT OR UPDATE ON Trabalham
FOR EACH ROW
DECLARE
    v_duracao   NUMBER;
BEGIN
    SELECT (hora_fim - hora_inicio) * 24
    INTO v_duracao
    FROM Servicos
    WHERE id_servico = :NEW.id_servico;

    IF :NEW.horas_trabalho > v_duracao THEN
        RAISE_APPLICATION_ERROR(-20002,
            'horas_trabalho não pode exceder a duração do serviço (' 
            || v_duracao || ' horas).');
    END IF;
END;
/

CREATE TABLE Utilizam (
    id_servico  NUMBER          NOT NULL,
    id_item     NUMBER          NOT NULL,
    quant_gasta NUMBER(10)      NOT NULL,
    CONSTRAINT pk_utilizam      PRIMARY KEY (id_servico, id_item),
    CONSTRAINT fk_util_servicos   FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico),
    CONSTRAINT fk_util_inventario FOREIGN KEY (id_item)    REFERENCES Inventario(id_item),
    CONSTRAINT ck_util_quant      CHECK (quant_gasta > 0)
);

CREATE OR REPLACE TRIGGER trg_utilizam_stock
BEFORE INSERT OR UPDATE ON Utilizam
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    SELECT quantidade INTO v_stock
    FROM Inventario
    WHERE id_item = :NEW.id_item;

    IF :NEW.quant_gasta > v_stock THEN
        RAISE_APPLICATION_ERROR(-20003,
            'Quantidade gasta excede o stock disponível em inventário.');
    END IF;
END;
/

--PESSOAS
INSERT INTO Pessoas VALUES ('100000001', 'Maria João Silva');
INSERT INTO Pessoas VALUES ('100000002', 'António Ferreira');
INSERT INTO Pessoas VALUES ('100000003', 'Beatriz Santos');
INSERT INTO Pessoas VALUES ('100000004', 'Carlos Oliveira');
INSERT INTO Pessoas VALUES ('100000005', 'Diana Costa');
INSERT INTO Pessoas VALUES ('100000006', 'Eduardo Martins');
INSERT INTO Pessoas VALUES ('200000001', 'Filipa Rodrigues');  -- trabalhadora
INSERT INTO Pessoas VALUES ('200000002', 'Gonçalo Pereira');   -- trabalhador
INSERT INTO Pessoas VALUES ('200000003', 'Helena Sousa');      -- trabalhadora
INSERT INTO Pessoas VALUES ('200000004', 'Ivo Carvalho');      -- trabalhador
INSERT INTO Pessoas VALUES ('300000001', 'Tomás Silva');       -- criança
INSERT INTO Pessoas VALUES ('300000002', 'Inês Ferreira');     -- criança
INSERT INTO Pessoas VALUES ('300000003', 'Rodrigo Santos');    -- criança
INSERT INTO Pessoas VALUES ('300000004', 'Leonor Oliveira');   -- criança
INSERT INTO Pessoas VALUES ('300000005', 'Mateus Costa');      -- criança

--ADULTOS
INSERT INTO Adultos VALUES ('100000001', 'maria.silva@gmail.com',     '911000001');
INSERT INTO Adultos VALUES ('100000002', 'antonio.ferreira@gmail.com','911000002');
INSERT INTO Adultos VALUES ('100000003', 'beatriz.santos@gmail.com',  '911000003');
INSERT INTO Adultos VALUES ('100000004', 'carlos.oliveira@gmail.com', '911000004');
INSERT INTO Adultos VALUES ('100000005', 'diana.costa@gmail.com',     '911000005');
INSERT INTO Adultos VALUES ('100000006', 'eduardo.martins@gmail.com', '911000006');
INSERT INTO Adultos VALUES ('200000001', 'filipa.rod@gmail.com',      '922000001');
INSERT INTO Adultos VALUES ('200000002', 'goncalo.per@gmail.com',     '922000002');
INSERT INTO Adultos VALUES ('200000003', 'helena.sousa@gmail.com',    '922000003');
INSERT INTO Adultos VALUES ('200000004', 'ivo.carvalho@gmail.com',    '922000004');

--CLIENTES
INSERT INTO Clientes VALUES ('100000001', 'Rua das Flores 10, Lisboa');
INSERT INTO Clientes VALUES ('100000002', 'Av. da Liberdade 55, Porto');
INSERT INTO Clientes VALUES ('100000003', 'Rua do Sol 8, Setubal');
INSERT INTO Clientes VALUES ('100000004', 'Travessa da Paz 3, Braga');
INSERT INTO Clientes VALUES ('100000005', 'Rua Nova 22, Coimbra');
INSERT INTO Clientes VALUES ('100000006', 'Av. do Mar 100, Faro');

--TRABALHADORES
INSERT INTO Trabalhadores VALUES ('200000001', 'Educadora de infância com 5 anos de experiência. Especializada em crianças dos 0-6 anos.');
INSERT INTO Trabalhadores VALUES ('200000002', 'Estudante de psicologia. Experiência em babysitting há 3 anos.');
INSERT INTO Trabalhadores VALUES ('200000003', 'Professora primária reformada. Excelente com crianças em idade escolar.');
INSERT INTO Trabalhadores VALUES ('200000004', 'Animador de festas infantis com 7 anos de experiência.');

--DISPONIBILIDADE
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000001', 'Segunda', TO_DATE('08:00','HH24:MI'), TO_DATE('18:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000001', 'Terca',   TO_DATE('08:00','HH24:MI'), TO_DATE('18:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000001', 'Quarta',  TO_DATE('08:00','HH24:MI'), TO_DATE('18:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000002', 'Quinta',  TO_DATE('14:00','HH24:MI'), TO_DATE('20:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000002', 'Sexta',   TO_DATE('14:00','HH24:MI'), TO_DATE('20:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000002', 'Sabado',  TO_DATE('10:00','HH24:MI'), TO_DATE('22:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000003', 'Segunda', TO_DATE('09:00','HH24:MI'), TO_DATE('17:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000003', 'Quarta',  TO_DATE('09:00','HH24:MI'), TO_DATE('17:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000003', 'Sexta',   TO_DATE('09:00','HH24:MI'), TO_DATE('17:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000004', 'Sabado',  TO_DATE('10:00','HH24:MI'), TO_DATE('22:00','HH24:MI'));
INSERT INTO Disponibilidade (nCC, dia_semana, hora_inicio, hora_fim) VALUES ('200000004', 'Domingo', TO_DATE('10:00','HH24:MI'), TO_DATE('22:00','HH24:MI'));

--CRIANCAS
INSERT INTO Criancas VALUES ('300000001', '100000001', TO_DATE('2018-03-10','YYYY-MM-DD'));
INSERT INTO Criancas VALUES ('300000002', '100000001', TO_DATE('2020-07-25','YYYY-MM-DD'));
INSERT INTO Criancas VALUES ('300000003', '100000002', TO_DATE('2017-11-05','YYYY-MM-DD'));
INSERT INTO Criancas VALUES ('300000004', '100000003', TO_DATE('2019-01-15','YYYY-MM-DD'));
INSERT INTO Criancas VALUES ('300000005', '100000004', TO_DATE('2021-06-30','YYYY-MM-DD'));

--TIPOS DE ALERGIA
INSERT INTO TiposAlergia VALUES ('Amendoim');
INSERT INTO TiposAlergia VALUES ('Lactose');
INSERT INTO TiposAlergia VALUES ('Gluten');
INSERT INTO TiposAlergia VALUES ('Marisco');
INSERT INTO TiposAlergia VALUES ('Ovo');
INSERT INTO TiposAlergia VALUES ('Soja');
INSERT INTO TiposAlergia VALUES ('Frutos secos');

-- ALERGIAS
INSERT INTO Alergias VALUES ('300000001', 'Amendoim');
INSERT INTO Alergias VALUES ('300000001', 'Lactose');
INSERT INTO Alergias VALUES ('300000002', 'Gluten');
INSERT INTO Alergias VALUES ('300000003', 'Ovo');
INSERT INTO Alergias VALUES ('300000004', 'Marisco');
INSERT INTO Alergias VALUES ('300000004', 'Frutos secos');
INSERT INTO Alergias VALUES ('300000005', 'Soja');

--SERVICOS
INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000001', TO_DATE('2024-01-10','YYYY-MM-DD'), 'Rua das Flores 10, Lisboa',
        TO_DATE('2024-01-10 09:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-01-10 17:00','YYYY-MM-DD HH24:MI'), 80.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000002', TO_DATE('2024-02-14','YYYY-MM-DD'), 'Av. da Liberdade 55, Porto',
        TO_DATE('2024-02-14 15:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-02-14 21:00','YYYY-MM-DD HH24:MI'), 150.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000003', TO_DATE('2024-03-05','YYYY-MM-DD'), 'Rua do Sol 8, Setubal',
        TO_DATE('2024-03-05 10:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-03-05 18:00','YYYY-MM-DD HH24:MI'), 200.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000004', TO_DATE('2024-03-20','YYYY-MM-DD'), 'Travessa da Paz 3, Braga',
        TO_DATE('2024-03-20 11:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-03-20 19:00','YYYY-MM-DD HH24:MI'), 180.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000005', TO_DATE('2024-04-12','YYYY-MM-DD'), 'Rua Nova 22, Coimbra',
        TO_DATE('2024-04-12 09:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-04-12 13:00','YYYY-MM-DD HH24:MI'), 60.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000001', TO_DATE('2024-05-01','YYYY-MM-DD'), 'Rua das Flores 10, Lisboa',
        TO_DATE('2024-05-01 14:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-05-01 20:00','YYYY-MM-DD HH24:MI'), 120.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000002', TO_DATE('2024-06-15','YYYY-MM-DD'), 'Salão Festas Porto, Porto',
        TO_DATE('2024-06-15 10:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-06-15 18:00','YYYY-MM-DD HH24:MI'), 350.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000003', TO_DATE('2024-07-20','YYYY-MM-DD'), 'Parque das Nacoes, Lisboa',
        TO_DATE('2024-07-20 09:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-07-20 17:00','YYYY-MM-DD HH24:MI'), 250.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000006', TO_DATE('2024-08-10','YYYY-MM-DD'), 'Av. do Mar 100, Faro',
        TO_DATE('2024-08-10 18:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-08-10 23:00','YYYY-MM-DD HH24:MI'), 90.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_fim, preco)
VALUES ('100000005', TO_DATE('2024-09-05','YYYY-MM-DD'), 'Centro Coimbra, Coimbra',
        TO_DATE('2024-09-05 10:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-05 16:00','YYYY-MM-DD HH24:MI'), 160.00);

--BABYSITTING
INSERT INTO Babysitting VALUES (1, TO_DATE('2024-01-10 21:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Babysitting VALUES (5, TO_DATE('2024-04-12 12:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Babysitting VALUES (6, TO_DATE('2024-05-01 19:00','YYYY-MM-DD HH24:MI'));
INSERT INTO Babysitting VALUES (9, TO_DATE('2024-08-10 22:00','YYYY-MM-DD HH24:MI'));

--FESTAS
INSERT INTO Festas VALUES (2, 'Super Herois');
INSERT INTO Festas VALUES (7, 'Princesas');

--EVENTOS
INSERT INTO Eventos VALUES (3,  'Piquenique');
INSERT INTO Eventos VALUES (4,  'Passeio ao Parque');
INSERT INTO Eventos VALUES (8,  'Visita ao Jardim Zoologico');
INSERT INTO Eventos VALUES (10, 'Dia de Jogos');

--INVENTARIO
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Baloes',          200);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Toalhas',          30);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Jogos de mesa',    15);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Fatos de heroi',   10);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Tiaras',           20);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Pinceis pintura',  50);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Tintas',           40);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Cestos piquenique', 8);

--PARTICIPAM
INSERT INTO Participam VALUES (1,  '300000001');
INSERT INTO Participam VALUES (1,  '300000002');
INSERT INTO Participam VALUES (2,  '300000003');
INSERT INTO Participam VALUES (3,  '300000004');
INSERT INTO Participam VALUES (4,  '300000005');
INSERT INTO Participam VALUES (5,  '300000001');
INSERT INTO Participam VALUES (6,  '300000002');
INSERT INTO Participam VALUES (7,  '300000003');
INSERT INTO Participam VALUES (8,  '300000004');
INSERT INTO Participam VALUES (9,  '300000005');
INSERT INTO Participam VALUES (10, '300000001');

-- TRABALHAM
INSERT INTO Trabalham VALUES ('200000001', 1,  60.00, 8.0);
INSERT INTO Trabalham VALUES ('200000002', 2,  90.00, 6.0);
INSERT INTO Trabalham VALUES ('200000003', 3, 100.00, 8.0);
INSERT INTO Trabalham VALUES ('200000004', 4,  80.00, 8.0);
INSERT INTO Trabalham VALUES ('200000001', 5,  40.00, 4.0);
INSERT INTO Trabalham VALUES ('200000002', 6,  70.00, 6.0);
INSERT INTO Trabalham VALUES ('200000004', 7, 150.00, 8.0);
INSERT INTO Trabalham VALUES ('200000003', 8, 120.00, 8.0);
INSERT INTO Trabalham VALUES ('200000001', 9,  50.00, 5.0);
INSERT INTO Trabalham VALUES ('200000002', 10, 80.00, 6.0);

-- UTILIZAM
INSERT INTO Utilizam VALUES (2,  1, 50);  -- Super Herois usa baloes
INSERT INTO Utilizam VALUES (2,  4, 5);   -- Super Herois usa fatos de heroi
INSERT INTO Utilizam VALUES (7,  1, 80);  -- Princesas usa baloes
INSERT INTO Utilizam VALUES (7,  5, 10);  -- Princesas usa tiaras
INSERT INTO Utilizam VALUES (3,  8, 3);   -- Piquenique usa cestos
INSERT INTO Utilizam VALUES (3,  2, 5);   -- Piquenique usa toalhas
INSERT INTO Utilizam VALUES (8,  6, 10);  -- Zoo usa pinceis
INSERT INTO Utilizam VALUES (8,  7, 8);   -- Zoo usa tintas
INSERT INTO Utilizam VALUES (10, 3, 5);   -- Jogos usa jogos de mesa

-- PAGAMENTO
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (1,  '100000001',  80.00, 'MBWay',        TO_DATE('2024-01-10','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (2,  '100000002', 150.00, 'Multibanco',    TO_DATE('2024-02-14','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (3,  '100000003', 200.00, 'Transferencia', TO_DATE('2024-03-05','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (4,  '100000004', 180.00, 'Numerario',     TO_DATE('2024-03-20','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (5,  '100000005',  60.00, 'MBWay',         TO_DATE('2024-04-12','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (6,  '100000001', 120.00, 'Multibanco',    TO_DATE('2024-05-01','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (7,  '100000002', 350.00, 'Transferencia', TO_DATE('2024-06-15','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (8,  '100000003', 250.00, 'Credito',       TO_DATE('2024-07-20','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (9,  '100000006',  90.00, 'MBWay',         TO_DATE('2024-08-10','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (10, '100000005', 160.00, 'Numerario',     TO_DATE('2024-09-05','YYYY-MM-DD'));

--AVALIACOES
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (1,  '100000001', 5, 'Excelente! A Filipa foi incrível com os meus filhos.',   TO_DATE('2024-01-11','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (2,  '100000002', 4, 'Festa muito bem organizada, as crianças adoraram.',       TO_DATE('2024-02-15','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (3,  '100000003', 5, 'Piquenique fantástico, muito bem preparado.',             TO_DATE('2024-03-06','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (4,  '100000004', 3, 'Bom serviço mas podia ter mais atividades.',              TO_DATE('2024-03-21','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (5,  '100000005', 5, 'Muito profissional e carinhosa com as crianças.',         TO_DATE('2024-04-13','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (6,  '100000001', 4, 'Bom serviço, voltaria a contratar.',                     TO_DATE('2024-05-02','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (7,  '100000002', 5, 'Festa de princesas perfeita! Superou as expectativas.',   TO_DATE('2024-06-16','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (8,  '100000003', 4, 'Visita ao zoo muito bem organizada.',                     TO_DATE('2024-07-21','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (9,  '100000006', 2, 'Serviço razoável, esperava mais.',                        TO_DATE('2024-08-11','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (10, '100000005', 5, 'Dia de jogos incrível, as crianças pediram para repetir!',TO_DATE('2024-09-06','YYYY-MM-DD'));

COMMIT;
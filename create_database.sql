-- ============================================================
-- DROP triggers
-- ============================================================
DROP TRIGGER trg_utilizam_stock;
DROP TRIGGER trg_trabalham_horas;
DROP TRIGGER trg_babysitting_hora_dormir;

-- ============================================================
-- DROP tables (ordem inversa das dependências)
-- ============================================================
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

-- ============================================================
-- CREATE tables
-- ============================================================
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
    nCC             VARCHAR2(20)    NOT NULL,
    dia_semana      VARCHAR2(15)    NOT NULL,
    hora_inicio     DATE            NOT NULL,
    hora_fim        DATE            NOT NULL,
    CONSTRAINT pk_disponibilidade PRIMARY KEY (nCC, dia_semana, hora_inicio),
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
    hora_final      DATE            NOT NULL,
    preco           NUMBER(10,2)    NOT NULL,
    CONSTRAINT pk_servicos PRIMARY KEY (id_servico),
    CONSTRAINT fk_servicos_clientes FOREIGN KEY (nCC) REFERENCES Clientes(nCC),
    CONSTRAINT ck_servicos_horas    CHECK (hora_final > hora_inicio),
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
    SELECT hora_inicio, hora_final
    INTO v_inicio, v_final
    FROM Servicos
    WHERE id_servico = :NEW.id_servico;

    IF :NEW.horas_dormir < v_inicio OR :NEW.horas_dormir > v_final THEN
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
    SELECT (hora_final - hora_inicio) * 24
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
-- ============================================================
-- Pessoas
-- ============================================================
INSERT INTO Pessoas VALUES ('111111111', 'Ana Silva');
INSERT INTO Pessoas VALUES ('222222222', 'Bruno Costa');
INSERT INTO Pessoas VALUES ('333333333', 'Carla Mendes');
INSERT INTO Pessoas VALUES ('444444444', 'David Ferreira');
INSERT INTO Pessoas VALUES ('555555555', 'Eva Rodrigues');
INSERT INTO Pessoas VALUES ('666666666', 'Miguel Lopes');  -- crianca
INSERT INTO Pessoas VALUES ('777777777', 'Sofia Martins'); -- crianca

-- ============================================================
-- Adultos
-- ============================================================
INSERT INTO Adultos VALUES ('111111111', 'ana.silva@email.com',    '910000001');
INSERT INTO Adultos VALUES ('222222222', 'bruno.costa@email.com',  '910000002');
INSERT INTO Adultos VALUES ('333333333', 'carla.mendes@email.com', '910000003');
INSERT INTO Adultos VALUES ('444444444', 'david.f@email.com',      '910000004');
INSERT INTO Adultos VALUES ('555555555', 'eva.rod@email.com',      '910000005');

-- ============================================================
-- Clientes
-- ============================================================
INSERT INTO Clientes VALUES ('111111111', 'Rua das Flores 1, Lisboa');
INSERT INTO Clientes VALUES ('222222222', 'Av. da Liberdade 200, Porto');
INSERT INTO Clientes VALUES ('333333333', 'Rua do Sol 45, Setubal');

-- ============================================================
-- Trabalhadores
-- ============================================================
INSERT INTO Trabalhadores VALUES ('444444444', 'Experiência em babysitting, 3 anos.');
INSERT INTO Trabalhadores VALUES ('555555555', 'Educadora de infância, 5 anos de experiência.');

-- ============================================================
-- Disponibilidade
-- ============================================================
INSERT INTO Disponibilidade VALUES ('444444444', 'Segunda',  TO_DATE('08:00','HH24:MI'), TO_DATE('18:00','HH24:MI'));
INSERT INTO Disponibilidade VALUES ('444444444', 'Quarta',   TO_DATE('08:00','HH24:MI'), TO_DATE('18:00','HH24:MI'));
INSERT INTO Disponibilidade VALUES ('555555555', 'Terca',    TO_DATE('09:00','HH24:MI'), TO_DATE('17:00','HH24:MI'));
INSERT INTO Disponibilidade VALUES ('555555555', 'Quinta',   TO_DATE('09:00','HH24:MI'), TO_DATE('17:00','HH24:MI'));

-- ============================================================
-- Criancas
-- ============================================================
INSERT INTO Criancas VALUES ('666666666', '111111111', TO_DATE('2018-03-15','YYYY-MM-DD'));
INSERT INTO Criancas VALUES ('777777777', '222222222', TO_DATE('2020-07-22','YYYY-MM-DD'));

-- ============================================================
-- TiposAlergia
-- ============================================================
INSERT INTO TiposAlergia VALUES ('Amendoim');
INSERT INTO TiposAlergia VALUES ('Lactose');
INSERT INTO TiposAlergia VALUES ('Gluten');
INSERT INTO TiposAlergia VALUES ('Marisco');

-- ============================================================
-- Alergias
-- ============================================================
INSERT INTO Alergias VALUES ('666666666', 'Amendoim');
INSERT INTO Alergias VALUES ('666666666', 'Lactose');
INSERT INTO Alergias VALUES ('777777777', 'Gluten');

-- ============================================================
-- Servicos
-- ============================================================
INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_final, preco)
VALUES ('111111111', TO_DATE('2024-06-01','YYYY-MM-DD'), 'Rua das Flores 1, Lisboa',
        TO_DATE('2024-06-01 09:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-06-01 18:00','YYYY-MM-DD HH24:MI'), 80.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_final, preco)
VALUES ('222222222', TO_DATE('2024-06-05','YYYY-MM-DD'), 'Av. da Liberdade 200, Porto',
        TO_DATE('2024-06-05 14:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-06-05 20:00','YYYY-MM-DD HH24:MI'), 120.00);

INSERT INTO Servicos (nCC, data, local, hora_inicio, hora_final, preco)
VALUES ('333333333', TO_DATE('2024-06-10','YYYY-MM-DD'), 'Rua do Sol 45, Setubal',
        TO_DATE('2024-06-10 10:00','YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-06-10 16:00','YYYY-MM-DD HH24:MI'), 150.00);

-- ============================================================
-- Babysitting (id_servico = 1)
-- ============================================================
INSERT INTO Babysitting VALUES (1, TO_DATE('2024-06-01 20:00','YYYY-MM-DD HH24:MI'));

-- ============================================================
-- Festas (id_servico = 3)
-- ============================================================
INSERT INTO Festas VALUES (3, 'Dinossauros');

-- ============================================================
-- Eventos (id_servico = 2)
-- ============================================================
INSERT INTO Eventos VALUES (2, 'Aniversário');

-- ============================================================
-- Inventario
-- ============================================================
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Baloes',      100);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Toalhas',      20);
INSERT INTO Inventario (nome_item, quantidade) VALUES ('Jogos de mesa', 10);

-- ============================================================
-- Participam
-- ============================================================
INSERT INTO Participam VALUES (1, '666666666');
INSERT INTO Participam VALUES (3, '777777777');

-- ============================================================
-- Trabalham
-- ============================================================
INSERT INTO Trabalham VALUES ('444444444', 1, 60.00, 9.0);
INSERT INTO Trabalham VALUES ('555555555', 3, 90.00, 6.0);

-- ============================================================
-- Utilizam
-- ============================================================
INSERT INTO Utilizam VALUES (3, 1, 30);  -- Festa usa 30 baloes
INSERT INTO Utilizam VALUES (3, 3,  2);  -- Festa usa 2 jogos de mesa

-- ============================================================
-- PagamentoCliente
-- ============================================================
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (1, '111111111', 80.00,  'MBWay',       TO_DATE('2024-06-01','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (2, '222222222', 120.00, 'Multibanco',   TO_DATE('2024-06-05','YYYY-MM-DD'));
INSERT INTO PagamentoCliente (id_servico, nCC, valor, metodo, data_pag)
VALUES (3, '333333333', 150.00, 'Transferencia',TO_DATE('2024-06-10','YYYY-MM-DD'));

-- ============================================================
-- Avaliacoes
-- ============================================================
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (1, '111111111', 5, 'Excelente serviço, muito profissional!', TO_DATE('2024-06-02','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (2, '222222222', 4, 'Muito bom, recomendo.', TO_DATE('2024-06-06','YYYY-MM-DD'));
INSERT INTO Avaliacoes (id_servico, nCC, classificacao, comentario, data_avaliacao)
VALUES (3, '333333333', 5, 'Festa incrível, as crianças adoraram!', TO_DATE('2024-06-11','YYYY-MM-DD'));

COMMIT;
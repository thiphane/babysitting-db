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
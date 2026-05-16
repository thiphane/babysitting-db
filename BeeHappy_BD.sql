-- ============================================================
-- DROP triggers
-- ============================================================
drop trigger trg_check_horas_dormir;
drop trigger trg_check_stock;
drop trigger trg_update_stock;

-- ============================================================
-- DROP tables 
-- ============================================================
drop table Utilizam cascade constraints;
drop table Trabalham cascade constraints;
drop table Participam cascade constraints;
drop table Avaliam cascade constraints;
drop table PagamentoCliente cascade constraints;
drop table Inventario cascade constraints;
drop table Alergias cascade constraints;
drop table Disponibilidade cascade constraints;
drop table Babysitting cascade constraints;
drop table Festas cascade constraints;
drop table Eventos cascade constraints;
drop table Servicos cascade constraints;
drop table Criancas cascade constraints;
drop table Clientes cascade constraints;
drop table Trabalhadores cascade constraints;
drop table Adultos cascade constraints;
drop table Pessoas cascade constraints;

-- ============================================================
-- CREATE tables
-- ============================================================
create table Pessoas (
	nCC number(9) not null,
	nome varchar2(100) not null,
	constraint pk_pessoas primary key (nCC)
);

create table Adultos (
	nCC_adulto number(9) not null,
	email varchar2(100) not null,
	num_telefone number(9) not null,
	constraint pk_adultos primary key (nCC_adulto),
	constraint fk_adultos_pessoas foreign key (nCC_adulto) 
    references Pessoas(nCC) on delete cascade
);

create table Trabalhadores (
	nCC_trabalhador number(9) not null,
	cv varchar2(1000) not null,
	constraint pk_trabalhadores primary key (nCC_trabalhador), 
	constraint fk_trabalhadores_adultos foreign key (nCC_trabalhador) 
    references Adultos(nCC_adulto) on delete cascade
);

create table Clientes (
	nCC_cliente number(9) not null,
	morada varchar2(100) not null,
	constraint pk_clientes primary key (nCC_cliente),
	constraint fk_clientes_adultos foreign key (nCC_cliente) 
    references Adultos(nCC_adulto) on delete cascade
);

create table Criancas (
	nCC_crianca number(9) not null,
	nCC_cliente number(9) not null,
	data_nascimento date not null,
	constraint pk_criancas primary key (nCC_crianca),
	constraint fk_criancas_pessoas foreign key (nCC_crianca) 
  	references Pessoas(nCC) on delete cascade,
	constraint fk_criancas_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente)
);

create table Servicos (
	id_servico number generated always as identity,
	nCC_cliente number(9) not null,
	data_servico date not null,
	local_servico varchar2(100) not null,
	hora_inicio date not null,
	hora_fim date not null,
	preco_servico number(4,2) not null,
	constraint pk_servicos primary key (id_servico),
	constraint fk_servicos_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente),
	constraint ck_servicos_horas check (hora_fim > hora_inicio),
	constraint ck_servicos_preco check (preco_servico > 0)
);

create table Eventos (
	id_evento number not null,
	tipo_evento varchar2(100) not null,
	constraint pk_eventos primary key (id_evento),
	constraint fk_eventos_servicos foreign key (id_evento) 
    references Servicos(id_servico) on delete cascade
);

create table Festas (
	id_festa number not null,
	tema_festa varchar2(100) not null,
	constraint pk_festas primary key (id_festa),
	constraint fk_festas_servicos foreign key (id_festa) 
    references Servicos(id_servico) on delete cascade
);

create table Babysitting (
	id_babysitting number not null,
	horas_dormir date not null,
	constraint pk_babysitting primary key (id_babysitting),
	constraint fk_babysitting_servicos foreign key (id_babysitting) 
    references Servicos(id_servico) on delete cascade 
);

create table Disponibilidade (
	id_disp number generated always as identity,
	nCC_trabalhador number(9) not null,
	dia_semana varchar2(10) not null,
	hora_inicio date not null,
	hora_fim date not null,
	constraint pk_disp primary key (id_disp),
	constraint fk_disp_trabalhadores foreign key (nCC_trabalhador) 
    references Trabalhadores(nCC_trabalhador),
	constraint ck_disp_horas check (hora_fim > hora_inicio),
	constraint ck_disp_dia check (dia_semana in ('Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'))
);

create table Alergias (
	nCC_crianca number(9) not null,
	alergia varchar2(100) not null,
	constraint pk_alergias primary key (nCC_crianca, alergia),
	constraint fk_alergias_criancas foreign key (nCC_crianca) 
    references Criancas(nCC_crianca)
);

create table Inventario (
	id_item number generated always as identity,
	nome_item varchar2(100) not null,
	quantidade number not null,
	constraint pk_inventario primary key (id_item)
);

create table PagamentoCliente (
	id_pagamento number generated always as identity,
	id_servico number not null,
	nCC_cliente number(9) not null,
	valor number not null,
	metodo varchar2(50) not null,
	data_pag date not null,
	constraint pk_pagamento primary key (id_pagamento),
	constraint fk_pagamento_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_pagamento_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente),
	constraint ck_pagamento_valor check (valor > 0),
	constraint ck_pagamento_metodo check (metodo in ('Multibanco', 'MBWay', 'Transferencia', 'Numerario'))
);

create table Avaliam (
	id_servico number not null,
	nCC_cliente number(9) not null,
	classificacao number(1) not null,
	comentario varchar2(500),
	data_avaliacao date not null,
	constraint pk_alvaliam primary key (id_servico, nCC_cliente),
	constraint fk_avaliam_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_avaliam_clientes foreign key (nCC_cliente)     
    references Clientes(nCC_cliente),
	constraint ck_avaliam_classificacao check (classificacao between 1 and 5)
); 

create table Participam (
	id_servico number not null,
	nCC_crianca number(9) not null,
	constraint pk_participam primary key (id_servico, nCC_crianca),
	constraint fk_participam_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_participam_criancas foreign key (nCC_crianca) 
    references Criancas(nCC_crianca)
);

create table Trabalham (
	nCC_trabalhador number(9) not null,
	id_servico number not null,
	valor_recebido number not null,
	constraint pk_trabalham primary key (nCC_trabalhador, id_servico),
	constraint fk_trabalham_trabalhadores foreign key (nCC_trabalhador) 
    references Trabalhadores(nCC_trabalhador),
	constraint fk_trabalham_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint ck_trabalham_valor check (valor_recebido > 0)
);

create table Utilizam (
	id_servico number not null,
	id_item number not null,
	quantidade_gasta number not null,
	constraint pk_utilizam primary key (id_servico, id_item),
	constraint fk_utilizam_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_utilizam_inventario foreign key (id_item) 
    references Inventario(id_item),
	constraint ck_utilizam_quantidade check (quantidade_gasta > 0)
);

-- ============================================================
-- CREATE triggers
-- ============================================================
create or replace trigger trg_check_horas_dormir
before insert or update on Babysitting
for each row
declare
	v_inicio date;
	v_fim date;
begin
	select hora_inicio, hora_fim 
	into v_inicio, v_fim
	from Servicos
	where id_servico = :new.id_babysitting;
	
	if :new.horas_dormir < v_inicio or :new.horas_dormir > v_fim then
		raise_application_error(-20001, 'Horas de dormir devem estar dentro do horário do serviço.');
	end if;
end;
/

create or replace trigger trg_check_stock
before insert or update on Utilizam
for each row
declare
	v_stock number;
begin
	select quantidade into v_stock 
	from Inventario
	where id_item = :new.id_item;
	
	if :new.quantidade_gasta > v_stock then
		raise_application_error(-20002, 'Quantidade gasta excede o stock disponível.');
	end if;
end;
/

create or replace trigger trg_update_stock
after insert on Utilizam
for each row
begin
	update Inventario
	set quantidade = quantidade - :new.quantidade_gasta
	where id_item = :new.id_item;
end;
/
-- CREATE views
create or replace view vw_clientes_form as
select
    p.nCC,
    p.nome,
    a.email,
    a.num_telefone,
    c.morada
from Pessoas p
join Adultos  a on a.nCC_adulto   = p.nCC
join Clientes c on c.nCC_cliente  = a.nCC_adulto;

create or replace view vw_trabalhadores_form as
select
    p.nCC,
    p.nome,
    a.email,
    a.num_telefone,
    t.cv
from Pessoas p
join Adultos       a on a.nCC_adulto       = p.nCC
join Trabalhadores t on t.nCC_trabalhador  = a.nCC_adulto;

create or replace view vw_criancas_form as
select
    p.nCC,
    p.nome,
    c.nCC_cliente,
    c.data_nascimento
from Pessoas p
join Criancas c on c.nCC_crianca = p.nCC;


-- CREATE triggers das views (INSTEAD OF INSERT)
create or replace trigger trg_instead_of_insert_cliente
instead of insert on vw_clientes_form
for each row
begin
    insert into Pessoas (nCC, nome)
    values (:new.nCC, :new.nome);

    insert into Adultos (nCC_adulto, email, num_telefone)
    values (:new.nCC, :new.email, :new.num_telefone);

    insert into Clientes (nCC_cliente, morada)
    values (:new.nCC, :new.morada);
end;
/

create or replace trigger trg_instead_of_insert_trabalhador
instead of insert on vw_trabalhadores_form
for each row
begin
    insert into Pessoas (nCC, nome)
    values (:new.nCC, :new.nome);

    insert into Adultos (nCC_adulto, email, num_telefone)
    values (:new.nCC, :new.email, :new.num_telefone);

    insert into Trabalhadores (nCC_trabalhador, cv)
    values (:new.nCC, :new.cv);
end;
/

create or replace trigger trg_instead_of_insert_crianca
instead of insert on vw_criancas_form
for each row
begin
    insert into Pessoas (nCC, nome)
    values (:new.nCC, :new.nome);

    insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento)
    values (:new.nCC, :new.nCC_cliente, :new.data_nascimento);
end;
/

-- CREATE triggers das views (INSTEAD OF UPDATE)
create or replace trigger trg_instead_of_update_cliente
instead of update on vw_clientes_form
for each row
begin
    update Pessoas set nome = :new.nome where nCC = :old.nCC;
    update Adultos set email = :new.email, num_telefone = :new.num_telefone where nCC_adulto = :old.nCC;
    update Clientes set morada = :new.morada where nCC_cliente = :old.nCC;
end;
/

create or replace trigger trg_instead_of_update_trabalhador
instead of update on vw_trabalhadores_form
for each row
begin
    update Pessoas set nome = :new.nome where nCC = :old.nCC;
    update Adultos set email = :new.email, num_telefone = :new.num_telefone where nCC_adulto = :old.nCC;
    update Trabalhadores set cv = :new.cv where nCC_trabalhador = :old.nCC;
end;
/

create or replace trigger trg_instead_of_update_crianca
instead of update on vw_criancas_form
for each row
begin
    update Pessoas set nome = :new.nome where nCC = :old.nCC;
    update Criancas set nCC_cliente = :new.nCC_cliente, data_nascimento = :new.data_nascimento where nCC_crianca = :old.nCC;
end;
/

commit;-- ============================================================
-- DROP triggers
-- ============================================================
drop trigger trg_check_horas_dormir;
drop trigger trg_check_stock;
drop trigger trg_updatde_stock;

-- ============================================================
-- DROP tables 
-- ============================================================
drop table Utilizam cascade constraints;
drop table Trabalham cascade constraints;
drop table Participam cascade constraints;
drop table Avaliam cascade constraints;
drop table PagamentoCliente cascade constraints;
drop table Inventario cascade constraints;
drop table Alergias cascade constraints;
drop table Disponibilidade cascade constraints;
drop table Babysitting cascade constraints;
drop table Festas cascade constraints;
drop table Eventos cascade constraints;
drop table Servicos cascade constraints;
drop table Criancas cascade constraints;
drop table Clientes cascade constraints;
drop table Trabalhadores cascade constraints;
drop table Adultos cascade constraints;
drop table Pessoas cascade constraints;

-- ============================================================
-- CREATE tables
-- ============================================================
create table Pessoas (
	nCC number(9) not null,
	nome varchar2(100) not null,
	constraint pk_pessoas primary key (nCC)
);

create table Adultos (
	nCC_adulto number(9) not null,
	email varchar2(100) not null,
	num_telefone number(9) not null,
	constraint pk_adultos primary key (nCC_adulto),
	constraint fk_adultos_pessoas foreign key (nCC_adulto) 
    references Pessoas(nCC) on delete cascade
);

create table Trabalhadores (
	nCC_trabalhador number(9) not null,
	cv varchar2(1000) not null,
	constraint pk_trabalhadores primary key (nCC_trabalhador), 
	constraint fk_trabalhadores_adultos foreign key (nCC_trabalhador) 
    references Adultos(nCC_adulto) on delete cascade
);

create table Clientes (
	nCC_cliente number(9) not null,
	morada varchar2(100) not null,
	constraint pk_clientes primary key (nCC_cliente),
	constraint fk_clientes_adultos foreign key (nCC_cliente) 
    references Adultos(nCC_adulto) on delete cascade
);

create table Criancas (
	nCC_crianca number(9) not null,
	nCC_cliente number(9) not null,
	data_nascimento date not null,
	constraint pk_criancas primary key (nCC_crianca),
	constraint fk_criancas_pessoas foreign key (nCC_crianca) 
  	references Pessoas(nCC) on delete cascade,
	constraint fk_criancas_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente)
);

create table Servicos (
	id_servico number generated always as identity,
	nCC_cliente number(9) not null,
	data_servico date not null,
	local_servico varchar2(100) not null,
	hora_inicio date not null,
	hora_fim date not null,
	preco_servico number(4,2) not null,
	constraint pk_servicos primary key (id_servico),
	constraint fk_servicos_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente),
	constraint ck_servicos_horas check (hora_fim > hora_inicio),
	constraint ck_servicos_preco check (preco_servico > 0)
);

create table Eventos (
	id_evento number not null,
	tipo_evento varchar2(100) not null,
	constraint pk_eventos primary key (id_evento),
	constraint fk_eventos_servicos foreign key (id_evento) 
    references Servicos(id_servico) on delete cascade
);

create table Festas (
	id_festa number not null,
	tema_festa varchar2(100) not null,
	constraint pk_festas primary key (id_festa),
	constraint fk_festas_servicos foreign key (id_festa) 
    references Servicos(id_servico) on delete cascade
);

create table Babysitting (
	id_babysitting number not null,
	horas_dormir date not null,
	constraint pk_babysitting primary key (id_babysitting),
	constraint fk_babysitting_servicos foreign key (id_babysitting) 
    references Servicos(id_servico) on delete cascade 
);

create table Disponibilidade (
	id_disp number generated always as identity,
	nCC_trabalhador number(9) not null,
	dia_semana varchar2(10) not null,
	hora_inicio date not null,
	hora_fim date not null,
	constraint pk_disp primary key (id_disp),
	constraint fk_disp_trabalhadores foreign key (nCC_trabalhador) 
    references Trabalhadores(nCC_trabalhador),
	constraint ck_disp_horas check (hora_fim > hora_inicio),
	constraint ck_disp_dia check (dia_semana in ('Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'))
);

create table Alergias (
	nCC_crianca number(9) not null,
	alergia varchar2(100) not null,
	constraint pk_alergias primary key (nCC_crianca, alergia),
	constraint fk_alergias_criancas foreign key (nCC_crianca) 
    references Criancas(nCC_crianca)
);

create table Inventario (
	id_item number generated always as identity,
	nome_item varchar2(100) not null,
	quantidade number not null,
	constraint pk_inventario primary key (id_item)
);

create table PagamentoCliente (
	id_pagamento number generated always as identity,
	id_servico number not null,
	nCC_cliente number(9) not null,
	valor number not null,
	metodo varchar2(50) not null,
	data_pag date not null,
	constraint pk_pagamento primary key (id_pagamento),
	constraint fk_pagamento_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_pagamento_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente),
	constraint ck_pagamento_valor check (valor > 0),
	constraint ck_pagamento_metodo check (metodo in ('Multibanco', 'MBWay', 'Transferencia', 'Numerario'))
);

create table Avaliam (
	id_servico number not null,
	nCC_cliente number(9) not null,
	classificacao number(1) not null,
	comentario varchar2(500),
	data_avaliacao date not null,
	constraint pk_alvaliam primary key (id_servico, nCC_cliente),
	constraint fk_avaliam_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_avaliam_clientes foreign key (nCC_cliente)     
    references Clientes(nCC_cliente),
	constraint ck_avaliam_classificacao check (classificacao between 1 and 5)
); 

create table Participam (
	id_servico number not null,
	nCC_crianca number(9) not null,
	constraint pk_participam primary key (id_servico, nCC_crianca),
	constraint fk_participam_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_participam_criancas foreign key (nCC_crianca) 
    references Criancas(nCC_crianca)
);

create table Trabalham (
	nCC_trabalhador number(9) not null,
	id_servico number not null,
	valor_recebido number not null,
	constraint pk_trabalham primary key (nCC_trabalhador, id_servico),
	constraint fk_trabalham_trabalhadores foreign key (nCC_trabalhador) 
    references Trabalhadores(nCC_trabalhador),
	constraint fk_trabalham_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint ck_trabalham_valor check (valor_recebido > 0)
);

create table Utilizam (
	id_servico number not null,
	id_item number not null,
	quantidade_gasta number not null,
	constraint pk_utilizam primary key (id_servico, id_item),
	constraint fk_utilizam_servicos foreign key (id_servico) 
    references Servicos(id_servico),
	constraint fk_utilizam_inventario foreign key (id_item) 
    references Inventario(id_item),
	constraint ck_utilizam_quantidade check (quantidade_gasta > 0)
);

-- ============================================================
-- CREATE triggers
-- ============================================================
create or replace trigger trg_check_horas_dormir
before insert or update on Babysitting
for each row
declare
	v_inicio date;
	v_fim date;
begin
	select hora_inicio, hora_fim 
	into v_inicio, v_fim
	from Servicos
	where id_servico = :new.id_babysitting;
	
	if :new.horas_dormir < v_inicio or :new.horas_dormir > v_fim then
		raise_application_error(-20001, 'Horas de dormir devem estar dentro do horário do serviço.');
	end if;
end;
/

create or replace trigger trg_utilizam_stock
before insert or update on Utilizam
for each row
declare
	v_stock number;
begin
	select quantidade into v_stock 
	from Inventario
	where id_item = :new.id_item;
	
	if :new.quantidade_gasta > v_stock then
		raise_application_error(-20002, 'Quantidade gasta excede o stock disponível.');
	end if;
end;
/

create or replace trigger trg_updatde_stock
after insert on Utilizam
for each row
begin
	update Inventario
	set quantidade = quantidade - :new.quantidade_gasta
	where id_item = :new.id_item;
end;
/
-- CREATE views
create or replace view vw_clientes_form as
select
    p.nCC,
    p.nome,
    a.email,
    a.num_telefone,
    c.morada
from Pessoas p
join Adultos  a on a.nCC_adulto   = p.nCC
join Clientes c on c.nCC_cliente  = a.nCC_adulto;

create or replace view vw_trabalhadores_form as
select
    p.nCC,
    p.nome,
    a.email,
    a.num_telefone,
    t.cv
from Pessoas p
join Adultos       a on a.nCC_adulto       = p.nCC
join Trabalhadores t on t.nCC_trabalhador  = a.nCC_adulto;

create or replace view vw_criancas_form as
select
    p.nCC,
    p.nome,
    c.nCC_cliente,
    c.data_nascimento
from Pessoas p
join Criancas c on c.nCC_crianca = p.nCC;


-- CREATE triggers das views (INSTEAD OF INSERT)
create or replace trigger trg_instead_of_insert_cliente
instead of insert on vw_clientes_form
for each row
begin
    insert into Pessoas (nCC, nome)
    values (:new.nCC, :new.nome);

    insert into Adultos (nCC_adulto, email, num_telefone)
    values (:new.nCC, :new.email, :new.num_telefone);

    insert into Clientes (nCC_cliente, morada)
    values (:new.nCC, :new.morada);
end;
/

create or replace trigger trg_instead_of_insert_trabalhador
instead of insert on vw_trabalhadores_form
for each row
begin
    insert into Pessoas (nCC, nome)
    values (:new.nCC, :new.nome);

    insert into Adultos (nCC_adulto, email, num_telefone)
    values (:new.nCC, :new.email, :new.num_telefone);

    insert into Trabalhadores (nCC_trabalhador, cv)
    values (:new.nCC, :new.cv);
end;
/

create or replace trigger trg_instead_of_insert_crianca
instead of insert on vw_criancas_form
for each row
begin
    insert into Pessoas (nCC, nome)
    values (:new.nCC, :new.nome);

    insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento)
    values (:new.nCC, :new.nCC_cliente, :new.data_nascimento);
end;
/

-- CREATE triggers das views (INSTEAD OF UPDATE)
create or replace trigger trg_instead_of_update_cliente
instead of update on vw_clientes_form
for each row
begin
    update Pessoas set nome = :new.nome where nCC = :old.nCC;
    update Adultos set email = :new.email, num_telefone = :new.num_telefone where nCC_adulto = :old.nCC;
    update Clientes set morada = :new.morada where nCC_cliente = :old.nCC;
end;
/

create or replace trigger trg_instead_of_update_trabalhador
instead of update on vw_trabalhadores_form
for each row
begin
    update Pessoas set nome = :new.nome where nCC = :old.nCC;
    update Adultos set email = :new.email, num_telefone = :new.num_telefone where nCC_adulto = :old.nCC;
    update Trabalhadores set cv = :new.cv where nCC_trabalhador = :old.nCC;
end;
/

create or replace trigger trg_instead_of_update_crianca
instead of update on vw_criancas_form
for each row
begin
    update Pessoas set nome = :new.nome where nCC = :old.nCC;
    update Criancas set nCC_cliente = :new.nCC_cliente, data_nascimento = :new.data_nascimento where nCC_crianca = :old.nCC;
end;
/

commit;

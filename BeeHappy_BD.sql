-- ==============
-- DROP triggers
-- ==============
drop trigger trg_check_horas_dormir;
drop trigger trg_check_stock;
drop trigger trg_update_stock;
drop trigger trg_check_valid_payment;
drop trigger trg_check_sobreposicao_trabalhador;
drop trigger trg_check_data_avaliacao;
drop trigger trg_check_disponibilidade;
drop trigger trg_check_idade;
drop trigger trg_instead_of_insert_or_update_cliente;
drop trigger trg_instead_of_insert_or_update_trabalhador;
drop trigger trg_instead_of_insert_or_update_crianca;
drop trigger trg_instead_of_insert_or_update_babysitting;
drop trigger trg_instead_of_insert_or_update_evento;
drop trigger trg_instead_of_insert_or_update_festa;
drop view vw_clientes_form;
drop view vw_trabalhadores_form;
drop view vw_criancas_form;
drop view vw_eventos;
drop view vw_festas;
drop view vw_babysitting;

-- ============
-- DROP tables
-- ============
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

-- ==============
-- CREATE tables
-- ==============
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
    references Pessoas(nCC) on delete cascade,
	constraint uq_email unique (email),
	constraint uq_num_telefone unique (num_telefone)
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
    references Clientes(nCC_cliente) on delete cascade
);

create table Servicos (
	id_servico number generated always as identity,
	nCC_cliente number(9) not null,
	data_servico date not null,
	local_servico varchar2(100) not null,
	hora_inicio date not null,
	hora_fim date not null,
	preco_servico number(5,2) not null,
	constraint pk_servicos primary key (id_servico),
	constraint fk_servicos_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente) on delete cascade,
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
    references Trabalhadores(nCC_trabalhador) on delete cascade,
	constraint ck_disp_horas check (hora_fim > hora_inicio),
	constraint ck_disp_dia check (dia_semana in ('Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'))
);

create table Alergias (
	nCC_crianca number(9) not null,
	alergia varchar2(100) not null,
	constraint pk_alergias primary key (nCC_crianca, alergia),
	constraint fk_alergias_criancas foreign key (nCC_crianca) 
    references Criancas(nCC_crianca) on delete cascade 
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
    references Servicos(id_servico) on delete cascade,
	constraint fk_pagamento_clientes foreign key (nCC_cliente) 
    references Clientes(nCC_cliente) on delete cascade,
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
    references Servicos(id_servico) on delete cascade,
	constraint fk_avaliam_clientes foreign key (nCC_cliente)     
    references Clientes(nCC_cliente) on delete cascade,
	constraint ck_avaliam_classificacao check (classificacao between 1 and 5)
); 

create table Participam (
	id_servico number not null,
	nCC_crianca number(9) not null,
	constraint pk_participam primary key (id_servico, nCC_crianca),
	constraint fk_participam_servicos foreign key (id_servico) 
    references Servicos(id_servico) on delete cascade,
	constraint fk_participam_criancas foreign key (nCC_crianca) 
    references Criancas(nCC_crianca) on delete cascade
);

create table Trabalham (
	nCC_trabalhador number(9) not null,
	id_servico number not null,
	valor_recebido number not null,
	constraint pk_trabalham primary key (nCC_trabalhador, id_servico),
	constraint fk_trabalham_trabalhadores foreign key (nCC_trabalhador) 
    references Trabalhadores(nCC_trabalhador) on delete cascade,
	constraint fk_trabalham_servicos foreign key (id_servico) 
    references Servicos(id_servico) on delete cascade,
	constraint ck_trabalham_valor check (valor_recebido > 0)
);

create table Utilizam (
	id_servico number not null,
	id_item number not null,
	quantidade_gasta number not null,
	constraint pk_utilizam primary key (id_servico, id_item),
	constraint fk_utilizam_servicos foreign key (id_servico) 
    references Servicos(id_servico) on delete cascade,
	constraint fk_utilizam_inventario foreign key (id_item) 
    references Inventario(id_item) on delete cascade,
	constraint ck_utilizam_quantidade check (quantidade_gasta > 0)
);

-- =============
-- CREATE views
-- =============

-- view para clientes
create or replace view vw_clientes_form as
select
	p.nCC,
	p.nome,
	a.email,
	a.num_telefone,
	c.morada
from Pessoas p
join Adultos a on a.nCC_adulto = p.nCC
join Clientes c on c.nCC_cliente = a.nCC_adulto;

-- view para trabalhadores
create or replace view vw_trabalhadores_form as
select
	p.nCC,
	p.nome,
	a.email,
	a.num_telefone,
	t.cv
from Pessoas p
join Adultos a on a.nCC_adulto = p.nCC
join Trabalhadores t on t.nCC_trabalhador = a.nCC_adulto;

-- view para crianças 
create or replace view vw_criancas_form as
select
	p.nCC,
	p.nome,
	c.nCC_cliente,
	c.data_nascimento
from Pessoas p
join Criancas c on c.nCC_crianca = p.nCC;

-- view para eventos
create or replace view vw_eventos as 
select 
  s.id_servico,
  s.nCC_cliente, 
  s.data_servico, 
  s.local_servico, 
  s.hora_inicio, 
  s.hora_fim, 
  s.preco_servico, 
  e.tipo_evento
from servicos s
join eventos e on s.id_servico = e.id_evento;

-- view para festas
create or replace view vw_festas as
select 
  s.id_servico,
  s.nCC_cliente, 
  s.data_servico, 
  s.local_servico, 
  s.hora_inicio, 
  s.hora_fim, 
  s.preco_servico, 
  f.tema_festa
from servicos s
join festas f on s.id_servico = f.id_festa;

-- views para babysitting
create or replace view vw_babysitting as
select 
  s.id_servico,
  s.nCC_cliente, 
  s.data_servico, 
  s.local_servico, 
  s.hora_inicio, 
  s.hora_fim, 
  s.preco_servico, 
  b.horas_dormir
from servicos s
join babysitting b on s.id_servico = b.id_babysitting;

-- ================
-- CREATE triggers
-- ================

-- trigger para verificar se as horas de dormir estão dentro do horário do serviço
create or replace trigger trg_check_horas_dormir
before insert on Babysitting
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
		raise_application_error(-20001, 'Erro: as horas de dormir devem estar contidas no horário do serviço.');
	end if;
end;
/

-- trigger para verificar se a quantidade gasta é menor ou igual ao stock disponível
create or replace trigger trg_check_stock
before insert on Utilizam
for each row
declare
	v_stock number;
begin
	select quantidade into v_stock 
	from Inventario
	where id_item = :new.id_item;
	if :new.quantidade_gasta > v_stock then
		raise_application_error(-20002, 'Erro: a quantidade gasta excede o stock disponível.');
	end if;
end;
/

-- trigger para atualizar o stock no inventário
create or replace trigger trg_update_stock
after insert on Utilizam
for each row
begin
	update Inventario
	set quantidade = quantidade - :new.quantidade_gasta
	where id_item = :new.id_item;
end;
/

-- trigger para verificar se os pagamentos são validos 
create or replace trigger trg_check_valid_payment
before insert on PagamentoCliente
for each row
declare
	v_preco_servico number(5,2);
	v_id_servico number := :new.id_servico;
begin
	select preco_servico into v_preco_servico
	from Servicos
	where id_servico = v_id_servico;
	if :new.valor != v_preco_servico then	
		raise_application_error(-20003, 'Erro: o valor do pagamento não corresponde ao preço do serviço.');
	end if;
end;
/

-- trigger para nao ter trabalhadores em serviços sobrepostos 
create or replace trigger trg_check_sobreposicao_trabalhador
before insert or update on Trabalham
for each row
declare
  pragma autonomous_transaction;
  v_inicio_novo date;
  v_fim_novo date;
  v_conflitos number;
begin
  select hora_inicio, hora_fim into v_inicio_novo, v_fim_novo
  from Servicos
  where id_servico = :new.id_servico;
  
  select count(*) into v_conflitos
  from Trabalham t
  join Servicos s on t.id_servico = s.id_servico
  where t.nCC_trabalhador = :new.nCC_trabalhador               
    and t.id_servico <> :new.id_servico
    and s.hora_inicio < v_fim_novo
    and s.hora_fim > v_inicio_novo;  
    
  if v_conflitos > 0 then
    raise_application_error(-20004, 'Erro: este trabalhador já tem outro serviço agendado para o mesmo horário.');
  end if;
  commit;
end;
/

-- trigger para serviços nao serem avaliados antes de serem realizados
create or replace trigger trg_check_data_avaliacao
before insert or update on Avaliam
for each row
declare
  v_hora_fim_servico date;
begin
  select hora_fim into v_hora_fim_servico
  from servicos
  where id_servico = :new.id_servico;
  if :new.data_avaliacao < v_hora_fim_servico then
    raise_application_error(-20005, 'Erro: a avaliação só pode ser registada após o serviço terminar.');
  end if;
end;
/

-- trigger para garantir que um trabalhador só pode ser atribuido a um serviço se tiver disponibilidade
create or replace trigger trg_check_disponibilidade
before insert or update on Trabalham
for each row
declare
  v_data_servico date;
  v_h_serv_inicio varchar2(5);
  v_h_serv_fim varchar2(5);
  v_dia_semana varchar2(20);
  v_existe number;
begin
  select data_servico, to_char(hora_inicio, 'HH24:MI'), to_char(hora_fim, 'HH24:MI')
  into v_data_servico, v_h_serv_inicio, v_h_serv_fim
  from Servicos
  where id_servico = :new.id_servico;
  
  v_dia_semana := to_char(v_data_servico, 'FmDay', 'NLS_DATE_LANGUAGE=PORTUGUESE');
  v_dia_semana := replace(replace(v_dia_semana, 'ç', 'c'), 'á', 'a');
  
  select count(*) into v_existe
  from Disponibilidade
  where nCC_trabalhador = :new.nCC_trabalhador
    and dia_semana = v_dia_semana
    and to_char(hora_inicio, 'HH24:MI') <= v_h_serv_inicio
    and to_char(hora_fim, 'HH24:MI') >= v_h_serv_fim;
    
  if v_existe = 0 then
    raise_application_error(-20006, 'Erro: O trabalhador não tem disponibilidade para o dia ou horário deste serviço.');
  end if;
end;
/

-- trigger para garantir que a idade da criança é válida
create or replace trigger trg_check_idade
before insert or update on Criancas
for each row
declare
  v_idade number;
begin
  if :new.data_nascimento > sysdate then
    raise_application_error(-20008, 'Erro: A data de nascimento não pode ser no futuro.');
  end if;

  v_idade := trunc(months_between(sysdate, :new.data_nascimento) / 12);
  if v_idade >= 18 then
    raise_application_error(-20007, 'Erro: A pessoa registada tem 18 anos ou mais e não pode ser inserida como criança.');
  end if;
end;
/

-- trigger para garantir que ao inserir ou atualizar um cliente o mesmo é inserido na tabela Pessoas e Adultos
create or replace trigger trg_instead_of_insert_or_update_cliente
instead of insert or update on vw_clientes_form
for each row
begin
	if inserting then
		insert into Pessoas (nCC, nome)
		values (:new.nCC, :new.nome);
		insert into Adultos (nCC_adulto, email, num_telefone)
		values (:new.nCC, :new.email, :new.num_telefone);
		insert into Clientes (nCC_cliente, morada)
		values (:new.nCC, :new.morada);
	elsif updating then
		update Pessoas set nome = :new.nome where nCC = :old.nCC;
		update Adultos set email = :new.email, num_telefone = :new.num_telefone where nCC_adulto = :old.nCC;
		update Clientes set morada = :new.morada where nCC_cliente = :old.nCC;
	end if;
end;
/

-- trigger para garantir que ao inserir ou atualizar um trabalhador o mesmo é inserido na tabela Pessoas e Adultos
create or replace trigger trg_instead_of_insert_or_update_trabalhador
instead of insert or update on vw_trabalhadores_form
for each row
begin
	if inserting then
		insert into Pessoas (nCC, nome)
		values (:new.nCC, :new.nome);
		insert into Adultos (nCC_adulto, email, num_telefone)
		values (:new.nCC, :new.email, :new.num_telefone);
		insert into Trabalhadores (nCC_trabalhador, cv)
		values (:new.nCC, :new.cv);
	elsif updating then
		update Pessoas set nome = :new.nome where nCC = :old.nCC;
		update Adultos set email = :new.email, num_telefone = :new.num_telefone where nCC_adulto = :old.nCC;
		update Trabalhadores set cv = :new.cv where nCC_trabalhador = :old.nCC;
	end if;
end;
/

-- trigger para garantir que ao inserir ou atualizar uma criança a mesma é inserida na tabela Pessoas
create or replace trigger trg_instead_of_insert_or_update_crianca
instead of insert or update on vw_criancas_form
for each row
begin
	if inserting then
		insert into Pessoas (nCC, nome)
		values (:new.nCC, :new.nome);
		insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento)
		values (:new.nCC, :new.nCC_cliente, :new.data_nascimento);
	elsif updating then
		update Pessoas set nome = :new.nome where nCC = :old.nCC;
		update Criancas set nCC_cliente = :new.nCC_cliente, data_nascimento = :new.data_nascimento where nCC_crianca = :old.nCC;
	end if;
end;
/

-- trigger para babysitting
create or replace trigger trg_instead_of_insert_or_update_babysitting
instead of insert or update on vw_babysitting
for each row
declare
  v_novo_id number;
begin
  if inserting then
    insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico)
    values (:new.nCC_cliente, :new.data_servico, :new.local_servico, :new.hora_inicio, :new.hora_fim, :new.preco_servico)
    returning id_servico into v_novo_id;
    
    insert into Babysitting (id_babysitting, horas_dormir)
    values (v_novo_id, :new.horas_dormir);
  elsif updating then
    update Servicos 
    set nCC_cliente = :new.nCC_cliente, data_servico = :new.data_servico, local_servico = :new.local_servico, hora_inicio = :new.hora_inicio, hora_fim = :new.hora_fim, preco_servico = :new.preco_servico 
    where id_servico = :old.id_servico;
    
    update Babysitting 
    set horas_dormir = :new.horas_dormir 
    where id_babysitting = :old.id_servico;
  end if;
end;
/

-- trigger para evento
create or replace trigger trg_instead_of_insert_or_update_evento
instead of insert or update on vw_eventos
for each row
declare
  v_novo_id number;
begin
  if inserting then
    insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico)
    values (:new.nCC_cliente, :new.data_servico, :new.local_servico, :new.hora_inicio, :new.hora_fim, :new.preco_servico)
    returning id_servico into v_novo_id;
    
    insert into Eventos (id_evento, tipo_evento)
    values (v_novo_id, :new.tipo_evento);
  elsif updating then
    update Servicos 
    set nCC_cliente = :new.nCC_cliente, data_servico = :new.data_servico, local_servico = :new.local_servico, hora_inicio = :new.hora_inicio, hora_fim = :new.hora_fim, preco_servico = :new.preco_servico 
    where id_servico = :old.id_servico;
    
    update Eventos 
    set tipo_evento = :new.tipo_evento 
    where id_evento = :old.id_servico;
  end if;
end;
/

-- trigger para festa
create or replace trigger trg_instead_of_insert_or_update_festa
instead of insert or update on vw_festas
for each row
declare
  v_novo_id number;
begin
  if inserting then
    insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico)
    values (:new.nCC_cliente, :new.data_servico, :new.local_servico, :new.hora_inicio, :new.hora_fim, :new.preco_servico)
    returning id_servico into v_novo_id;
    
    insert into Festas (id_festa, tema_festa)
    values (v_novo_id, :new.tema_festa);
  elsif updating then
    update Servicos 
    set nCC_cliente = :new.nCC_cliente, data_servico = :new.data_servico, local_servico = :new.local_servico, hora_inicio = :new.hora_inicio, hora_fim = :new.hora_fim, preco_servico = :new.preco_servico 
    where id_servico = :old.id_servico;
    
    update Festas 
    set tema_festa = :new.tema_festa 
    where id_festa = :old.id_servico;
  end if;
end;
/

commit;

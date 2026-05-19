-- =============================================================================
-- DROPS
-- =============================================================================

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

drop table Podem_ter cascade constraints;
drop table Utilizam cascade constraints;
drop table Trabalham cascade constraints;
drop table Participam cascade constraints;
drop table Avaliam cascade constraints;
drop table Pagamentocliente cascade constraints;
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

-- =============================================================================
-- CREATE TABLES
-- =============================================================================

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
  alergia varchar2(100) not null,
  constraint pk_alergias primary key (alergia)
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

create table Podem_ter (
  nCC_crianca_alergia number(9) not null,
  alergia_crianca varchar2(100) not null,
  constraint pk_podem_ter primary key (nCC_crianca_alergia, alergia_crianca),
  constraint fk_podem_ter_criancas foreign key (nCC_crianca_alergia) 
    references Criancas(nCC_crianca) on delete cascade,
  constraint fk_podem_ter_alergias foreign key (alergia_crianca) 
    references Alergias(alergia) on delete cascade
);

-- =============================================================================
-- VIEWS
-- =============================================================================

create or replace view vw_clientes_form as
select p.nCC, p.nome, a.email, a.num_telefone, c.morada
from Pessoas p
join Adultos a on a.nCC_adulto = p.nCC
join Clientes c on c.nCC_cliente = a.nCC_adulto;

create or replace view vw_trabalhadores_form as
select p.nCC, p.nome, a.email, a.num_telefone, t.cv
from Pessoas p
join Adultos a on a.nCC_adulto = p.nCC
join Trabalhadores t on t.nCC_trabalhador = a.nCC_adulto;

create or replace view vw_criancas_form as
select p.nCC, p.nome, c.nCC_cliente, c.data_nascimento
from Pessoas p
join Criancas c on c.nCC_crianca = p.nCC;

create or replace view vw_eventos as 
select s.id_servico, s.nCC_cliente, s.data_servico, s.local_servico, s.hora_inicio, s.hora_fim, s.preco_servico, e.tipo_evento
from servicos s
join eventos e on s.id_servico = e.id_evento;

create or replace view vw_festas as
select s.id_servico, s.nCC_cliente, s.data_servico, s.local_servico, s.hora_inicio, s.hora_fim, s.preco_servico, f.tema_festa
from servicos s
join festas f on s.id_servico = f.id_festa;

create or replace view vw_babysitting as
select s.id_servico, s.nCC_cliente, s.data_servico, s.local_servico, s.hora_inicio, s.hora_fim, s.preco_servico, b.horas_dormir
from servicos s
join babysitting b on s.id_servico = b.id_babysitting;

-- =============================================================================
-- TRIGGERS
-- =============================================================================

-- verifica se a hora definida para a criança dormir decorre durante a prestação do serviço
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
    raise_application_error(-20001, 'Erro: as horas de dormir devem estar contidas no horário do serviço.');
  end if;
end;
/

-- impede o consumo de stock caso a quantidade pretendida exceda o disponível no inventário
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
    raise_application_error(-20002, 'Erro: a quantidade gasta excede o stock disponível.');
  end if;
end;
/

-- atualiza a quantidade do catálogo de invetário após a utilização num serviço
create or replace trigger trg_update_stock
after insert or update on Utilizam
for each row
begin
  update Inventario
  set quantidade = quantidade - :new.quantidade_gasta
  where id_item = :new.id_item;
end;
/

-- garante que o pagamento regitado cobre exatamente o preço cobrado pelo serviço
create or replace trigger trg_check_valid_payment
before insert or update on PagamentoCliente
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

-- impede a alocação de um trabalhador a serviços com horários sobrepostos
create or replace trigger trg_check_sobreposicao_trabalhador
before insert or update on Trabalham
for each row
declare
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
end;
/

-- impede o registo de uma avaliação enquanto o serviço ainda estiver a decorrer
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

-- confirma se a data e o horário do serviço estão contidos na janela de disponibilidade dada pelo trabalhador
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

  v_dia_semana := case to_char(v_data_servico, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH')
    when 'MON' then 'Segunda'
    when 'TUE' then 'Terça'
    when 'WED' then 'Quarta'
    when 'THU' then 'Quinta'
    when 'FRI' then 'Sexta'
    when 'SAT' then 'Sábado'
    when 'SUN' then 'Domingo'
  end;
  
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

-- verifica anomalias na data de nascimento e bloqueia registos de maiores de idade na tabela de crianças
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

-- routing para a vista de Clientes
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

-- routing para a vista de Trabalhadores
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

-- routing para a vista de Crianças
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

-- routing para a vista de Babysitting
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

-- routing para a vista de Eventos
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

-- routing para a vista de Festas
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

-- =============================================================================
--  INSERTS
-- =============================================================================

insert all
	into Pessoas (nCC, nome) values (100000001, 'Ana Silva')
	into Pessoas (nCC, nome) values (100000002, 'Bruno Santos')
	into Pessoas (nCC, nome) values (100000003, 'Carlos Costa')
	into Pessoas (nCC, nome) values (100000004, 'Diana Pereira')
	into Pessoas (nCC, nome) values (100000005, 'Eduardo Martins')
	into Pessoas (nCC, nome) values (100000006, 'Filipa Gomes')
	into Pessoas (nCC, nome) values (100000007, 'Gonçalo Rodrigues')
	into Pessoas (nCC, nome) values (100000008, 'Helena Ferreira')
	into Pessoas (nCC, nome) values (100000009, 'Igor Almeida')
	into Pessoas (nCC, nome) values (100000010, 'Joana Sousa')
	into Pessoas (nCC, nome) values (200000001, 'Luís Ribeiro')
	into Pessoas (nCC, nome) values (200000002, 'Margarida Carvalho')
	into Pessoas (nCC, nome) values (200000003, 'Nuno Pinto')
	into Pessoas (nCC, nome) values (200000004, 'Olívia Mendes')
	into Pessoas (nCC, nome) values (200000005, 'Paulo Teixeira')
	into Pessoas (nCC, nome) values (200000006, 'Rita Fernandes')
	into Pessoas (nCC, nome) values (200000007, 'Sérgio Marques')
	into Pessoas (nCC, nome) values (200000008, 'Teresa Machado')
	into Pessoas (nCC, nome) values (200000009, 'Vítor Neves')
	into Pessoas (nCC, nome) values (200000010, 'Zélia Lopes')
	into Pessoas (nCC, nome) values (300000001, 'Artur Moreira')
	into Pessoas (nCC, nome) values (300000002, 'Bárbara Correia')
	into Pessoas (nCC, nome) values (300000003, 'Cristiano Vieira')
	into Pessoas (nCC, nome) values (300000004, 'Daniela Nunes')
	into Pessoas (nCC, nome) values (300000005, 'Emanuel Monteiro')
	into Pessoas (nCC, nome) values (300000006, 'Fátima Rocha')
	into Pessoas (nCC, nome) values (300000007, 'Gabriel Soares')
	into Pessoas (nCC, nome) values (300000008, 'Hugo Fonseca')
	into Pessoas (nCC, nome) values (300000009, 'Inês Borges')
	into Pessoas (nCC, nome) values (300000010, 'Jorge Castro')
select * from dual;

insert all
	into Adultos (nCC_adulto, email, num_telefone) values (100000001, 'ana.silva@gmail.com', 912345678)
	into Adultos (nCC_adulto, email, num_telefone) values (100000002, 'bruno.santos@gmail.com', 912345679)
	into Adultos (nCC_adulto, email, num_telefone) values (100000003, 'carlos.costa@gmail.com', 912345680)
	into Adultos (nCC_adulto, email, num_telefone) values (100000004, 'diana.pereira@gmail.com', 912345681)
	into Adultos (nCC_adulto, email, num_telefone) values (100000005, 'eduardo.martins@gmail.com', 912345682)
	into Adultos (nCC_adulto, email, num_telefone) values (100000006, 'filipa.gomes@gmail.com', 912345683)
	into Adultos (nCC_adulto, email, num_telefone) values (100000007, 'goncalo.rodrigues@gmail.com', 912345684)
	into Adultos (nCC_adulto, email, num_telefone) values (100000008, 'helena.ferreira@gmail.com', 912345685)
	into Adultos (nCC_adulto, email, num_telefone) values (100000009, 'igor.almeida@gmail.com', 912345686)
	into Adultos (nCC_adulto, email, num_telefone) values (100000010, 'joana.sousa@gmail.com', 912345687)
	into Adultos (nCC_adulto, email, num_telefone) values (200000001, 'luis.ribeiro@gmail.com', 912345688)
	into Adultos (nCC_adulto, email, num_telefone) values (200000002, 'margarida.carvalho@gmail.com', 912345689)
	into Adultos (nCC_adulto, email, num_telefone) values (200000003, 'nuno.pinto@gmail.com', 912345690)
	into Adultos (nCC_adulto, email, num_telefone) values (200000004, 'olivia.mendes@gmail.com', 912345691)
	into Adultos (nCC_adulto, email, num_telefone) values (200000005, 'paulo.teixeira@gmail.com', 912345692)
	into Adultos (nCC_adulto, email, num_telefone) values (200000006, 'rita.fernandes@gmail.com', 912345693)
	into Adultos (nCC_adulto, email, num_telefone) values (200000007, 'sergio.marques@gmail.com', 912345694)
	into Adultos (nCC_adulto, email, num_telefone) values (200000008, 'teresa.machado@gmail.com', 912345695)
	into Adultos (nCC_adulto, email, num_telefone) values (200000009, 'vitor.neves@gmail.com', 912345696)
	into Adultos (nCC_adulto, email, num_telefone) values (200000010, 'zelia.lopes@gmail.com', 912345697)
select * from dual;

insert all
	into Trabalhadores (nCC_trabalhador, cv) values (100000001, 'Experiência em babysitting e festas infantis')
	into Trabalhadores (nCC_trabalhador, cv) values (100000002, 'Formação em primeiros socorros e cuidado infantil')
	into Trabalhadores (nCC_trabalhador, cv) values (100000003, 'Experiência em organização de eventos para crianças')
	into Trabalhadores (nCC_trabalhador, cv) values (100000004, 'Formação em animação infantil e atividades lúdicas')
	into Trabalhadores (nCC_trabalhador, cv) values (100000005, 'Experiência em educação e cuidado infantil')
	into Trabalhadores (nCC_trabalhador, cv) values (100000006, 'Formação em nutrição infantil e cuidados de saúde')
	into Trabalhadores (nCC_trabalhador, cv) values (100000007, 'Experiência em babysitting e organização de festas infantis')
	into Trabalhadores (nCC_trabalhador, cv) values (100000008, 'Formação em primeiros socorros e cuidado infantil')
	into Trabalhadores (nCC_trabalhador, cv) values (100000009, 'Experiência em organização de eventos para crianças')
	into Trabalhadores (nCC_trabalhador, cv) values (100000010, 'Formação em animação infantil e atividades lúdicas')
select * from dual;

insert all
	into Clientes (nCC_cliente, morada) values (200000001, 'Rua das Flores, 123')
	into Clientes (nCC_cliente, morada) values (200000002, 'Avenida Principal, 456')
	into Clientes (nCC_cliente, morada) values (200000003, 'Praça Central, 789')
	into Clientes (nCC_cliente, morada) values (200000004, 'Rua do Sol, 321')
	into Clientes (nCC_cliente, morada) values (200000005, 'Avenida das Estrelas, 654')
	into Clientes (nCC_cliente, morada) values (200000006, 'Rua da Lua, 987')
	into Clientes (nCC_cliente, morada) values (200000007, 'Praça dos Pássaros, 111')
	into Clientes (nCC_cliente, morada) values (200000008, 'Avenida do Mar, 222')
	into Clientes (nCC_cliente, morada) values (200000009, 'Rua das Árvores, 333')
	into Clientes (nCC_cliente, morada) values (200000010, 'Praça do Sol, 444')
select * from dual;

insert all
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000001, 200000002, to_date('2015-05-10', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000002, 200000002, to_date('2017-08-20', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000003, 200000001, to_date('2016-03-15', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000004, 200000001, to_date('2018-11-05', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000005, 200000001, to_date('2014-01-25', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000006, 200000003, to_date('2019-07-30', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000007, 200000004, to_date('2015-09-12', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000008, 200000005, to_date('2017-12-22', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000009, 200000006, to_date('2016-04-18', 'YYYY-MM-DD'))
	into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000010, 200000007, to_date('2018-10-02', 'YYYY-MM-DD'))
select * from dual;

insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) 
  values (200000001, to_date('2026-06-01', 'YYYY-MM-DD'), 'Quinta das Flores', to_date('2026-06-01 14:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-01 18:00', 'YYYY-MM-DD HH24:MI'), 150.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico)
  values (200000002, to_date('2026-06-05', 'YYYY-MM-DD'), 'Salão Principal', to_date('2026-06-05 10:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-05 16:00', 'YYYY-MM-DD HH24:MI'), 200.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) 
  values (200000003, to_date('2026-06-10', 'YYYY-MM-DD'), 'Parque Central', to_date('2026-06-10 15:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-10 19:00', 'YYYY-MM-DD HH24:MI'), 120.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) 
  values (200000004, to_date('2026-06-12', 'YYYY-MM-DD'), 'Rua do Sol, 321', to_date('2026-06-12 14:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-12 17:00', 'YYYY-MM-DD HH24:MI'), 100.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) 
  values (200000005, to_date('2026-06-15', 'YYYY-MM-DD'), 'Avenida das Estrelas, 654', to_date('2026-06-15 20:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-15 23:59', 'YYYY-MM-DD HH24:MI'), 50.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) 
  values (200000006, to_date('2026-06-20', 'YYYY-MM-DD'), 'Rua da Lua, 987', to_date('2026-06-20 19:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-20 23:00', 'YYYY-MM-DD HH24:MI'), 60.00);

insert all
	into Eventos (id_evento, tipo_evento) values (1, 'Evento Corporativo')
	into Eventos (id_evento, tipo_evento) values (2, 'Batizado')
	into Festas (id_festa, tema_festa) values (3, 'Super-Heróis')
	into Festas (id_festa, tema_festa) values (4, 'Festa na Selva')
	into Babysitting (id_babysitting, horas_dormir) values (5, to_date('2026-06-15 21:30', 'YYYY-MM-DD HH24:MI'))
	into Babysitting (id_babysitting, horas_dormir) values (6, to_date('2026-06-20 21:00', 'YYYY-MM-DD HH24:MI'))
select * from dual;

insert all
	into Alergias (alergia) values ('Amendoins')
	into Alergias (alergia) values ('Frutos do mar')
	into Alergias (alergia) values ('Lactose')
	into Alergias (alergia) values ('Ovos')
	into Alergias (alergia) values ('Glúten')
	into Alergias (alergia) values ('Pólen')
	into Alergias (alergia) values ('Proteína do leite de vaca')
	into Alergias (alergia) values ('Picada de abelha')
	into Alergias (alergia) values ('Ácaros')
select * from dual;

insert into Inventario (nome_item, quantidade) values ('Fraldas', 100);
insert into Inventario (nome_item, quantidade) values ('Lenços umedecidos', 200);
insert into Inventario (nome_item, quantidade) values ('Leite em pó', 150);
insert into Inventario (nome_item, quantidade) values ('Brinquedos Didáticos', 50);
insert into Inventario (nome_item, quantidade) values ('Material de primeiros socorros', 30);


insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 
  values (100000001, 'Segunda', to_date('10:00', 'HH24:MI'), 	to_date('19:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000001, 'Quarta', to_date('09:00', 'HH24:MI'), 	to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000001, 'Sexta', to_date('10:00', 'HH24:MI'), 	to_date('15:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000002, 'Segunda', to_date('08:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000002, 'Terça', to_date('08:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000003, 'Terça', to_date('09:00', 'HH24:MI'), 	to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000003, 'Quinta', to_date('09:00', 'HH24:MI'), 	to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000003, 'Sexta', to_date('09:00', 'HH24:MI'), 	to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000004, 'Segunda', to_date('08:00', 'HH24:MI'), 	to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000004, 'Quarta', to_date('08:00', 'HH24:MI'), 	to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000004, 'Sexta', to_date('08:00', 'HH24:MI'), 	to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000005, 'Segunda', to_date('14:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000005, 'Quarta', to_date('14:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000005, 'Sexta', to_date('14:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000006, 'Terça', to_date('10:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000006, 'Quarta', to_date('10:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000006, 'Quinta', to_date('10:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 
  values (100000007, 'Sexta', to_date('13:00', 'HH24:MI'), 	to_date('22:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000007, 'Sábado', to_date('09:00', 'HH24:MI'), 	to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000007, 'Domingo', to_date('09:00', 'HH24:MI'), 	to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000008, 'Quinta', to_date('12:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000008, 'Sexta', to_date('12:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000008, 'Sábado', to_date('12:00', 'HH24:MI'), 	to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000009, 'Segunda', to_date('18:00', 'HH24:MI'), 	to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000009, 'Quarta', to_date('18:00', 'HH24:MI'), 	to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 
  values (100000009, 'Sexta', to_date('18:00', 'HH24:MI'), 	to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000010, 'Sexta', to_date('18:00', 'HH24:MI'), 	to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000010, 'Sábado', to_date('18:00', 'HH24:MI'), 	to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) 	
  values (100000010, 'Domingo', to_date('18:00', 'HH24:MI'), 	to_date('23:59', 'HH24:MI'));

	insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
		values (1, 200000001, 150.00, 'MBWay', to_date('2026-06-02', 	'YYYY-MM-DD'));
	insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
		values (2, 200000002, 200.00, 'Transferencia', to_date	('2026-06-06', 'YYYY-MM-DD'));
	insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
		values (3, 200000003, 120.00, 'Multibanco', to_date	('2026-06-11', 'YYYY-MM-DD'));
	insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
		values (4, 200000004, 100.00, 'Numerario', to_date	('2026-06-12', 'YYYY-MM-DD'));
	insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
		values (5, 200000005, 50.00, 'MBWay', to_date('2026-06-16', 	'YYYY-MM-DD'));
	insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
		values (6, 200000006, 60.00, 'Transferencia', to_date	('2026-06-21', 'YYYY-MM-DD'));

	insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
		values (1, 200000001, 5, 'Excelente serviço e 	organização!', to_date('2026-06-03', 'YYYY-MM-DD'));
	insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
		values (2, 200000002, 4, 'Correu muito bem, as 	crianças adoraram.', to_date('2026-06-07', 'YYYY-MM-DD'));
	insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
		values (3, 200000003, 5, 'Festa fantástica.', to_date	('2026-06-12', 'YYYY-MM-DD'));
	insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
		values (4, 200000004, 4, 'Animadores muito prestáveis.	', to_date('2026-06-13', 'YYYY-MM-DD'));
	insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
		values (5, 200000005, 5, 'Babysitter 5 estrelas, 	adormeceu a criança a horas.', to_date('2026-06-17', 'YYYY-MM-DD'));
	insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
		values (6, 200000006, 3, 'Bom, mas chegou ligeiramente 	atrasado.', to_date('2026-06-22', 'YYYY-MM-DD'));

insert all
	into Participam (id_servico, nCC_crianca) values (1, 300000001)
	into Participam (id_servico, nCC_crianca) values (1, 300000002)
	into Participam (id_servico, nCC_crianca) values (2, 300000003)
	into Participam (id_servico, nCC_crianca) values (2, 300000004)
	into Participam (id_servico, nCC_crianca) values (3, 300000005)
	into Participam (id_servico, nCC_crianca) values (3, 300000006)
	into Participam (id_servico, nCC_crianca) values (4, 300000007)
	into Participam (id_servico, nCC_crianca) values (4, 300000008)
	into Participam (id_servico, nCC_crianca) values (5, 300000009)
	into Participam (id_servico, nCC_crianca) values (6, 300000010)
select * from dual;

insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000001, 1, 50.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000002, 1, 50.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000003, 2, 70.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000004, 2, 60.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000005, 3, 50.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000006, 3, 40.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000007, 4, 60.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000008, 4, 30.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000009, 5, 40.00);
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) values (100000010, 6, 45.00);

insert all
	into Utilizam (id_servico, id_item, quantidade_gasta) values (1, 1, 5)
	into Utilizam (id_servico, id_item, quantidade_gasta) values (2, 2, 10)
	into Utilizam (id_servico, id_item, quantidade_gasta) values (3, 4, 2)
	into Utilizam (id_servico, id_item, quantidade_gasta) values (4, 3, 1)
	into Utilizam (id_servico, id_item, quantidade_gasta) values (5, 1, 3)
select * from dual;

insert all
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000001, 'Amendoins')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000002, 'Frutos do mar')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000002, 'Amendoins')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000003, 'Lactose')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000004, 'Ovos')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000005, 'Glúten')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000007, 'Pólen')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000008, 'Lactose')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000008, 'Proteína do leite de vaca')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000009, 'Picada de abelha')
  into Podem_ter (nCC_crianca_alergia, alergia_crianca) values (300000010, 'Ácaros')
select * from dual;
commit;

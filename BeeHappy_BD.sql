-- ============================================================
-- DROP triggers
-- ============================================================
drop trigger trg_check_horas_dormir;
drop trigger trg_utilizam_stock;

-- ============================================================
-- DROP tables 
-- ============================================================
drop table utilizam cascade constraints;
drop table trabalham cascade constraints;
drop table participam cascade constraints;
drop table avaliam cascade constraints;
drop table pagamentocliente cascade constraints;
drop table inventario cascade constraints;
drop table alergias cascade constraints;
drop table disponibilidade cascade constraints;
drop table babysitting cascade constraints;
drop table festas cascade constraints;
drop table eventos cascade constraints;
drop table servicos cascade constraints;
drop table criancas cascade constraints;
drop table clientes cascade constraints;
drop table trabalhadores cascade constraints;
drop table adultos cascade constraints;
drop table pessoas cascade constraints;

-- ============================================================
-- CREATE tables
-- ============================================================
create table pessoas (
   ncc  number(9) not null,
   nome varchar2(100) not null,
   constraint pk_pessoas primary key ( ncc )
);

create table adultos (
   ncc_adulto   number(9) not null,
   email        varchar2(100) not null,
   num_telefone number(9) not null,
   constraint pk_adultos primary key ( ncc_adulto ),
   constraint fk_adultos_pessoas foreign key ( ncc_adulto )
      references pessoas ( ncc )
         on delete cascade
);

create table trabalhadores (
   ncc_trabalhador number(9) not null,
   cv              varchar2(1000) not null,
   constraint pk_trabalhadores primary key ( ncc_trabalhador ),
   constraint fk_trabalhadores_adultos foreign key ( ncc_trabalhador )
      references adultos ( ncc_adulto )
         on delete cascade
);

create table clientes (
   ncc_cliente number(9) not null,
   morada      varchar2(100) not null,
   constraint pk_clientes primary key ( ncc_cliente ),
   constraint fk_clientes_adultos foreign key ( ncc_cliente )
      references adultos ( ncc_adulto )
         on delete cascade
);

create table criancas (
   ncc_crianca     number(9) not null,
   ncc_cliente     number(9) not null,
   data_nascimento date not null,
   constraint pk_criancas primary key ( ncc_crianca ),
   constraint fk_criancas_pessoas foreign key ( ncc_crianca )
      references pessoas ( ncc )
         on delete cascade,
   constraint fk_criancas_clientes foreign key ( ncc_cliente )
      references clientes ( ncc_cliente )
);

create table servicos (
   id_servico    number generated always as identity,
   ncc_cliente   number(9) not null,
   data_servico  date not null,
   local_servico varchar2(100) not null,
   hora_inicio   date not null,
   hora_fim      date not null,
   preco_servico number(4,2) not null,
   constraint pk_servicos primary key ( id_servico ),
   constraint fk_servicos_clientes foreign key ( ncc_cliente )
      references clientes ( ncc_cliente ),
   constraint ck_servicos_horas check ( hora_fim > hora_inicio ),
   constraint ck_servicos_preco check ( preco_servico > 0 )
);

create table eventos (
   id_evento   number not null,
   tipo_evento varchar2(100) not null,
   constraint pk_eventos primary key ( id_evento ),
   constraint fk_eventos_servicos foreign key ( id_evento )
      references servicos ( id_servico )
         on delete cascade
);

create table festas (
   id_festa   number not null,
   tema_festa varchar2(100) not null,
   constraint pk_festas primary key ( id_festa ),
   constraint fk_festas_servicos foreign key ( id_festa )
      references servicos ( id_servico )
         on delete cascade
);

create table babysitting (
   id_babysitting number not null,
   horas_dormir   date not null,
   constraint pk_babysitting primary key ( id_babysitting ),
   constraint fk_babysitting_servicos foreign key ( id_babysitting )
      references servicos ( id_servico )
         on delete cascade
);

create table disponibilidade (
   id_disp         number generated always as identity,
   ncc_trabalhador number(9) not null,
   dia_semana      varchar2(10) not null,
   hora_inicio     date not null,
   hora_fim        date not null,
   constraint pk_disp primary key ( id_disp ),
   constraint fk_disp_trabalhadores foreign key ( ncc_trabalhador )
      references trabalhadores ( ncc_trabalhador ),
   constraint ck_disp_horas check ( hora_fim > hora_inicio ),
   constraint ck_disp_dia
      check ( dia_semana in ( 'Segunda',
                              'Terça',
                              'Quarta',
                              'Quinta',
                              'Sexta',
                              'Sábado',
                              'Domingo' ) )
);

create table alergias (
   ncc_crianca number(9) not null,
   alergia     varchar2(100) not null,
   constraint pk_alergias primary key ( ncc_crianca,
                                        alergia ),
   constraint fk_alergias_criancas foreign key ( ncc_crianca )
      references criancas ( ncc_crianca )
);

create table inventario (
   id_item    number generated always as identity,
   nome_item  varchar2(100) not null,
   quantidade number not null,
   constraint pk_inventario primary key ( id_item )
);

create table pagamentocliente (
   id_pagamento number generated always as identity,
   id_servico   number not null,
   ncc_cliente  number(9) not null,
   valor        number not null,
   metodo       varchar2(50) not null,
   data_pag     date not null,
   constraint pk_pagamento primary key ( id_pagamento ),
   constraint fk_pagamento_servicos foreign key ( id_servico )
      references servicos ( id_servico ),
   constraint fk_pagamento_clientes foreign key ( ncc_cliente )
      references clientes ( ncc_cliente ),
   constraint ck_pagamento_valor check ( valor > 0 ),
   constraint ck_pagamento_metodo
      check ( metodo in ( 'Multibanco',
                          'MBWay',
                          'Transferencia',
                          'Numerario' ) )
);

create table avaliam (
   id_servico     number not null,
   ncc_cliente    number(9) not null,
   classificacao  number(1) not null,
   comentario     varchar2(500),
   data_avaliacao date not null,
   constraint pk_alvaliam primary key ( id_servico,
                                        ncc_cliente ),
   constraint fk_avaliam_servicos foreign key ( id_servico )
      references servicos ( id_servico ),
   constraint fk_avaliam_clientes foreign key ( ncc_cliente )
      references clientes ( ncc_cliente ),
   constraint ck_avaliam_classificacao check ( classificacao between 1 and 5 )
);

create table participam (
   id_servico  number not null,
   ncc_crianca number(9) not null,
   constraint pk_participam primary key ( id_servico,
                                          ncc_crianca ),
   constraint fk_participam_servicos foreign key ( id_servico )
      references servicos ( id_servico ),
   constraint fk_participam_criancas foreign key ( ncc_crianca )
      references criancas ( ncc_crianca )
);

create table trabalham (
   ncc_trabalhador number(9) not null,
   id_servico      number not null,
   valor_recebido  number not null,
   constraint pk_trabalham primary key ( ncc_trabalhador,
                                         id_servico ),
   constraint fk_trabalham_trabalhadores foreign key ( ncc_trabalhador )
      references trabalhadores ( ncc_trabalhador ),
   constraint fk_trabalham_servicos foreign key ( id_servico )
      references servicos ( id_servico ),
   constraint ck_trabalham_valor check ( valor_recebido > 0 )
);

create table utilizam (
   id_servico       number not null,
   id_item          number not null,
   quantidade_gasta number not null,
   constraint pk_utilizam primary key ( id_servico,
                                        id_item ),
   constraint fk_utilizam_servicos foreign key ( id_servico )
      references servicos ( id_servico ),
   constraint fk_utilizam_inventario foreign key ( id_item )
      references inventario ( id_item ),
   constraint ck_utilizam_quantidade check ( quantidade_gasta > 0 )
);

-- ============================================================
-- CREATE triggers
-- ============================================================
create or replace trigger trg_check_horas_dormir before
   insert or update on babysitting
   for each row
declare
   v_inicio date;
   v_fim    date;
begin
   select hora_inicio,
          hora_fim
     into
      v_inicio,
      v_fim
     from servicos
    where id_servico = :new.id_babysitting;

   if :new.horas_dormir < v_inicio
   or :new.horas_dormir > v_fim then
      raise_application_error(
         -20001,
         'Horas de dormir devem estar dentro do horário do serviço.'
      );
   end if;
end;
/

create or replace trigger trg_utilizam_stock before
   insert or update on utilizam
   for each row
declare
   v_stock number;
begin
   select quantidade
     into v_stock
     from inventario
    where id_item = :new.id_item;

   if :new.quantidade_gasta > v_stock then
      raise_application_error(
         -20002,
         'Quantidade gasta excede o stock disponível.'
      );
   end if;
end;
/

-- ============================================================
-- INSERTS
-- ============================================================

commit;
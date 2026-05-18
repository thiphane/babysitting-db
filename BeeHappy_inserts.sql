-- ============================================================
-- INSERTS: POVOAMENTO DA BASE DE DADOS
-- ============================================================

-- ------------------------------------------------------------
-- SUPERCLASSE: PESSOAS
-- A numeração das chaves primárias (nCC) está organizada por prefixos lógicos 
-- para facilitar a leitura do modelo: 1 (Trabalhadores), 2 (Clientes), 3 (Crianças).
-- ------------------------------------------------------------
insert into Pessoas (nCC, nome) values (100000001, 'Ana Silva');
insert into Pessoas (nCC, nome) values (100000002, 'Bruno Santos');
insert into Pessoas (nCC, nome) values (100000003, 'Carlos Costa');
insert into Pessoas (nCC, nome) values (100000004, 'Diana Pereira');
insert into Pessoas (nCC, nome) values (100000005, 'Eduardo Martins');
insert into Pessoas (nCC, nome) values (100000006, 'Filipa Gomes');
insert into Pessoas (nCC, nome) values (100000007, 'Gonçalo Rodrigues');
insert into Pessoas (nCC, nome) values (100000008, 'Helena Ferreira');
insert into Pessoas (nCC, nome) values (100000009, 'Igor Almeida');
insert into Pessoas (nCC, nome) values (100000010, 'Joana Sousa');
insert into Pessoas (nCC, nome) values (200000001, 'Luís Ribeiro');
insert into Pessoas (nCC, nome) values (200000002, 'Margarida Carvalho');
insert into Pessoas (nCC, nome) values (200000003, 'Nuno Pinto');
insert into Pessoas (nCC, nome) values (200000004, 'Olívia Mendes');
insert into Pessoas (nCC, nome) values (200000005, 'Paulo Teixeira');
insert into Pessoas (nCC, nome) values (200000006, 'Rita Fernandes');
insert into Pessoas (nCC, nome) values (200000007, 'Sérgio Marques');
insert into Pessoas (nCC, nome) values (200000008, 'Teresa Machado');
insert into Pessoas (nCC, nome) values (200000009, 'Vítor Neves');
insert into Pessoas (nCC, nome) values (200000010, 'Zélia Lopes');
insert into Pessoas (nCC, nome) values (300000001, 'Artur Moreira');
insert into Pessoas (nCC, nome) values (300000002, 'Bárbara Correia');
insert into Pessoas (nCC, nome) values (300000003, 'Cristiano Vieira');
insert into Pessoas (nCC, nome) values (300000004, 'Daniela Nunes');
insert into Pessoas (nCC, nome) values (300000005, 'Emanuel Monteiro');
insert into Pessoas (nCC, nome) values (300000006, 'Fátima Rocha');
insert into Pessoas (nCC, nome) values (300000007, 'Gabriel Soares');
insert into Pessoas (nCC, nome) values (300000008, 'Hugo Fonseca');
insert into Pessoas (nCC, nome) values (300000009, 'Inês Borges');
insert into Pessoas (nCC, nome) values (300000010, 'Jorge Castro');
commit;

-- ------------------------------------------------------------
-- ESPECIALIZAÇÃO: ADULTOS
-- Entidade intermédia na hierarquia. Centraliza os atributos de contacto 
-- partilhados obrigatoriamente por Trabalhadores e Clientes.
-- ------------------------------------------------------------
insert into Adultos (nCC_adulto, email, num_telefone) values (100000001, 'ana.silva@gmail.com', 912345678);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000002, 'bruno.santos@gmail.com', 912345679);  
insert into Adultos (nCC_adulto, email, num_telefone) values (100000003, 'carlos.costa@gmail.com', 912345680);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000004, 'diana.pereira@gmail.com', 912345681);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000005, 'eduardo.martins@gmail.com', 912345682);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000006, 'filipa.gomes@gmail.com', 912345683);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000007, 'goncalo.rodrigues@gmail.com', 912345684);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000008, 'helena.ferreira@gmail.com', 912345685);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000009, 'igor.almeida@gmail.com', 912345686);
insert into Adultos (nCC_adulto, email, num_telefone) values (100000010, 'joana.sousa@gmail.com', 912345687);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000001, 'luis.ribeiro@gmail.com', 912345688);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000002, 'margarida.carvalho@gmail.com', 912345689);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000003, 'nuno.pinto@gmail.com', 912345690);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000004, 'olivia.mendes@gmail.com', 912345691);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000005, 'paulo.teixeira@gmail.com', 912345692);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000006, 'rita.fernandes@gmail.com', 912345693);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000007, 'sergio.marques@gmail.com', 912345694);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000008, 'teresa.machado@gmail.com', 912345695);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000009, 'vitor.neves@gmail.com', 912345696);
insert into Adultos (nCC_adulto, email, num_telefone) values (200000010, 'zelia.lopes@gmail.com', 912345697);
commit;

-- ------------------------------------------------------------
-- SUBCLASSES: TRABALHADORES E CLIENTES
-- Entidades folha da hierarquia. Os Clientes atuam logicamente como 
-- os responsáveis legais pelas Crianças.
-- ------------------------------------------------------------
insert into Trabalhadores (nCC_trabalhador, cv) values (100000001, 'Experiência em babysitting e festas infantis');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000002, 'Formação em primeiros socorros e cuidado infantil');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000003, 'Experiência em organização de eventos para crianças');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000004, 'Formação em animação infantil e atividades lúdicas');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000005, 'Experiência em educação e cuidado infantil');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000006, 'Formação em nutrição infantil e cuidados de saúde');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000007, 'Experiência em babysitting e organização de festas infantis');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000008, 'Formação em primeiros socorros e cuidado infantil');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000009, 'Experiência em organização de eventos para crianças');
insert into Trabalhadores (nCC_trabalhador, cv) values (100000010, 'Formação em animação infantil e atividades lúdicas');
commit;

insert into Clientes (nCC_cliente, morada) values (200000001, 'Rua das Flores, 123');
insert into Clientes (nCC_cliente, morada) values (200000002, 'Avenida Principal, 456');
insert into Clientes (nCC_cliente, morada) values (200000003, 'Praça Central, 789');
insert into Clientes (nCC_cliente, morada) values (200000004, 'Rua do Sol, 321');
insert into Clientes (nCC_cliente, morada) values (200000005, 'Avenida das Estrelas, 654');
insert into Clientes (nCC_cliente, morada) values (200000006, 'Rua da Lua, 987');
insert into Clientes (nCC_cliente, morada) values (200000007, 'Praça dos Pássaros, 111');
insert into Clientes (nCC_cliente, morada) values (200000008, 'Avenida do Mar, 222');
insert into Clientes (nCC_cliente, morada) values (200000009, 'Rua das Árvores, 333');
insert into Clientes (nCC_cliente, morada) values (200000010, 'Praça do Sol, 444');
commit;

-- ------------------------------------------------------------
-- ENTIDADE: CRIANÇAS
-- Mapeamento da dependência de existência à entidade Cliente (nCC_cliente).
-- ------------------------------------------------------------
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000001, 200000002, to_date('2015-05-10', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000002, 200000002, to_date('2017-08-20', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000003, 200000001, to_date('2016-03-15', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000004, 200000001, to_date('2018-11-05', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000005, 200000001, to_date('2014-01-25', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000006, 200000003, to_date('2019-07-30', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000007, 200000004, to_date('2015-09-12', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000008, 200000005, to_date('2017-12-22', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000009, 200000006, to_date('2016-04-18', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000010, 200000007, to_date('2018-10-02', 'YYYY-MM-DD'));
commit;

-- ------------------------------------------------------------
-- SUPERCLASSE: SERVIÇOS
-- Entidade central do modelo. Os IDs (id_servico) são gerados sequencialmente.
-- ------------------------------------------------------------
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000001, to_date('2026-06-01', 'YYYY-MM-DD'), 'Quinta das Flores', to_date('2026-06-01 14:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-01 18:00', 'YYYY-MM-DD HH24:MI'), 150.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000002, to_date('2026-06-05', 'YYYY-MM-DD'), 'Salão Principal', to_date('2026-06-05 10:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-05 16:00', 'YYYY-MM-DD HH24:MI'), 200.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000003, to_date('2026-06-10', 'YYYY-MM-DD'), 'Parque Central', to_date('2026-06-10 15:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-10 19:00', 'YYYY-MM-DD HH24:MI'), 120.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000004, to_date('2026-06-12', 'YYYY-MM-DD'), 'Rua do Sol, 321', to_date('2026-06-12 14:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-12 17:00', 'YYYY-MM-DD HH24:MI'), 100.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000005, to_date('2026-06-15', 'YYYY-MM-DD'), 'Avenida das Estrelas, 654', to_date('2026-06-15 20:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-15 23:59', 'YYYY-MM-DD HH24:MI'), 50.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000006, to_date('2026-06-20', 'YYYY-MM-DD'), 'Rua da Lua, 987', to_date('2026-06-20 19:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-20 23:00', 'YYYY-MM-DD HH24:MI'), 60.00);
commit;

-- ------------------------------------------------------------
-- SUBCLASSES: EVENTOS, FESTAS E BABYSITTING
-- Especializações disjuntas. Partilham a chave primária da superclasse 
-- para garantir a relação de herança 1:1.
-- ------------------------------------------------------------
insert into Eventos (id_evento, tipo_evento) values (1, 'Evento Corporativo');
insert into Eventos (id_evento, tipo_evento) values (2, 'Batizado');

insert into Festas (id_festa, tema_festa) values (3, 'Super-Heróis');
insert into Festas (id_festa, tema_festa) values (4, 'Festa na Selva');

insert into Babysitting (id_babysitting, horas_dormir) values (5, to_date('2026-06-15 21:30', 'YYYY-MM-DD HH24:MI'));
insert into Babysitting (id_babysitting, horas_dormir) values (6, to_date('2026-06-20 21:00', 'YYYY-MM-DD HH24:MI'));
commit;

-- ------------------------------------------------------------
-- CATÁLOGOS BASE E DISPONIBILIDADE
-- Dados de domínio e pré-requisitos necessários para validar a integridade 
-- das inserções e os triggers de negócio das tabelas de associação.
-- ------------------------------------------------------------

-- Catálogo de Alergias (adicionado para garantir as FKs na tabela Podem_ter)
insert into Alergias (alergia) values ('Amendoins');
insert into Alergias (alergia) values ('Frutos do mar');
insert into Alergias (alergia) values ('Lactose');
insert into Alergias (alergia) values ('Ovos');
insert into Alergias (alergia) values ('Glúten');
insert into Alergias (alergia) values ('Pólen');
insert into Alergias (alergia) values ('Proteína do leite de vaca');
insert into Alergias (alergia) values ('Picada de abelha');
insert into Alergias (alergia) values ('Ácaros');

-- Catálogo de Inventário
insert into Inventario (nome_item, quantidade) values ('Fraldas', 100);
insert into Inventario (nome_item, quantidade) values ('Lenços umedecidos', 200);
insert into Inventario (nome_item, quantidade) values ('Leite em pó', 150);
insert into Inventario (nome_item, quantidade) values ('Brinquedos Didáticos', 50);
insert into Inventario (nome_item, quantidade) values ('Material de primeiros socorros', 30);

-- Horários inseridos para cobrir rigorosamente as datas e horas dos Serviços 1 a 6
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000001, 'Segunda', to_date('10:00', 'HH24:MI'), to_date('19:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000001, 'Quarta', to_date('09:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000001, 'Sexta', to_date('10:00', 'HH24:MI'), to_date('15:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000002, 'Segunda', to_date('08:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000002, 'Terça', to_date('08:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000003, 'Terça', to_date('09:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000003, 'Quinta', to_date('09:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000003, 'Sexta', to_date('09:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000004, 'Segunda', to_date('08:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000004, 'Quarta', to_date('08:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000004, 'Sexta', to_date('08:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000005, 'Segunda', to_date('14:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000005, 'Quarta', to_date('14:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000005, 'Sexta', to_date('14:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000006, 'Terça', to_date('10:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000006, 'Quarta', to_date('10:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000006, 'Quinta', to_date('10:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000007, 'Sexta', to_date('13:00', 'HH24:MI'), to_date('22:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000007, 'Sábado', to_date('09:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000007, 'Domingo', to_date('09:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000008, 'Quinta', to_date('12:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000008, 'Sexta', to_date('12:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000008, 'Sábado', to_date('12:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000009, 'Segunda', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000009, 'Quarta', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000009, 'Sexta', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000010, 'Sexta', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000010, 'Sábado', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000010, 'Domingo', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
commit;

-- ------------------------------------------------------------
-- PROCESSOS FINANCEIROS E AVALIAÇÕES
-- ------------------------------------------------------------
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (1, 200000001, 150.00, 'MBWay', to_date('2026-06-02', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (2, 200000002, 200.00, 'Transferencia', to_date('2026-06-06', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (3, 200000003, 120.00, 'Multibanco', to_date('2026-06-11', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (4, 200000004, 100.00, 'Numerario', to_date('2026-06-12', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (5, 200000005, 50.00, 'MBWay', to_date('2026-06-16', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (6, 200000006, 60.00, 'Transferencia', to_date('2026-06-21', 'YYYY-MM-DD'));

insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (1, 200000001, 5, 'Excelente serviço e organização!', to_date('2026-06-03', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (2, 200000002, 4, 'Correu muito bem, as crianças adoraram.', to_date('2026-06-07', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (3, 200000003, 5, 'Festa fantástica.', to_date('2026-06-12', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (4, 200000004, 4, 'Animadores muito prestáveis.', to_date('2026-06-13', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (5, 200000005, 5, 'Babysitter 5 estrelas, adormeceu a criança a horas.', to_date('2026-06-17', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (6, 200000006, 3, 'Bom, mas chegou ligeiramente atrasado.', to_date('2026-06-22', 'YYYY-MM-DD'));
commit;

-- ------------------------------------------------------------
-- ASSOCIAÇÕES N:M (TABELAS DE CRUZAMENTO)
-- Resolução das cardinalidades muitos-para-muitos definidas no modelo ER.
-- ------------------------------------------------------------

-- Participam: Associa as Crianças aos Serviços em que estão inscritas.
insert into Participam (id_servico, nCC_crianca) values (1, 300000001);
insert into Participam (id_servico, nCC_crianca) values (1, 300000002);
insert into Participam (id_servico, nCC_crianca) values (2, 300000003);
insert into Participam (id_servico, nCC_crianca) values (2, 300000004);
insert into Participam (id_servico, nCC_crianca) values (3, 300000005);
insert into Participam (id_servico, nCC_crianca) values (3, 300000006);
insert into Participam (id_servico, nCC_crianca) values (4, 300000007);
insert into Participam (id_servico, nCC_crianca) values (4, 300000008);
insert into Participam (id_servico, nCC_crianca) values (5, 300000009);
insert into Participam (id_servico, nCC_crianca) values (6, 300000010);

-- Trabalham: Aloca Trabalhadores aos Serviços (depende da tabela Disponibilidade).
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

-- Utilizam: Regista a dedução de stock no Inventário por cada Serviço executado.
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (1, 1, 5);
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (2, 2, 10);
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (3, 4, 2);
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (4, 3, 1);
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (5, 1, 3);

-- Podem_ter: Associa Crianças a condições de saúde (0 a N). 
-- As inserções múltiplas na criança 300000002 validam o uso da PK composta.
insert into Podem_ter (nCC_crianca, alergia) values (300000001, 'Amendoins');
insert into Podem_ter (nCC_crianca, alergia) values (300000002, 'Frutos do mar');
insert into Podem_ter (nCC_crianca, alergia) values (300000002, 'Amendoins');
insert into Podem_ter (nCC_crianca, alergia) values (300000003, 'Lactose');
insert into Podem_ter (nCC_crianca, alergia) values (300000004, 'Ovos');
insert into Podem_ter (nCC_crianca, alergia) values (300000005, 'Glúten');
insert into Podem_ter (nCC_crianca, alergia) values (300000007, 'Pólen');
insert into Podem_ter (nCC_crianca, alergia) values (300000008, 'Lactose');
insert into Podem_ter (nCC_crianca, alergia) values (300000008, 'Proteína do leite de vaca');
insert into Podem_ter (nCC_crianca, alergia) values (300000009, 'Picada de abelha');
insert into Podem_ter (nCC_crianca, alergia) values (300000010, 'Ácaros');
commit;

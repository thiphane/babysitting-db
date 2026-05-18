-- ============================================================
-- INSERTS
-- ============================================================
-- adultos (ids começados por 1 e 2)
-- trabalhadores (ids começados por 1)
-- clientes (ids começados por 2)
-- crianças (ids começados por 3)
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
COMMIT;

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

-- cliente com 3 filhos
insert into Clientes (nCC_cliente, morada) values (200000001, 'Rua das Flores, 123');
-- cliente com 2 filhos
insert into Clientes (nCC_cliente, morada) values (200000002, 'Avenida Principal, 456');
-- clinetes com 1 filho
insert into Clientes (nCC_cliente, morada) values (200000003, 'Praça Central, 789');
insert into Clientes (nCC_cliente, morada) values (200000004, 'Rua do Sol, 321');
insert into Clientes (nCC_cliente, morada) values (200000005, 'Avenida das Estrelas, 654');
insert into Clientes (nCC_cliente, morada) values (200000006, 'Rua da Lua, 987');
insert into Clientes (nCC_cliente, morada) values (200000007, 'Praça dos Pássaros, 111');
-- clientes sem filhos 
insert into Clientes (nCC_cliente, morada) values (200000008, 'Avenida do Mar, 222');
insert into Clientes (nCC_cliente, morada) values (200000009, 'Rua das Árvores, 333');
insert into Clientes (nCC_cliente, morada) values (200000010, 'Praça do Sol, 444');
commit;

-- 2 irmãos associados ao cliente 200000002
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000001, 200000002, to_date('2015-05-10', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000002, 200000002, to_date('2017-08-20', 'YYYY-MM-DD'));
-- 3 irmãos associados ao cliente 200000001
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000003, 200000001, to_date('2016-03-15', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000004, 200000001, to_date('2018-11-05', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000005, 200000001, to_date('2014-01-25', 'YYYY-MM-DD'));
-- filhos únicos
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000006, 200000003, to_date('2019-07-30', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000007, 200000004, to_date('2015-09-12', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000008, 200000005, to_date('2017-12-22', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000009, 200000006, to_date('2016-04-18', 'YYYY-MM-DD'));
insert into Criancas (nCC_crianca, nCC_cliente, data_nascimento) values (300000010, 200000007, to_date('2018-10-02', 'YYYY-MM-DD'));
commit;

-- 6 Serviços para cobrir os 2 Eventos, 2 Festas e 2 Babysittings
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000001, to_date('2026-06-01', 'YYYY-MM-DD'), 'Quinta das Flores', to_date('2026-06-01 14:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-01 18:00', 'YYYY-MM-DD HH24:MI'), 150.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000002, to_date('2026-06-05', 'YYYY-MM-DD'), 'Salão Principal', to_date('2026-06-05 10:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-05 16:00', 'YYYY-MM-DD HH24:MI'), 200.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000003, to_date('2026-06-10', 'YYYY-MM-DD'), 'Parque Central', to_date('2026-06-10 15:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-10 19:00', 'YYYY-MM-DD HH24:MI'), 120.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000004, to_date('2026-06-12', 'YYYY-MM-DD'), 'Rua do Sol, 321', to_date('2026-06-12 14:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-12 17:00', 'YYYY-MM-DD HH24:MI'), 100.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000005, to_date('2026-06-15', 'YYYY-MM-DD'), 'Avenida das Estrelas, 654', to_date('2026-06-15 20:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-15 23:59', 'YYYY-MM-DD HH24:MI'), 50.00);
insert into Servicos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico) values (200000006, to_date('2026-06-20', 'YYYY-MM-DD'), 'Rua da Lua, 987', to_date('2026-06-20 19:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-20 23:00', 'YYYY-MM-DD HH24:MI'), 60.00);
commit;

-- Especializações dos Serviços
insert into Eventos (id_evento, tipo_evento) values (1, 'Evento Corporativo');
insert into Eventos (id_evento, tipo_evento) values (2, 'Batizado');
insert into Festas (id_festa, tema_festa) values (3, 'Super-Heróis');
insert into Festas (id_festa, tema_festa) values (4, 'Festa na Selva');
insert into Babysitting (id_babysitting, horas_dormir) values (5, to_date('2026-06-15 21:30', 'YYYY-MM-DD HH24:MI'));
insert into Babysitting (id_babysitting, horas_dormir) values (6, to_date('2026-06-20 21:00', 'YYYY-MM-DD HH24:MI'));
commit;
-- ============================================================
-- Disponibilidades Reais (Vários dias por trabalhador)
-- ============================================================

-- Trabalhador 1 (Cobre o Serviço 1: Segunda 14h-18h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000001, 'Segunda', to_date('10:00', 'HH24:MI'), to_date('19:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000001, 'Quarta', to_date('09:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000001, 'Sexta', to_date('10:00', 'HH24:MI'), to_date('15:00', 'HH24:MI'));
-- Trabalhador 2 (Cobre o Serviço 1: Segunda 14h-18h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000002, 'Segunda', to_date('08:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000002, 'Terça', to_date('08:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
-- Trabalhador 3 (Cobre o Serviço 2: Sexta 10h-16h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000003, 'Terça', to_date('09:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000003, 'Quinta', to_date('09:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000003, 'Sexta', to_date('09:00', 'HH24:MI'), to_date('17:00', 'HH24:MI'));
-- Trabalhador 4 (Cobre o Serviço 2: Sexta 10h-16h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000004, 'Segunda', to_date('08:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000004, 'Quarta', to_date('08:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000004, 'Sexta', to_date('08:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
-- Trabalhador 5 (Cobre o Serviço 3: Quarta 15h-19h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000005, 'Segunda', to_date('14:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000005, 'Quarta', to_date('14:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000005, 'Sexta', to_date('14:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
-- Trabalhador 6 (Cobre o Serviço 3: Quarta 15h-19h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000006, 'Terça', to_date('10:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000006, 'Quarta', to_date('10:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000006, 'Quinta', to_date('10:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
-- Trabalhador 7 (Cobre o Serviço 4: Sexta 14h-17h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000007, 'Sexta', to_date('13:00', 'HH24:MI'), to_date('22:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000007, 'Sábado', to_date('09:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000007, 'Domingo', to_date('09:00', 'HH24:MI'), to_date('18:00', 'HH24:MI'));
-- Trabalhador 8 (Cobre o Serviço 4: Sexta 14h-17h)
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000008, 'Quinta', to_date('12:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000008, 'Sexta', to_date('12:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000008, 'Sábado', to_date('12:00', 'HH24:MI'), to_date('20:00', 'HH24:MI'));
-- Trabalhador 9 (Cobre o Serviço 5: Segunda 20h-23:59) - Turnos Noturnos
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000009, 'Segunda', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000009, 'Quarta', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000009, 'Sexta', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
-- Trabalhador 10 (Cobre o Serviço 6: Sábado 19h-23h) - Turnos Noturnos Fim de Semana
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000010, 'Sexta', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000010, 'Sábado', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
insert into Disponibilidade (nCC_trabalhador, dia_semana, hora_inicio, hora_fim) values (100000010, 'Domingo', to_date('18:00', 'HH24:MI'), to_date('23:59', 'HH24:MI'));
commit;

-- ============================================================
-- Alergias
-- ============================================================
insert into Alergias (nCC_crianca, alergia) values (300000001, 'Alergia a amendoins');
insert into Alergias (nCC_crianca, alergia) values (300000002, 'Alergia a frutos do mar');
insert into Alergias (nCC_crianca, alergia) values (300000003, 'Alergia à lactose');
insert into Alergias (nCC_crianca, alergia) values (300000004, 'Alergia a ovos');
insert into Alergias (nCC_crianca, alergia) values (300000005, 'Alergia ao glúten');
insert into Alergias (nCC_crianca, alergia) values (300000006, 'Alergia a amendoins');
insert into Alergias (nCC_crianca, alergia) values (300000007, 'Alergia a pólen');
insert into Alergias (nCC_crianca, alergia) values (300000008, 'Alergia à lactose');
insert into Alergias (nCC_crianca, alergia) values (300000009, 'Alergia a ovos');
insert into Alergias (nCC_crianca, alergia) values (300000010, 'Sem alergias conhecidas');
commit;

-- ============================================================
-- Inventário
-- ============================================================
insert into Inventario (nome_item, quantidade) values ('Fraldas', 100);
insert into Inventario (nome_item, quantidade) values ('Lenços umedecidos', 200);
insert into Inventario (nome_item, quantidade) values ('Leite em pó', 150);
insert into Inventario (nome_item, quantidade) values ('Brinquedos Didáticos', 50);
insert into Inventario (nome_item, quantidade) values ('Material de primeiros socorros', 30);
commit;

-- Pagamentos (Valida o método: Multibanco, MBWay, Transferencia, Numerario)
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (1, 200000001, 150.00, 'MBWay', to_date('2026-06-02', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (2, 200000002, 200.00, 'Transferencia', to_date('2026-06-06', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (3, 200000003, 120.00, 'Multibanco', to_date('2026-06-11', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (4, 200000004, 100.00, 'Numerario', to_date('2026-06-12', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (5, 200000005, 50.00, 'MBWay', to_date('2026-06-16', 'YYYY-MM-DD'));
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) values (6, 200000006, 60.00, 'Transferencia', to_date('2026-06-21', 'YYYY-MM-DD'));
commit;

-- Avaliações 
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (1, 200000001, 5, 'Excelente serviço e organização!', to_date('2026-06-03', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (2, 200000002, 4, 'Correu muito bem, as crianças adoraram.', to_date('2026-06-07', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (3, 200000003, 5, 'Festa fantástica.', to_date('2026-06-12', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (4, 200000004, 4, 'Animadores muito prestáveis.', to_date('2026-06-13', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (5, 200000005, 5, 'Babysitter 5 estrelas, adormeceu a criança a horas.', to_date('2026-06-17', 'YYYY-MM-DD'));
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) values (6, 200000006, 3, 'Bom, mas chegou ligeiramente atrasado.', to_date('2026-06-22', 'YYYY-MM-DD'));
commit;

-- Participações (Crianças distribuídas pelos eventos)
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
commit;

-- Distribuição dos trabalhadores pelos serviços com o respetivo salário recebido
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
commit;
-- Utilização de inventário
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (1, 1, 5); -- Fraldas
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (2, 2, 10); -- Lenços umedecidos
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (3, 4, 2); -- Brinquedos
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (4, 3, 1); -- Leite em pó
insert into Utilizam (id_servico, id_item, quantidade_gasta) values (5, 1, 3); -- Fraldas
commit;

-- ============================================================
-- TESTES AOS TRIGGERS
-- ============================================================

-- 1. Testar trg_check_horas_dormir
-- O Serviço 6 (Babysitting) ocorre entre as 19:00 e as 23:00.
-- Vamos tentar alterar as horas de dormir para as 18:00 (antes do serviço começar).
-- Resultado esperado: Erro ORA-20001
update Babysitting 
set horas_dormir = to_date('2026-06-20 18:00', 'YYYY-MM-DD HH24:MI') 
where id_babysitting = 6;


-- 2. Testar trg_check_stock
-- O item 5 (Material de primeiros socorros) foi inserido com quantidade 30.
-- Vamos tentar gastar 40 num serviço.
-- Resultado esperado: Erro ORA-20002
insert into Utilizam (id_servico, id_item, quantidade_gasta) 
values (6, 5, 40);


-- 3. Testar trg_update_stock
-- Vamos inserir um gasto válido de 5 unidades do item 5 e verificar se o stock baixa de 30 para 25.
insert into Utilizam (id_servico, id_item, quantidade_gasta) 
values (6, 5, 5);

select quantidade as stock_atualizado 
from Inventario 
where id_item = 5;


-- 4. Testar trg_check_valid_payment
-- O Serviço 1 tem o preco_servico definido a 150.00.
-- Vamos tentar pagar apenas 100.00.
-- Resultado esperado: Erro ORA-20003
insert into PagamentoCliente (id_servico, nCC_cliente, valor, metodo, data_pag) 
values (1, 200000001, 100.00, 'MBWay', sysdate);


-- 5. Testar trg_validar_data_avaliacao
-- O Serviço 1 termina dia 2026-06-01 às 18:00.
-- Vamos tentar inserir uma avaliação nesse mesmo dia, mas às 10:00 da manhã.
-- Resultado esperado: Erro ORA-20005
insert into Avaliam (id_servico, nCC_cliente, classificacao, comentario, data_avaliacao) 
values (1, 200000001, 5, 'Muito bom', to_date('2026-06-01 10:00', 'YYYY-MM-DD HH24:MI'));


-- 6. Testar trg_validar_idade_maxima
-- Vamos utilizar a view para tentar inserir uma criança nascida em 2000 (mais de 18 anos).
-- Resultado esperado: Erro ORA-20007
insert into vw_criancas_form (nCC, nome, nCC_cliente, data_nascimento) 
values (300000011, 'João Maior', 200000001, to_date('2000-01-01', 'YYYY-MM-DD'));


-- 7. Testar Triggers INSTEAD OF (Views)
-- Inserir um novo cliente através da view vw_clientes_form.
insert into vw_clientes_form (nCC, nome, email, num_telefone, morada) 
values (200000011, 'Cliente Teste', 'teste@gmail.com', 919999999, 'Rua do Teste');

-- Verificar se a informação foi propagada corretamente pelas 3 tabelas (Pessoas, Adultos e Clientes)
select * from Pessoas where nCC = 200000011;
select * from Adultos where nCC_adulto = 200000011;
select * from Clientes where nCC_cliente = 200000011;


-- 8. Testar trg_impedir_sobreposicao_trabalhador
-- O trabalhador 100000001 já está alocado ao Serviço 1 (2026-06-01 das 14:00 às 18:00).
-- Primeiro, criamos um novo evento (Serviço 7) que se sobrepõe no horário (15:00 às 19:00).
insert into vw_eventos (nCC_cliente, data_servico, local_servico, hora_inicio, hora_fim, preco_servico, tipo_evento)
values (200000001, to_date('2026-06-01', 'YYYY-MM-DD'), 'Local Novo', to_date('2026-06-01 15:00', 'YYYY-MM-DD HH24:MI'), to_date('2026-06-01 19:00', 'YYYY-MM-DD HH24:MI'), 100, 'Reunião');

-- A seguir, tentamos colocar o trabalhador 100000001 neste novo serviço.
-- Resultado esperado: Erro ORA-20004
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) 
values (100000001, 7, 50);


-- 9. Testar trg_check_disponibilidade
-- O trabalhador 100000002 só tem disponibilidade à Terça-feira das 09:00 às 17:00.
-- O Serviço 7 (criado no teste anterior) ocorre a 2026-06-01, que é uma Segunda-feira.
-- Vamos tentar alocar este trabalhador ao Serviço 7.
-- Resultado esperado: Erro ORA-20006
insert into Trabalham (nCC_trabalhador, id_servico, valor_recebido) 
values (100000002, 7, 50);

commit;

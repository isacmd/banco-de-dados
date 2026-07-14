INSERT INTO PESSOA (id_pessoa, nome, cpf, data_nascimento, is_flamengo, telefone) VALUES
 (1,  'Maria Eduarda Souza',    '10101010101', '1985-03-12', TRUE,  '83988887001'),
 (2,  'João Pedro Lima',        '10101010102', '1990-07-22', FALSE, '83988887002'),
 (3,  'Ana Beatriz Fernandes',  '10101010103', '1978-11-05', TRUE,  '83988887003'),
 (4,  'Carlos Eduardo Nunes',   '10101010104', '1965-01-30', FALSE, '83988887004'),
 (5,  'Larissa Alves Costa',    '10101010105', '2001-09-14', TRUE,  '83988887005'),
 (6,  'Renato Barbosa Melo',    '20202020201', '1975-04-18', TRUE,  '83988887006'),
 (7,  'Patrícia Gomes Rocha',   '20202020202', '1980-06-09', FALSE, '83988887007'),
 (8,  'Fábio Henrique Dias',    '20202020203', '1972-12-25', FALSE, '83988887008'),
 (9,  'Camila Ribeiro Pinto',   '20202020204', '1983-02-17', TRUE,  '83988887009'),
 (10, 'Rodrigo Teixeira Alves', '20202020205', '1977-08-03', FALSE, '83988887010'),
 (11, 'Bruna Cavalcante Silva', '30303030301', '1997-05-21', TRUE,  '83988887011'),
 (12, 'Diego Martins Farias',   '30303030302', '1996-10-11', FALSE, '83988887012'),
 (13, 'Isabela Correia Souza',  '30303030303', '1998-01-27', TRUE,  '83988887013'),
 (14, 'Gustavo Henrique Paz',   '30303030304', '1995-03-08', FALSE, '83988887014'),
 (15, 'Yasmin Duarte Lopes',    '30303030305', '1999-12-02', FALSE, '83988887015');

INSERT INTO PACIENTE (id_pessoa, num_convenio, alergias, grupo_sanguineo, endereco) VALUES
 (1, 'CV-00011', 'Dipirona',        'O+',  'Rua das Flores, 120 - João Pessoa/PB'),
 (2, 'CV-00012', NULL,              'A-',  'Av. Epitácio Pessoa, 900 - João Pessoa/PB'),
 (3, 'CV-00013', 'Penicilina',      'AB+', 'Rua José Pinheiro, 45 - João Pessoa/PB'),
 (4, NULL,       NULL,              'B+',  'Rua Silvino Lopes, 300 - João Pessoa/PB'),
 (5, 'CV-00015', 'Látex, Amendoim', 'O-',  'Av. Cabo Branco, 1500 - João Pessoa/PB');

INSERT INTO PROFISSIONAL (id_pessoa, crm, data_admissao, especialidade) VALUES
 (6,  'CRM-PB-1001', '2010-02-01', 'Clínica Médica'),
 (7,  'CRM-PB-1002', '2012-05-15', 'Cirurgia Geral'),
 (8,  'CRM-PB-1003', '2008-09-10', 'Pediatria'),
 (9,  'CRM-PB-1004', '2014-03-20', 'Ortopedia'),
 (10, 'CRM-PB-1005', '2011-07-07', 'Cardiologia'),
 (11, 'CRM-PB-2001', '2023-02-01', 'Clínica Médica'),
 (12, 'CRM-PB-2002', '2022-02-01', 'Cirurgia Geral'),
 (13, 'CRM-PB-2003', '2024-02-01', 'Pediatria'),
 (14, 'CRM-PB-2004', '2023-02-01', 'Ortopedia'),
 (15, 'CRM-PB-2005', '2022-02-01', 'Cardiologia');

INSERT INTO PRECEPTOR (id_profissional, titulacao) VALUES
 (6,  'Doutor'),
 (7,  'Mestre'),
 (8,  'Doutor'),
 (9,  'Especialista'),
 (10, 'Livre-Docente');

INSERT INTO RESIDENTE (id_profissional, ano_residencia) VALUES
 (11, 'R1'),
 (12, 'R2'),
 (13, 'R3'),
 (14, 'R1'),
 (15, 'R2');

INSERT INTO UNIDADE (id_unidade, nome, tipo, capacidade_leitos) VALUES
 (1, 'Enfermaria Ala Norte', 'Enfermaria',     30),
 (2, 'UTI Adulto',           'UTI',            10),
 (3, 'Pronto-Socorro Geral', 'Pronto-Socorro', 20);

INSERT INTO PROCEDIMENTO (id_procedimento, codigo, nome, tempo_medio_minutos, nivel_risco) VALUES
 (1,  'PR001', 'Sutura simples',            20, 'BAIXO'),
 (2,  'PR002', 'Coleta de sangue',          10, 'BAIXO'),
 (3,  'PR003', 'Aplicação de medicação IV', 15, 'MEDIO'),
 (4,  'PR004', 'Intubação orotraqueal',     25, 'ALTO'),
 (5,  'PR005', 'Curativo complexo',         30, 'MEDIO'),
 (6,  'PR006', 'Drenagem torácica',         40, 'ALTO'),
 (7,  'PR007', 'Aferição de sinais vitais',  5, 'BAIXO'),
 (8,  'PR008', 'Punção lombar',             35, 'ALTO'),
 (9,  'PR009', 'Reanimação cardiopulmonar', 20, 'ALTO'),
 (10, 'PR010', 'Aplicação de gesso',        45, 'MEDIO');

INSERT INTO ATENDIMENTO (id_atendimento, data_hora, duracao_minutos, id_paciente, id_residente, id_preceptor) VALUES
 (1,  '2025-03-03 08:15', 30, 1, 11, 6),
 (2,  '2025-03-04 09:40', 45, 2, 12, 7),
 (3,  '2025-03-05 14:10', 25, 3, 13, 8),
 (4,  '2025-03-06 16:30', 60, 4, 14, 9),
 (5,  '2025-03-07 10:05', 20, 5, 15, 10),
 (6,  '2025-03-10 08:50', 35, 1, 12, 7),
 (7,  '2025-03-11 11:20', 50, 2, 11, 6),
 (8,  '2025-03-12 13:45', 40, 3, 14, 9),
 (9,  '2025-03-13 15:00', 55, 4, 13, 8),
 (10, '2025-03-14 07:30', 30, 5, 11, 6);

INSERT INTO PROCEDIMENTO_REALIZADO (id_atendimento, id_procedimento, quantidade, tempo_real_minutos, observacao, faturado) VALUES
 (1,  1, 1, 22, 'Sem intercorrências',                 TRUE),
 (2,  2, 1, 8,  'Coleta sem intercorrências',           TRUE),
 (3,  3, 2, 18, 'Paciente relatou leve desconforto',    FALSE),
 (4,  4, 1, 28, 'Procedimento de emergência',           TRUE),
 (5,  7, 1, 5,  'Rotina',                                TRUE),
 (6,  5, 1, 32, 'Curativo trocado com sucesso',          FALSE),
 (7,  6, 1, 42, 'Drenagem realizada em UTI',             TRUE),
 (8,  9, 1, 25, 'RCP bem-sucedida',                      TRUE),
 (9,  8, 1, 38, 'Sem intercorrências relevantes',        FALSE),
 (10, 10, 1, 48, 'Gesso aplicado após fratura no braço', TRUE);

INSERT INTO ESCALA (id_unidade, dia_semana, turno, id_residente, id_preceptor) VALUES
 (1, 'Segunda', 'Manha', 11, 6),
 (1, 'Terca',   'Tarde', 12, 7),
 (2, 'Quarta',  'Noite', 13, 8),
 (2, 'Quinta',  'Manha', 14, 9),
 (3, 'Sexta',   'Tarde', 15, 10),
 (3, 'Sabado',  'Noite', 11, 6),
 (1, 'Domingo', 'Manha', 12, 7),
 (2, 'Segunda', 'Tarde', 13, 8);

-- Ajuste das sequences (necessário pois os IDs foram inseridos manualmente)
SELECT setval('pessoa_id_pessoa_seq',            (SELECT MAX(id_pessoa) FROM PESSOA));
SELECT setval('unidade_id_unidade_seq',          (SELECT MAX(id_unidade) FROM UNIDADE));
SELECT setval('procedimento_id_procedimento_seq',(SELECT MAX(id_procedimento) FROM PROCEDIMENTO));
SELECT setval('atendimento_id_atendimento_seq',  (SELECT MAX(id_atendimento) FROM ATENDIMENTO));
SELECT setval('escala_id_escala_seq',            (SELECT MAX(id_escala) FROM ESCALA));
-- 1) Inserir um novo atendimento
INSERT INTO ATENDIMENTO (data_hora, duracao_minutos, id_paciente, id_residente, id_preceptor)
SELECT '2025-03-20 09:00'::timestamp, 30, 2, 12, 7
WHERE EXISTS (SELECT 1 FROM PACIENTE   WHERE id_pessoa       = 2)
  AND EXISTS (SELECT 1 FROM RESIDENTE  WHERE id_profissional = 12)
  AND EXISTS (SELECT 1 FROM PRECEPTOR  WHERE id_profissional = 7)
RETURNING id_atendimento;

-- 2) Listar todos os atendimentos de um paciente específico, ordenados por data.
SELECT
    a.id_atendimento,
    a.data_hora,
    a.duracao_minutos,
    res.nome AS residente,
    prec.nome AS preceptor
FROM ATENDIMENTO a
JOIN PESSOA res  ON res.id_pessoa  = a.id_residente
JOIN PESSOA prec ON prec.id_pessoa = a.id_preceptor
WHERE a.id_paciente = 1
ORDER BY a.data_hora;

-- 3) Listar os procedimentos realizados em um atendimento (com nome do procedimento, quantidade e tempo real).
SELECT
    proc.nome           AS procedimento,
    pr.quantidade,
    pr.tempo_real_minutos,
    pr.observacao
FROM PROCEDIMENTO_REALIZADO pr
JOIN PROCEDIMENTO proc ON proc.id_procedimento = pr.id_procedimento
WHERE pr.id_atendimento = 3;

-- 4) Atualizar os dados de um paciente 
UPDATE PACIENTE
SET endereco     = 'Rua Rio Grande do Norte, 88 - João Pessoa/PB',
    num_convenio = 'CV-00099'
WHERE id_pessoa = 2;

-- 5) Remover um procedimento realizado 
DELETE FROM PROCEDIMENTO_REALIZADO
WHERE id_atendimento  = 3
  AND id_procedimento = 3
  AND faturado = FALSE;

-- 6) Calcular o tempo médio de duração dos atendimentos por residente.
SELECT
    pe.nome AS residente,
    ROUND(AVG(a.duracao_minutos), 2) AS tempo_medio_minutos,
    COUNT(*) AS total_atendimentos
FROM ATENDIMENTO a
JOIN PESSOA pe ON pe.id_pessoa = a.id_residente
GROUP BY pe.nome
ORDER BY tempo_medio_minutos DESC;
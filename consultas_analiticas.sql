-- 1) Ranking dos residentes por número de atendimentos realizados (nome e total).
SELECT
    pe.nome AS residente,
    COUNT(a.id_atendimento) AS total_atendimentos,
    RANK() OVER (ORDER BY COUNT(a.id_atendimento) DESC) AS posicao
FROM RESIDENTE r
JOIN PESSOA pe ON pe.id_pessoa = r.id_profissional
LEFT JOIN ATENDIMENTO a ON a.id_residente = r.id_profissional
GROUP BY pe.nome
ORDER BY total_atendimentos DESC;

-- 2) Preceptores que supervisionaram mais de 5 atendimentos em um determinado mês (exemplo: março de 2025)
SELECT
    pe.nome AS preceptor,
    COUNT(*) AS total_atendimentos_mes
FROM ATENDIMENTO a
JOIN PESSOA pe ON pe.id_pessoa = a.id_preceptor
WHERE a.data_hora >= DATE '2025-03-01'
  AND a.data_hora <  DATE '2025-04-01'
GROUP BY pe.nome
HAVING COUNT(*) > 5;

-- 3) A consulta abaixo agrega os plantões cadastrados por unidade/residente; a evolução para escalas com data efetiva (ou geração automática de ocorrências mensais a partir do padrão semanal) fica registrada como melhoria futura
SELECT
    u.nome  AS unidade,
    pe.nome AS residente,
    COUNT(*) AS total_plantoes
FROM ESCALA e
JOIN UNIDADE u ON u.id_unidade = e.id_unidade
JOIN PESSOA pe ON pe.id_pessoa = e.id_residente
GROUP BY u.nome, pe.nome
ORDER BY u.nome, total_plantoes DESC;

-- 4) Pacientes que nunca realizaram nenhum procedimento de nível de risco 'ALTO'.
SELECT pe.nome AS paciente
FROM PACIENTE p
JOIN PESSOA pe ON pe.id_pessoa = p.id_pessoa
WHERE NOT EXISTS (
    SELECT 1
    FROM ATENDIMENTO a
    JOIN PROCEDIMENTO_REALIZADO pr ON pr.id_atendimento = a.id_atendimento
    JOIN PROCEDIMENTO proc         ON proc.id_procedimento = pr.id_procedimento
    WHERE a.id_paciente = p.id_pessoa
      AND proc.nivel_risco = 'ALTO'
);
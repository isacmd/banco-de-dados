# SISTEMA DE GESTÃO HOSPITALAR - ETAPA 1

projeto de banco de dados I. implementação do modelo relacional básico,
operações CRUD e consultas essenciais em **SQL puro** (sem ORM), conforme
especificação da etapa 1.

## Estrutura de arquivos

| Arquivo | Conteúdo |
|---|---|
| `Etapa1_Sistema_Gestao_Hospitalar.docx` | Relatório completo: modelagem conceitual, DER, modelo relacional, justificativa de normalização (1FN/2FN/3FN/BCNF), scripts e consultas comentadas |
| `der.png` | Diagrama entidade-relacionamento |
| `schema.sql` | Script de criação de todas as tabelas, com constraints PK, FK, CHECK, NOT NULL e UNIQUE |
| `dados_teste.sql` | Massa de dados mínima exigida (5 pacientes, 5 residentes, 5 preceptores, 3 unidades, 10 atendimentos, 10 procedimentos realizados) |
| `consultas_basicas.sql` | As 6 operações de CRUD/consulta básica exigidas |
| `consultas_analiticas.sql` | As 4 consultas analíticas exigidas |

## Pré-requisitos

- postgreSQL 13 ou superior
- cliente `psql` ou qualquer IDE de banco (DBeaver, pgAdmin, TablePlus etc.)

## Instalação e execução

1. Criar um banco de dados vazio:
   ```bash
   createdb hospital_yuska
   ```

2. Executar o script de criação das tabelas:
   ```bash
   psql -d hospital_yuska -f schema.sql
   ```

3. Popular com os dados de teste:
   ```bash
   psql -d hospital_yuska -f dados_teste.sql
   ```

4. Executar as consultas básicas e analíticas:
   ```bash
   psql -d hospital_yuska -f consultas_basicas.sql
   psql -d hospital_yuska -f consultas_analiticas.sql
   ```

   Ou, para ver os resultados formatados no terminal interativo:
   ```bash
   psql -d hospital_yuska
   \i consultas_basicas.sql
   \i consultas_analiticas.sql
   ```

### Observação importante

`consultas_basicas.sql` contém um `INSERT` de exemplo (item 6.1) e um `DELETE`
de exemplo (item 6.5). Rodar o arquivo mais de uma vez altera o estado da
massa de teste, em especial, o `DELETE` remove definitivamente a linha
`(3,3)` de `PROCEDIMENTO_REALIZADO` na primeira execução. Para repetir os
testes do zero:

```bash
dropdb hospital_yuska
createdb hospital_yuska
psql -d hospital_yuska -f schema.sql
psql -d hospital_yuska -f dados_teste.sql
```

## Resumo do modelo

- **PESSOA** é especializada em **PACIENTE** e **PROFISSIONAL** (especialização parcial).
- **PROFISSIONAL** é especializada em **PRECEPTOR** e **RESIDENTE** (especialização disjunta e parcial — um profissional nunca é os dois papéis ao mesmo tempo).
- **ATENDIMENTO** liga exatamente um paciente, um residente e um preceptor.
- **PROCEDIMENTO_REALIZADO** resolve o relacionamento N:M entre **ATENDIMENTO** e **PROCEDIMENTO**.
- **ESCALA** liga unidade, dia da semana, turno, residente e preceptor, com a restrição `UNIQUE(id_unidade, dia_semana, turno, id_residente)` garantindo que não haja um mesmo residente, no mesmo local/dia/turno, com dois preceptores distintos.

Detalhes de justificativa de cardinalidade, especialização e normalização
estão no arquivo `Etapa1_Sistema_Gestao_Hospitalar.docx` (seções 1 a 3).

## Limitação conhecida / trabalhos futuros

`ESCALA` modela um padrão semanal recorrente (`dia_semana` + `turno`), sem
coluna de data de calendário — por isso não é possível filtrar plantões
literalmente por "mês corrente" com o esquema atual. Essa e outras evoluções
(stored procedures, triggers, views, migração para ORM) ficam para a Etapa 2.
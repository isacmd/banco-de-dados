CREATE TABLE PESSOA (
    id_pessoa           SERIAL PRIMARY KEY,
    nome                VARCHAR(150) NOT NULL,
    cpf                 CHAR(11)     NOT NULL UNIQUE,
    data_nascimento     DATE         NOT NULL,
    is_flamengo         BOOLEAN      NOT NULL DEFAULT FALSE,
    telefone            VARCHAR(20),
    CONSTRAINT chk_pessoa_cpf_formato CHECK (cpf ~ '^[0-9]{11}$'),
    CONSTRAINT chk_pessoa_nascimento  CHECK (data_nascimento <= CURRENT_DATE)
);

CREATE TABLE PACIENTE (
    id_pessoa           INTEGER PRIMARY KEY REFERENCES PESSOA(id_pessoa) ON DELETE CASCADE,
    num_convenio        VARCHAR(30),
    alergias            TEXT,
    grupo_sanguineo     VARCHAR(3) CHECK (grupo_sanguineo IN ('A+','A-','B+','B-','AB+','AB-','O+','O-')),
    endereco            VARCHAR(200)
);

CREATE TABLE PROFISSIONAL (
    id_pessoa           INTEGER PRIMARY KEY REFERENCES PESSOA(id_pessoa) ON DELETE CASCADE,
    crm                 VARCHAR(20)  NOT NULL UNIQUE,
    data_admissao       DATE         NOT NULL,
    especialidade       VARCHAR(100) NOT NULL
);

CREATE TABLE PRECEPTOR (
    id_profissional      INTEGER PRIMARY KEY REFERENCES PROFISSIONAL(id_pessoa) ON DELETE CASCADE,
    titulacao            VARCHAR(50) NOT NULL
                         CHECK (titulacao IN ('Especialista','Mestre','Doutor','Livre-Docente'))
);

CREATE TABLE RESIDENTE (
    id_profissional      INTEGER PRIMARY KEY REFERENCES PROFISSIONAL(id_pessoa) ON DELETE CASCADE,
    ano_residencia       VARCHAR(2) NOT NULL CHECK (ano_residencia IN ('R1','R2','R3'))
);

CREATE TABLE UNIDADE (
    id_unidade           SERIAL PRIMARY KEY,
    nome                 VARCHAR(100) NOT NULL,
    tipo                 VARCHAR(30)  NOT NULL
                         CHECK (tipo IN ('Enfermaria','UTI','Pronto-Socorro','Ambulatorio')),
    capacidade_leitos    INTEGER NOT NULL CHECK (capacidade_leitos > 0)
);

CREATE TABLE ATENDIMENTO (
    id_atendimento       SERIAL PRIMARY KEY,
    data_hora            TIMESTAMP NOT NULL,
    duracao_minutos      INTEGER   NOT NULL CHECK (duracao_minutos > 0),
    id_paciente          INTEGER   NOT NULL REFERENCES PACIENTE(id_pessoa),
    id_residente         INTEGER   NOT NULL REFERENCES RESIDENTE(id_profissional),
    id_preceptor         INTEGER   NOT NULL REFERENCES PRECEPTOR(id_profissional)
);

CREATE INDEX idx_atendimento_paciente  ON ATENDIMENTO(id_paciente);
CREATE INDEX idx_atendimento_residente ON ATENDIMENTO(id_residente);
CREATE INDEX idx_atendimento_data      ON ATENDIMENTO(data_hora);

CREATE TABLE PROCEDIMENTO (
    id_procedimento       SERIAL PRIMARY KEY,
    codigo                VARCHAR(20)  NOT NULL UNIQUE,
    nome                  VARCHAR(150) NOT NULL,
    tempo_medio_minutos   INTEGER      NOT NULL CHECK (tempo_medio_minutos > 0),
    nivel_risco           VARCHAR(10)  NOT NULL DEFAULT 'BAIXO'
                          CHECK (nivel_risco IN ('BAIXO','MEDIO','ALTO'))
);

CREATE TABLE PROCEDIMENTO_REALIZADO (
    id_atendimento        INTEGER NOT NULL REFERENCES ATENDIMENTO(id_atendimento) ON DELETE CASCADE,
    id_procedimento       INTEGER NOT NULL REFERENCES PROCEDIMENTO(id_procedimento),
    quantidade            INTEGER NOT NULL CHECK (quantidade > 0),
    tempo_real_minutos    INTEGER NOT NULL CHECK (tempo_real_minutos > 0),
    observacao            TEXT,
    faturado              BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id_atendimento, id_procedimento)
);

CREATE TABLE ESCALA (
    id_escala             SERIAL PRIMARY KEY,
    id_unidade            INTEGER NOT NULL REFERENCES UNIDADE(id_unidade),
    dia_semana            VARCHAR(10) NOT NULL
                          CHECK (dia_semana IN ('Segunda','Terca','Quarta','Quinta','Sexta','Sabado','Domingo')),
    turno                 VARCHAR(10) NOT NULL CHECK (turno IN ('Manha','Tarde','Noite')),
    id_residente          INTEGER NOT NULL REFERENCES RESIDENTE(id_profissional),
    id_preceptor          INTEGER NOT NULL REFERENCES PRECEPTOR(id_profissional),
    CONSTRAINT uq_escala_unica UNIQUE (id_unidade, dia_semana, turno, id_residente)
);

CREATE INDEX idx_escala_residente ON ESCALA(id_residente);
CREATE INDEX idx_escala_preceptor ON ESCALA(id_preceptor);
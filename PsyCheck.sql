CREATE TABLE agenda_medico (
    cod_agenda                   NUMBER NOT NULL,
    data_disponibilidade         DATE,
    hora_inicio_disponibilidade  DATE,
    hora_termino_disponibilidade DATE,
    status_disponibilidade       VARCHAR2(20),
    intervalo                    DATE,
    medico_cod_medico            NUMBER NOT NULL
);

CREATE UNIQUE INDEX agenda_medico__idx ON
    agenda_medico (
        medico_cod_medico
    ASC );

ALTER TABLE agenda_medico ADD CONSTRAINT agenda_medico_pk PRIMARY KEY ( cod_agenda );

CREATE TABLE agendamento (
    cod_agendamento          NUMBER NOT NULL,
    data_agendamento         DATE,
    hora_agendamento         DATE,
    status                   VARCHAR2(20),
    observacoes              VARCHAR2(30),
    agenda_medico_cod_agenda NUMBER NOT NULL,
    paciente_cod_paciente    NUMBER NOT NULL
);

ALTER TABLE agendamento
    ADD CONSTRAINT agendamento_pk PRIMARY KEY ( cod_agendamento,
                                                agenda_medico_cod_agenda,
                                                paciente_cod_paciente );

CREATE TABLE avaliacao (
    cod_avaliacao     NUMBER NOT NULL,
    nota              NUMBER,
    comentario        VARCHAR2(30),
    data              DATE,
    medico_cod_medico NUMBER NOT NULL
);

ALTER TABLE avaliacao ADD CONSTRAINT avaliacao_pk PRIMARY KEY ( cod_avaliacao );

CREATE TABLE bairro (
    cod_bairro        NUMBER NOT NULL,
    nome              VARCHAR2(30),
    cidade_cod_cidade NUMBER NOT NULL
);

ALTER TABLE bairro ADD CONSTRAINT bairro_pk PRIMARY KEY ( cod_bairro );

CREATE TABLE cidade (
    cod_cidade        NUMBER NOT NULL,
    nome              VARCHAR2(30),
    estado_cod_estado NUMBER NOT NULL,
    cod_ibge          NUMBER
);

ALTER TABLE cidade ADD CONSTRAINT cidade_pk PRIMARY KEY ( cod_cidade );

CREATE TABLE diagnostico (
    cod_diagnostico     NUMBER NOT NULL,
    data_geracao        DATE,
    resultado           VARCHAR2(200),
    observacao          VARCHAR2(30),
    segmento_acao       VARCHAR2(30),
    triagem_cod_triagem NUMBER NOT NULL,
    medico_cod_medico   NUMBER NOT NULL
);

CREATE UNIQUE INDEX diagnostico__idx ON
    diagnostico (
        triagem_cod_triagem
    ASC );

ALTER TABLE diagnostico ADD CONSTRAINT diagnostico_pk PRIMARY KEY ( cod_diagnostico );

CREATE TABLE endereco (
    cod_endereco      NUMBER NOT NULL,
    cep               NUMBER,
    logradouro        VARCHAR2(30),
    numero            NUMBER,
    complemento       VARCHAR2(30),
    pessoa_cod_pessoa NUMBER NOT NULL,
    bairro_cod_bairro NUMBER NOT NULL
);

ALTER TABLE endereco ADD CONSTRAINT endereco_pk PRIMARY KEY ( cod_endereco );

CREATE TABLE especialidade (
    cod_especialidade NUMBER NOT NULL,
    especialidade     VARCHAR2(50),
    medico_cod_medico NUMBER NOT NULL
);

ALTER TABLE especialidade ADD CONSTRAINT especialidade_pk PRIMARY KEY ( cod_especialidade );

CREATE TABLE estado (
    cod_estado    NUMBER NOT NULL,
    nome          CHAR(2),
    pais_cod_pais NUMBER NOT NULL
);

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( cod_estado );

CREATE TABLE genero (
    cod_genero NUMBER NOT NULL,
    genero     VARCHAR2(20)
);

ALTER TABLE genero ADD CONSTRAINT genero_pk PRIMARY KEY ( cod_genero );

CREATE TABLE medico (
    cod_medico        NUMBER NOT NULL,
    crp               VARCHAR2(20),
    pessoa_fisica_cpf NUMBER NOT NULL
);

CREATE UNIQUE INDEX medico__idx ON
    medico (
        pessoa_fisica_cpf
    ASC );

ALTER TABLE medico ADD CONSTRAINT medico_pk PRIMARY KEY ( cod_medico );

CREATE TABLE paciente (
    cod_paciente      NUMBER NOT NULL,
    historico         VARCHAR2(30),
    num_seguro_saude  NUMBER,
    pessoa_fisica_cpf NUMBER NOT NULL
);

CREATE UNIQUE INDEX paciente__idx ON
    paciente (
        pessoa_fisica_cpf
    ASC );

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( cod_paciente );

CREATE TABLE pais (
    cod_pais NUMBER NOT NULL,
    nome     VARCHAR2(30)
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( cod_pais );

CREATE TABLE pessoa (
    cod_pessoa        NUMBER NOT NULL,
    nome              VARCHAR2(30),
    email             VARCHAR2(30),
    soft_delete       CHAR(1),
    usuario           VARCHAR2(30),
    senha             VARCHAR2(30),
    pessoa_fisica_cpf NUMBER NOT NULL
);

CREATE UNIQUE INDEX pessoa__idx ON
    pessoa (
        pessoa_fisica_cpf
    ASC );

ALTER TABLE pessoa ADD CONSTRAINT pessoa_pk PRIMARY KEY ( cod_pessoa );

CREATE TABLE pessoa_fisica (
    data_nasc         DATE,
    cpf               NUMBER NOT NULL,
    genero_cod_genero NUMBER NOT NULL
);

CREATE UNIQUE INDEX pessoa_fisica__idx ON
    pessoa_fisica (
        genero_cod_genero
    ASC );

ALTER TABLE pessoa_fisica ADD CONSTRAINT pessoa_fisica_pk PRIMARY KEY ( cpf );

CREATE TABLE questionario (
    cod_questionario NUMBER NOT NULL,
    titulo           VARCHAR2(30),
    descricao        VARCHAR2(30),
    perguntas        VARCHAR2(250),
    categoria        VARCHAR2(30),
    nome_criador     VARCHAR2(30),
    duracao          DATE
);

ALTER TABLE questionario ADD CONSTRAINT questionario_pk PRIMARY KEY ( cod_questionario );

CREATE TABLE recomendacao (
    cod_recomendacao            NUMBER NOT NULL,
    recomendacao                VARCHAR2(30),
    diagnostico_cod_diagnostico NUMBER NOT NULL
);

ALTER TABLE recomendacao ADD CONSTRAINT recomendacao_pk PRIMARY KEY ( cod_recomendacao );

CREATE TABLE telefone (
    cod_telefone      NUMBER NOT NULL,
    numero            NUMBER,
    ddd               NUMBER,
    pessoa_cod_pessoa NUMBER NOT NULL
);

ALTER TABLE telefone ADD CONSTRAINT telefone_pk PRIMARY KEY ( cod_telefone );

CREATE TABLE triagem (
    cod_triagem                   NUMBER NOT NULL,
    inicio                        DATE,
    fim                           DATE,
    duracao                       DATE,
    respostas                     VARCHAR2(30),
    paciente_cod_paciente         NUMBER NOT NULL,
    questionario_cod_questionario NUMBER NOT NULL
);

CREATE UNIQUE INDEX triagem__idx ON
    triagem (
        questionario_cod_questionario
    ASC );

ALTER TABLE triagem ADD CONSTRAINT triagem_pk PRIMARY KEY ( cod_triagem );

ALTER TABLE agenda_medico
    ADD CONSTRAINT agenda_medico_medico_fk FOREIGN KEY ( medico_cod_medico )
        REFERENCES medico ( cod_medico );

ALTER TABLE agendamento
    ADD CONSTRAINT agendamento_agenda_medico_fk FOREIGN KEY ( agenda_medico_cod_agenda )
        REFERENCES agenda_medico ( cod_agenda );

ALTER TABLE agendamento
    ADD CONSTRAINT agendamento_paciente_fk FOREIGN KEY ( paciente_cod_paciente )
        REFERENCES paciente ( cod_paciente );

ALTER TABLE avaliacao
    ADD CONSTRAINT avaliacao_medico_fk FOREIGN KEY ( medico_cod_medico )
        REFERENCES medico ( cod_medico );

ALTER TABLE bairro
    ADD CONSTRAINT bairro_cidade_fk FOREIGN KEY ( cidade_cod_cidade )
        REFERENCES cidade ( cod_cidade );

ALTER TABLE cidade
    ADD CONSTRAINT cidade_estado_fk FOREIGN KEY ( estado_cod_estado )
        REFERENCES estado ( cod_estado );

ALTER TABLE diagnostico
    ADD CONSTRAINT diagnostico_medico_fk FOREIGN KEY ( medico_cod_medico )
        REFERENCES medico ( cod_medico );

ALTER TABLE diagnostico
    ADD CONSTRAINT diagnostico_triagem_fk FOREIGN KEY ( triagem_cod_triagem )
        REFERENCES triagem ( cod_triagem );

ALTER TABLE endereco
    ADD CONSTRAINT endereco_bairro_fk FOREIGN KEY ( bairro_cod_bairro )
        REFERENCES bairro ( cod_bairro );

ALTER TABLE endereco
    ADD CONSTRAINT endereco_pessoa_fk FOREIGN KEY ( pessoa_cod_pessoa )
        REFERENCES pessoa ( cod_pessoa );

ALTER TABLE especialidade
    ADD CONSTRAINT especialidade_medico_fk FOREIGN KEY ( medico_cod_medico )
        REFERENCES medico ( cod_medico );

ALTER TABLE estado
    ADD CONSTRAINT estado_pais_fk FOREIGN KEY ( pais_cod_pais )
        REFERENCES pais ( cod_pais );

ALTER TABLE medico
    ADD CONSTRAINT medico_pessoa_fisica_fk FOREIGN KEY ( pessoa_fisica_cpf )
        REFERENCES pessoa_fisica ( cpf );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_pessoa_fisica_fk FOREIGN KEY ( pessoa_fisica_cpf )
        REFERENCES pessoa_fisica ( cpf );

ALTER TABLE pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_genero_fk FOREIGN KEY ( genero_cod_genero )
        REFERENCES genero ( cod_genero );

ALTER TABLE pessoa
    ADD CONSTRAINT pessoa_pessoa_fisica_fk FOREIGN KEY ( pessoa_fisica_cpf )
        REFERENCES pessoa_fisica ( cpf );

ALTER TABLE recomendacao
    ADD CONSTRAINT recomendacao_diagnostico_fk FOREIGN KEY ( diagnostico_cod_diagnostico )
        REFERENCES diagnostico ( cod_diagnostico );

ALTER TABLE telefone
    ADD CONSTRAINT telefone_pessoa_fk FOREIGN KEY ( pessoa_cod_pessoa )
        REFERENCES pessoa ( cod_pessoa );

ALTER TABLE triagem
    ADD CONSTRAINT triagem_paciente_fk FOREIGN KEY ( paciente_cod_paciente )
        REFERENCES paciente ( cod_paciente );

ALTER TABLE triagem
    ADD CONSTRAINT triagem_questionario_fk FOREIGN KEY ( questionario_cod_questionario )
        REFERENCES questionario ( cod_questionario );


--Genero--
DECLARE
    COD_GENERO   NUMBER(10) := &COD_GENERO;
    GENERO       VARCHAR2(20) := '& GENERO';   
BEGIN
    BEGIN
        INSERT INTO genero
        VALUES (COD_GENERO, GENERO   );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Pessoa_fisica--
DECLARE
    DATA_NASC   DATE := '& DATA_NASC';
    CPF        NUMBER := &CPF;   
    GENERO_COD_GENERO NUMBER := &GENERO_COD_GENERO;   
BEGIN
    BEGIN
        INSERT INTO pessoa_fisica
        VALUES (DATA_NASC,CPF, GENERO_COD_GENERO);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Pessoa--
DECLARE
    COD_PESSOA NUMBER := &COD_PESSOA;
    NOME       VARCHAR2(30) := '&NOME';   
    EMAIL      VARCHAR2(30) := '&EMAIL';
    SOFT_DELETE CHAR(1) := '&SOFT_DELETE';
    USUARIO  VARCHAR2(30) := '&USUARIO ';
    SENHA  VARCHAR2(30) := '&SENHA';
    PESSOA_FISICA_CPF NUMBER  := &PESSOA_FISICA_CPF;
BEGIN
    BEGIN
        INSERT INTO pessoa
        VALUES (COD_PESSOA, NOME, EMAIL, SOFT_DELETE, USUARIO, SENHA,PESSOA_FISICA_CPF );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Telefone--
DECLARE
    COD_TELEFONE  NUMBER := &COD_TELEFONE;
    NUMERO        NUMBER := &NUMERO;   
    DDD           NUMBER   := &DDD ;
    PESSOA_COD_PESSOA NUMBER := &PESSOA_COD_PESSOA;
BEGIN
    BEGIN
        INSERT INTO telefone
        VALUES (COD_TELEFONE, NUMERO, DDD, PESSOA_COD_PESSOA);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Pais--
DECLARE
    COD_PAIS   NUMBER := &COD_PAIS ;
    NOME       VARCHAR2(30)  := '&NOME' ;   
BEGIN
    BEGIN
        INSERT INTO pais
        VALUES (COD_PAIS, NOME);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Estado--
DECLARE
    COD_ESTADO   NUMBER := &COD_ESTADO ;
    NOME       VARCHAR2(30)  := '&NOME' ; 
    PAIS_COD_PAIS NUMBER   := &PAIS_COD_PAIS ; 
BEGIN
    BEGIN
        INSERT INTO estado
        VALUES (COD_ESTADO, NOME, PAIS_COD_PAIS);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Cidade--
DECLARE
    COD_CIDADE     NUMBER := &COD_CIDADE   ;
    NOME       VARCHAR2(30)  := '&NOME' ; 
    ESTADO_COD_ESTADO NUMBER   := &ESTADO_COD_ESTADO; 
    COD_IBGE   NUMBER   := &COD_IBGE; 
BEGIN
    BEGIN
        INSERT INTO cidade
        VALUES (COD_CIDADE, NOME,ESTADO_COD_ESTADO, COD_IBGE);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Bairro--
DECLARE
    COD_BAIRRO     NUMBER := &COD_BAIRRO;
    NOME       VARCHAR2(30)  := '&NOME'; 
    CIDADE_COD_CIDADE NUMBER   := &CIDADE_COD_CIDADE; 
BEGIN
    BEGIN
        INSERT INTO bairro
        VALUES (COD_BAIRRO, NOME, CIDADE_COD_CIDADE );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Endereco--
DECLARE
    COD_ENDERECO   NUMBER := &COD_ENDERECO ;
    CEP        NUMBER := &CEP;   
    LOGRADOURO   VARCHAR2(30) := '&LOGRADOURO';
    NUMERO   NUMBER := &NUMERO;
    COMPLEMENTO  VARCHAR2(30) := '&COMPLEMENTO';
    PESSOA_COD_PESSOA  NUMBER := &PESSOA_COD_PESSOA;
    BAIRRO_COD_BAIRRO  NUMBER := &BAIRRO_COD_BAIRRO;
BEGIN
    BEGIN
        INSERT INTO endereco
        VALUES (COD_ENDERECO, CEP, LOGRADOURO,NUMERO, COMPLEMENTO, PESSOA_COD_PESSOA, BAIRRO_COD_BAIRRO );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Medico--
DECLARE
    COD_MEDICO      NUMBER := &COD_MEDICO;
    CRP        VARCHAR2(20)  := '&CRP'; 
    PESSOA_FISICA_CPF NUMBER  := &PESSOA_FISICA_CPF; 
BEGIN
    BEGIN
        INSERT INTO medico
        VALUES ( COD_MEDICO, CRP, PESSOA_FISICA_CPF  );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Especialidade--
DECLARE
    COD_ESPECIALIDADE   NUMBER := &COD_ESPECIALIDADE;
    ESPECIALIDADE        VARCHAR2(20)  := '&ESPECIALIDADE'; 
    MEDICO_COD_MEDICO NUMBER  := &MEDICO_COD_MEDICO; 
BEGIN
    BEGIN
        INSERT INTO especialidade
        VALUES (COD_ESPECIALIDADE,ESPECIALIDADE ,MEDICO_COD_MEDICO);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Avaliacao--
DECLARE
    COD_AVALIACAO NUMBER := &COD_AVALIACAO ;
    NOTA         NUMBER   := &NOTA; 
    COMENTARIO   VARCHAR2(30)  := '&COMENTARIO'; 
    DATA   date  := '&DATA'; 
    MEDICO_COD_MEDICO   NUMBER  := &MEDICO_COD_MEDICO; 
BEGIN
    BEGIN
        INSERT INTO avaliacao
        VALUES (COD_AVALIACAO, NOTA, COMENTARIO,  DATA , MEDICO_COD_MEDICO  );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Agenda_medico--
DECLARE
    COD_AGENDA   NUMBER(10) := &cod_agenda;
    DATA_DISPONIBILIDADE    date := '&DATA_DISPONIBILIDADE';   
    HORA_INICIO_DISPONIBILIDADE date := '&HORA_INICIO_DISPONIBILIDADE';
    HORA_TERMINO_DISPONIBILIDADE  date := '&HORA_TERMINO_DISPONIBILIDADE';
    STATUS_DISPONIBILIDADE    varchar(20) := '&STATUS_DISPONIBILIDADE ';
    INTERVALO  date := '&Intervalo';
    MEDICO_COD_MEDICO   number := &COD_MEDICO;
BEGIN
    BEGIN
        INSERT INTO agenda_medico
        VALUES (COD_AGENDA,DATA_DISPONIBILIDADE,HORA_INICIO_DISPONIBILIDADE,HORA_TERMINO_DISPONIBILIDADE, STATUS_DISPONIBILIDADE,INTERVALO, MEDICO_COD_MEDICO );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Paciente--
DECLARE
    COD_PACIENTE     NUMBER := &COD_PACIENTE;
    HISTORICO     VARCHAR2(30)  := '&HISTORICO ';   
    NUM_SEGURO_SAUDE     NUMBER   := '&NUM_SEGURO_SAUDE';
    PESSOA_FISICA_CPF   NUMBER   := '&PESSOA_FISICA_CPF';
BEGIN
    BEGIN
        INSERT INTO paciente
        VALUES (COD_PACIENTE, HISTORICO, NUM_SEGURO_SAUDE, PESSOA_FISICA_CPF    );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/


--Agendamento--
DECLARE
    COD_AGENDAMENTO     NUMBER := &COD_AGENDAMENTO;
    DATA_AGENDAMENTO    date := '&DATA_AGENDAMENTO';   
    HORA_AGENDAMENTO  date := '&HORA_AGENDAMENTO ';
    STATUS  VARCHAR2(20) := '&STATUS';
    OBSERVACOES  varchar(30) := '&OBSERVACOES';
    AGENDA_MEDICO_COD_AGENDA  number := &AGENDA_MEDICO_COD_AGENDA;
    PACIENTE_COD_PACIENTE   number := &PACIENTE_COD_PACIENTE;
BEGIN
    BEGIN
        INSERT INTO agendamento
        VALUES (COD_AGENDAMENTO,DATA_AGENDAMENTO, HORA_AGENDAMENTO, STATUS, OBSERVACOES, AGENDA_MEDICO_COD_AGENDA, PACIENTE_COD_PACIENTE );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Questionario--
DECLARE
    COD_QUESTIONARIO   NUMBER := &COD_QUESTIONARIO;
    TITULO     VARCHAR2(30) := '&TITULO';   
    DESCRICAO  VARCHAR2(30) := '&DESCRICAO';
    PERGUNTAS  VARCHAR2(250) := '&PERGUNTAS';
    CATEGORIA  varchar(30) := '&CATEGORIA';
    NOME_CRIADOR VARCHAR2(30) := '&NOME_CRIADOR';
    DURACAO    date := '&DURACAO ';
BEGIN
    BEGIN
        INSERT INTO questionario
        VALUES (COD_QUESTIONARIO,TITULO, DESCRICAO, PERGUNTAS,CATEGORIA, NOME_CRIADOR, DURACAO);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Triagem--
DECLARE
    COD_TRIAGEM   NUMBER := &COD_TRIAGEM;
    INICIO      date := '&INICIO';   
    FIM  date := '&FIM';
    DURACAO   date := '&DURACAO';
    RESPOSTAS  varchar(30) := '&RESPOSTAS';
    PACIENTE_COD_PACIENTE number := &PACIENTE_COD_PACIENTE;
    QUESTIONARIO_COD_QUESTIONARIO  number := &QUESTIONARIO_COD_QUESTIONARIO;
BEGIN
    BEGIN
        INSERT INTO triagem
        VALUES (COD_TRIAGEM,INICIO ,FIM, DURACAO, RESPOSTAS, PACIENTE_COD_PACIENTE, QUESTIONARIO_COD_QUESTIONARIO );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Diagnostico--
DECLARE
    COD_DIAGNOSTICO   NUMBER := &COD_DIAGNOSTICO;
    DATA_GERACAO      date := '&DATA_GERACAO';   
    RESULTADO   varchar2(100) := '&RESULTADO ';
    OBSERVACAO    varchar2(30) := '&OBSERVACAO ';
    SEGMENTO_ACAO    varchar2(30) := '&SEGMENTO_ACAO  ';
    TRIAGEM_COD_TRIAGEM number := &TRIAGEM_COD_TRIAGEM;
    MEDICO_COD_MEDICO   number := &MEDICO_COD_MEDICO ;
BEGIN
    BEGIN
        INSERT INTO diagnostico
        VALUES (COD_DIAGNOSTICO, DATA_GERACAO, RESULTADO, OBSERVACAO, SEGMENTO_ACAO,TRIAGEM_COD_TRIAGEM, MEDICO_COD_MEDICO);
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--recomendacao--
DECLARE
    COD_RECOMENDACAO   NUMBER := &COD_RECOMENDACAO;
    RECOMENDACAO       varchar2(30) := '&RECOMENDACAO';   
    DIAGNOSTICO_COD_DIAGNOSTICO   number := &DIAGNOSTICO_COD_DIAGNOSTICO;
BEGIN
    BEGIN
        INSERT INTO recomendacao
        VALUES (COD_RECOMENDACAO, RECOMENDACAO,DIAGNOSTICO_COD_DIAGNOSTICO );
 
        DBMS_OUTPUT.PUT_LINE('Registro de farmácia inserido com sucesso.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Dados repetidos.');
    END;
END;
/

--Relatorio 1--
DECLARE
   -- Declaração de variáveis para cursor
   v_cod_especialidade NUMBER;
   v_especialidade      VARCHAR2(50);
   v_cod_medico         NUMBER;
BEGIN
   -- Abertura do cursor para a tabela especialidade
   FOR especialidade_rec IN (SELECT es.cod_especialidade, es.especialidade, es.medico_cod_medico
                             FROM especialidade es)
   LOOP
      -- Atribuição de valores às variáveis
      v_cod_especialidade := especialidade_rec.cod_especialidade;
      v_especialidade      := especialidade_rec.especialidade;
      v_cod_medico         := especialidade_rec.medico_cod_medico;

      -- Impressão dos resultados ou processamento adicional
      DBMS_OUTPUT.PUT_LINE('Código da Especialidade: ' || v_cod_especialidade);
      DBMS_OUTPUT.PUT_LINE('Especialidade: ' || v_especialidade);
      DBMS_OUTPUT.PUT_LINE('Código do Médico: ' || v_cod_medico);
      DBMS_OUTPUT.PUT_LINE('----------------------------------------');
   END LOOP;
END;
/

--Relatorio 2--
DECLARE
   -- Declaração de variáveis para cursor
   v_cod_medico         NUMBER;
   v_crp                VARCHAR2(20);
   v_pessoa_fisica_cpf NUMBER;
   v_cod_diagnostico    NUMBER;
   v_data_geracao       DATE;
   v_resultado          VARCHAR2(200);
BEGIN
   -- Abertura do cursor para a tabela medico e diagnostico
   FOR medico_diagnostico_rec IN (
      SELECT m.cod_medico, m.crp, m.pessoa_fisica_cpf, d.cod_diagnostico, d.data_geracao, d.resultado
      FROM medico m
           JOIN diagnostico d ON m.cod_medico = d.medico_cod_medico
   )
   LOOP
      -- Atribuição de valores às variáveis
      v_cod_medico         := medico_diagnostico_rec.cod_medico;
      v_crp                := medico_diagnostico_rec.crp;
      v_pessoa_fisica_cpf := medico_diagnostico_rec.pessoa_fisica_cpf;
      v_cod_diagnostico    := medico_diagnostico_rec.cod_diagnostico;
      v_data_geracao       := medico_diagnostico_rec.data_geracao;
      v_resultado          := medico_diagnostico_rec.resultado;

      -- Impressão dos resultados ou processamento adicional
      DBMS_OUTPUT.PUT_LINE('Código do Médico: ' || v_cod_medico);
      DBMS_OUTPUT.PUT_LINE('CRP: ' || v_crp);
      DBMS_OUTPUT.PUT_LINE('CPF da Pessoa Física: ' || v_pessoa_fisica_cpf);
      DBMS_OUTPUT.PUT_LINE('Código do Diagnóstico: ' || v_cod_diagnostico);
      DBMS_OUTPUT.PUT_LINE('Data do Diagnóstico: ' || TO_CHAR(v_data_geracao, 'DD/MM/YYYY'));
      DBMS_OUTPUT.PUT_LINE('Resultado do Diagnóstico: ' || v_resultado);
      DBMS_OUTPUT.PUT_LINE('----------------------------------------');
   END LOOP;
END;
/


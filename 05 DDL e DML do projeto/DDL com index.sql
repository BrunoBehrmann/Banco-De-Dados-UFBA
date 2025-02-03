-- cria com index

BEGIN;

CREATE TABLE Estudante (
    Id SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Foto BYTEA,
    Matricula VARCHAR(20) NOT NULL UNIQUE,
    Curso VARCHAR(100),
    Email VARCHAR(255),
    Telefone VARCHAR(15)
);

CREATE INDEX MATRICULA_IDX ON Estudante (Matricula);

CREATE TABLE Armario (
    Id SERIAL PRIMARY KEY,
    Localizacao VARCHAR(100) NOT NULL,
    Status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Computador (
    Id SERIAL PRIMARY KEY,
    Modelo VARCHAR(100) NOT NULL,
    Localizacao VARCHAR(100) NOT NULL,
    Status BOOLEAN NOT NULL DEFAULT TRUE,
    MotivoIndisponibilidade TEXT,
    Tipo VARCHAR(50)
);

CREATE TABLE Supervisor (
    Id SERIAL PRIMARY KEY,
    IdEstudante INTEGER UNIQUE NOT NULL REFERENCES Estudante(Id)
);

CREATE TABLE Papel (
    Id SERIAL PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL
);

CREATE TABLE RegistroAcesso (
    Id SERIAL PRIMARY KEY,
    HorarioInicio TIMESTAMP NOT NULL,
    HorarioSaida TIMESTAMP,
    IdArmario INTEGER REFERENCES Armario(Id),
    IdComputador INTEGER REFERENCES Computador(Id),
    IdEstudante INTEGER REFERENCES Estudante(Id)
);

CREATE INDEX HORARIO_INICIO_IDX ON RegistroAcesso (HorarioInicio);

CREATE TABLE Escala (
    Id SERIAL PRIMARY KEY,
    HorarioInicio TIMESTAMP NOT NULL,
    HorarioSaida TIMESTAMP NOT NULL,
    Dia VARCHAR(100),
    IdPapel INTEGER REFERENCES Papel(Id),
    IdSupervisor INTEGER REFERENCES Supervisor(Id)
);

CREATE TABLE RegistroTurno (
    Id SERIAL PRIMARY KEY,
    HorarioEntrada TIMESTAMP NOT NULL,
    HorarioSaida TIMESTAMP NOT NULL,
    IdSupervisor INTEGER REFERENCES Supervisor(Id)
);

CREATE TABLE Advertencia (
    Id SERIAL PRIMARY KEY,
    Data DATE NOT NULL,
    Motivo TEXT NOT NULL,
    EstudanteId INTEGER REFERENCES Estudante(Id),
    SupervisorId INTEGER REFERENCES Supervisor(Id)
);

COMMIT;
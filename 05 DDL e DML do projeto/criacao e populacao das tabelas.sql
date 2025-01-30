BEGIN;

-- criacao das tabelas

CREATE TABLE Estudante (
    Id SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Foto BYTEA,
    Matricula VARCHAR(20) NOT NULL UNIQUE,
    Curso VARCHAR(50),
    Email VARCHAR(255),
    Telefone VARCHAR(15)
);

CREATE INDEX MATRICULA_IDX ON Estudante (Matricula);
    CREATE TABLE Armario (
    Id SERIAL PRIMARY KEY,
    Localizacao VARCHAR(50) NOT NULL,
    Status BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Computador (
    Id SERIAL PRIMARY KEY,
    Modelo VARCHAR(50) NOT NULL,
    Localizacao VARCHAR(50) NOT NULL,
    Status BOOLEAN NOT NULL DEFAULT TRUE,
    MotivoIndisponibilidade TEXT,
    Tipo VARCHAR(20)
);

CREATE TABLE Supervisor (
    Id SERIAL PRIMARY KEY,
    IdEstudante INTEGER UNIQUE NOT NULL REFERENCES Estudante(Id)
);

CREATE TABLE Papel (
    Id SERIAL PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL
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
    Dia DATE NOT NULL,
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

--populando com os dados

SET session_replication_role = 'replica';

---
INSERT INTO Estudante (Id, Nome, Foto, Matricula, Curso, Email, Telefone) VALUES
(1, 'Ana Souza', NULL, '20230001', 'Engenharia de Software', 'ana.souza@email.com', '71999999999'),
(2, 'Bruno Lima', NULL, '20230002', 'Ciência da Computação', 'bruno.lima@email.com', '71988888888'),
(3, 'Carlos Silva', NULL, '20230003', 'Sistemas de Informação', 'carlos.silva@email.com', '71977777777'),
(4, 'Daniela Costa', NULL, '20230004', 'Engenharia de Produção', 'daniela.costa@email.com', '71966666666'),
(5, 'Eduardo Ferreira', NULL, '20230005', 'Engenharia de Controle e Automação', 'eduardo.ferreira@email.com', '71955555555'),
(6, 'Fernanda Santos', NULL, '20230006', 'Ciência de Dados', 'fernanda.santos@email.com', '71944444444'),
(7, 'Gabriela Oliveira', NULL, '20230007', 'Ciência da Computação', 'gabriela.oliveira@email.com', '71933333333'),
(8, 'Henrique Almeida', NULL, '20230008', 'Arquitetura e Urbanismo', 'henrique.almeida@email.com', '71922222222'),
(9, 'Isabela Pereira', NULL, '20230009', 'Ciência da Computação', 'isabela.pereira@email.com', '71911111111'),
(10, 'João Pedro Costa', NULL, '20230010', 'Ciência da Computação', 'joao.costa@email.com', '71900000000');

INSERT INTO Armario (Id, Localizacao, Status) VALUES 
(1, 'a-01', TRUE), 
(2, 'a-02', FALSE), 
(3, 'b-01', TRUE), 
(4, 'b-02', FALSE), 
(5, 'c-01', TRUE), 
(6, 'c-02', FALSE),
(7, 'd-01', FALSE), 
(8, 'd-02', TRUE), 
(9, 'e-01', TRUE), 
(10, 'e-02', FALSE), 
(11, 'f-01', TRUE), 
(12, 'f-02', TRUE),
(13, 'g-01', TRUE), 
(14, 'g-02', FALSE), 
(15, 'g-03', TRUE);

INSERT INTO Computador (Id, Modelo, Localizacao, Status, MotivoIndisponibilidade, Tipo) VALUES
(1, 'HP EliteDesk 800 G4 - Mini PC', '1', TRUE, NULL, 'Notebook'),
(2, 'HP EliteDesk 800 G4 - Mini PC', '2', TRUE, NULL, 'Desktop'),
(3, 'HP EliteDesk 800 G4 - Mini PC', '3', TRUE, NULL, 'Desktop'),
(4, 'HP EliteDesk 800 G4 - Mini PC', '4', FALSE, 'Atualização do SO', 'Desktop'),
(5, 'HP EliteDesk 800 G4 - Mini PC', '5', TRUE, NULL, 'Mini PC'),
(6, 'HP EliteDesk 800 G4 - Mini PC', '6', TRUE, NULL, 'Mini PC'),
(7, 'HP EliteDesk 800 G4 - Mini PC', '7', FALSE, 'Manutenção preventiva', 'Mini PC'),
(8, 'HP EliteDesk 800 G4 - Mini PC', '8', TRUE, NULL, 'Mini PC'),
(9, 'Dell Inspiron', '9', TRUE, NULL, 'Mini PC'),
(10, 'Dell Inspiron', '10', TRUE, NULL, 'Desktop'),
(11, 'Dell Inspiron', '11', TRUE, NULL, 'Desktop'),
(12, 'Dell Inspiron', '12', FALSE, 'Mouse quebrado', 'Desktop'),
(13, 'Dell Inspiron', '13', FALSE, 'Falha no hardware', 'Desktop'),
(14, 'Dell Inspiron', '14', TRUE, NULL, 'Desktop'),
(15, 'Dell Inspiron', '15', TRUE, NULL, 'Desktop'),
(16, 'Dell Inspiron', '16', TRUE, NULL, 'Desktop'),
(17, 'Dell Inspiron', '17', FALSE, 'Funciona apenas Windows', 'Desktop'),
(18, 'Dell Inspiron', '18', FALSE, 'Problema elétrico', 'Desktop');

INSERT INTO RegistroAcesso (Id, HorarioInicio, HorarioSaida, IdArmario, IdComputador, IdEstudante)
VALUES
(1, '2024-11-28 08:00:00', '2024-11-28 12:00:00', 1, 3, 7),
(2, '2024-11-28 09:00:00', '2024-11-28 11:00:00', 3, 8, 10),
(3, '2024-11-28 15:00:00', '2024-11-28 18:00:00', 6, 5, 1),
(4, '2024-11-29 10:30:00', '2024-11-29 12:30:00', 10, 11, 3),
(5, '2024-12-01 09:00:00', '2024-12-01 11:00:00', 10, 1, 5),
(6, '2024-12-01 14:00:00', '2024-12-01 16:00:00', 4, 6, 9),
(7, '2024-12-02 10:00:00', '2024-12-02 12:00:00', 8, 11, 3),
(8, '2024-12-03 08:30:00', '2024-12-03 10:30:00', 8, 15, 1),
(9, '2024-12-03 11:00:00', '2024-12-03 13:00:00', 12, 14, 7),
(10, '2024-12-04 09:00:00', '2024-12-04 11:00:00', 1, 14, 10),
(11, '2024-11-28 09:25:00', '2024-11-28 12:15:00', 2, 5, 4),
(12, '2024-11-28 14:10:00', '2024-11-28 16:40:00', 3, 3, 4),
(13, '2024-11-28 13:00:00', '2024-11-28 14:50:00', 6, 6, 7),
(14, '2024-11-26 10:05:00', '2024-11-26 12:30:00', 1, 5, 8);

INSERT INTO Papel (Id, Descricao)
VALUES
(1, 'titular'),
(2, 'reserva'),
(3, 'suplente');

INSERT INTO Escala (Id, HorarioInicio, HorarioSaida, Dia, IdPapel, IdSupervisor)
VALUES
(1, '2024-11-28 08:00:00', '2024-11-28 12:00:00', '2024-11-28', 1, 1),
(2, '2024-11-28 13:00:00', '2024-11-28 17:00:00', '2024-11-28', 2, 2);

INSERT INTO RegistroTurno (Id, HorarioEntrada, HorarioSaida, IdSupervisor)
VALUES
(1, '2024-11-28 07:45:00', '2024-11-28 12:15:00', 1),
(2, '2024-11-28 12:45:00', '2024-11-28 18:15:00', 2);

INSERT INTO Advertencia (Id, Data, Motivo, EstudanteId, SupervisorId)
VALUES
(1, '2024-11-25', 'Uso indevido do equipamento', 1, 1),
(2, '2024-11-26', 'Atraso no retorno do armário', 3, 2);

INSERT INTO Supervisor (Id, IdEstudante)
VALUES
(1, 2),
(2, 4),
(3, 6),
(4, 8);

SET session_replication_role = 'origin';


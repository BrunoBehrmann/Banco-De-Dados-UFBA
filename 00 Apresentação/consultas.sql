-- Verifica quais estudantes estão no laboratório agora
SELECT E.Nome, R.HorarioInicio, C.Modelo 
FROM RegistroAcesso R
JOIN Estudante E ON R.IdEstudante = E.Id
JOIN Computador C ON R.IdComputador = C.Id
WHERE R.HorarioSaida IS NULL;

-- Listar todos os registros de acesso de estudantes que utilizaram um computador do modelo Dell Inspiron, exibindo o nome do estudante, a matrícula e o horário de início.
SELECT e.Nome, e.Matricula, r.HorarioInicio 
FROM RegistroAcesso r
JOIN Estudante e ON r.IdEstudante = e.Id
JOIN Computador c ON r.IdComputador = c.Id
WHERE c.modelo = 'Dell Inspiron';

-- Contar quantos acessos cada estudante fez ao laboratório, ordenando do maior para o menor.
SELECT e.Nome, e.Matricula, COUNT(r.Id) AS TotalAcessos
FROM Estudante e
JOIN RegistroAcesso r ON e.Id = r.IdEstudante
GROUP BY e.Nome, e.Matricula
ORDER BY TotalAcessos DESC;

-- Criar uma visão (VIEW) para facilitar a consulta dos estudantes com seus registros de acesso mais recentes.
CREATE VIEW UltimosAcessos AS
SELECT e.Nome, e.Matricula, MAX(r.HorarioInicio) AS UltimoAcesso
FROM Estudante e
JOIN RegistroAcesso r ON e.Id = r.IdEstudante
GROUP BY e.Nome, e.Matricula;

-- Verificar os último acesso dos estudantes que tenham David no nome (consultar a view "UltimosAcessos").
SELECT Nome, Matricula, UltimoAcesso
FROM UltimosAcessos u
WHERE nome LIKE 'David %'

-- Verifica quais supervisores estão de plantão agora
SELECT S.Id, E.Nome, R.HorarioEntrada
FROM RegistroTurno R
JOIN Supervisor S ON R.IdSupervisor = S.Id
JOIN Estudante E ON S.IdEstudante = E.Id
WHERE R.HorarioSaida IS NULL;

-- Lista todas as advertências recebidas pelo estudante de matrícula 223119867, informando o motivo e qual supervisor aplicou.
SELECT A.Data, A.motivo, EstudanteSupervisor.Nome as Supervisor, EstudanteInfrator.Nome as Aluno, EstudanteInfrator.Matricula as MatriculaAluno
FROM Advertencia A
JOIN Estudante EstudanteInfrator on A.IdEstudante = EstudanteInfrator.Id
JOIN Supervisor S on A.IdSupervisor = S.Id
JOIN Estudante EstudanteSupervisor on S.IdEstudante = EstudanteSupervisor.Id
WHERE EstudanteInfrator.Matricula = '223119867';

-- Lista quantos acessos ao laboratório aconteceram em um dia.
SELECT DATE(HorarioInicio) AS Data, COUNT(*) AS Total_Acessos
FROM RegistroAcesso
GROUP BY DATE(HorarioInicio)
ORDER BY Data DESC;
-- Nome dos estudantes que cursam Ciência da Computação
SELECT Nome 
FROM Estudante
WHERE Curso = 'Ciência da Computação';

-- Seleção das localizações dos armários disponíveis
SELECT Localizacao 
FROM Armario
WHERE Status = FALSE;

-- O estudante quatro entrou no lab que horas?
SELECT HorarioInicio 
FROM RegistroAcesso
WHERE IdEstudante = 4;

-- Todos os estudantes que usaram os armários dentro de um determinado período de 24 horas
SELECT DISTINCT Estudante.Nome
FROM RegistroAcesso
JOIN Estudante ON RegistroAcesso.IdEstudante = Estudante.Id
WHERE RegistroAcesso.HorarioInicio >= '2024-11-28 00:00:00'
  AND RegistroAcesso.HorarioSaida <= '2024-11-28 23:59:59';


-- Quais computadores estão disponíveis
SELECT *
FROM Computador
WHERE Status = true ;

-- O estudante 2 é também supervisor?
SELECT *
FROM Supervisor
WHERE IdEstudante = 2;




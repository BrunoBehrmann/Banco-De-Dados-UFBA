SELECT * FROM RegistroAcesso WHERE IdArmario = 23648104 AND IdComputador = 16648465 AND IdEstudante = 19149593;

START TRANSACTION;

SELECT Id FROM Armario WHERE Id = 23648104 AND Status = true FOR UPDATE;
SELECT Id FROM Computador WHERE Id = 16648465 AND Status = true FOR UPDATE;

UPDATE Armario SET Status = false WHERE Id = 23648104;
UPDATE Computador SET Status = false WHERE Id = 16648465;

INSERT INTO RegistroAcesso (HorarioInicio, IdArmario, IdComputador, IdEstudante) 
VALUES (NOW(), 23648104, 16648465, 19149593);

COMMIT;

SELECT * FROM RegistroAcesso WHERE IdArmario = 23648104 AND IdComputador = 16648465 AND IdEstudante = 19149593;



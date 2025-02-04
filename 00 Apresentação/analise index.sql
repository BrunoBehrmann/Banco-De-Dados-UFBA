-- lista quantos acessos ao laboratório aconteceram em um dia.
 
EXPLAIN ANALYZE
SELECT DATE(HorarioInicio) AS Data, COUNT(*) AS Total_Acessos
FROM RegistroAcesso
GROUP BY DATE(HorarioInicio)
ORDER BY Data DESC;


-- DROP INDEX HORARIO_INICIO_IDX;
-- CREATE INDEX HORARIO_INICIO_IDX ON RegistroAcesso (HorarioInicio);

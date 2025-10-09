SELECT * FROM Barcos;
SELECT * FROM Salidas;
SELECT * FROM Socios;

-- ====================================

-- 1. ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT a.id_socio, a.nombre, a.direccion, b.nombre, b.numero_amarre
FROM Socios a
JOIN Barcos b ON a.id_socio = b.id_socio
WHERE b.numero_amarre > 10;

-- 2. ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT a.nombre AS nombre_barco, a.cuota AS cuotas, b.nombre
FROM Barcos AS a
JOIN Socios AS b ON a.id_socio = b.id_socio
WHERE b.nombre = 'Juan Pérez'; -- poner la tilde si o si

-- 3. ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT COUNT(*) FROM Salidas a
JOIN Barcos b ON a.matricula = b.matricula
WHERE b.matricula ='ABC123';
-- EXTRA: para comprobar que es correcto:
SELECT * FROM Salidas a
JOIN Barcos b ON a.matricula = b.matricula
WHERE b.matricula ='ABC123';

-- 4. Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT a.matricula, a.nombre, a.numero_amarre, a.cuota, b.nombre as nombre_socio
FROM Barcos a
JOIN Socios b ON a.id_socio = b.id_socio
WHERE cuota > 500;

-- 5. ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT b.destino, a.matricula, a.nombre, a.numero_amarre, b.fecha_salida, b.hora_salida, b.patron_nombre, b.patron_direccion
FROM Barcos a
JOIN Salidas b ON a.matricula = b.matricula
WHERE b.destino = 'Mallorca';

-- 6. ¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT a.patron_nombre, a.patron_direccion, b.nombre, b.direccion, c.matricula
FROM Salidas a
JOIN Barcos c ON a.matricula = c.matricula
JOIN Socios b ON c.id_socio = b.id_socio
WHERE b.direccion LIKE '%Barcelona%';
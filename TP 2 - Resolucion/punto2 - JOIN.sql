SELECT * FROM Clientes;
SELECT * FROM Asuntos;
SELECT * FROM Procuradores;
SELECT * FROM Asuntos_Procuradores;
-- =========================
-- Esto es un extra para probar la tabla auxiliar 'asuntos_procuradores' ya que existe por una relación muchos a muchos
SELECT a.numero_expediente, a.id_procurador, b.dni_cliente, b.estado, b.fecha_inicio, b.fecha_fin, c.nombre as nombre_procurador, c.direccion as direccion_procurador
FROM asuntos_procuradores a
JOIN asuntos b ON a.numero_expediente = b.numero_expediente
JOIN procuradores c ON a.id_procurador = c.id_procurador;
-- =========================

-- 1. ¿Cuál es el nombre y la dirección de los procuradores que han trabajado en un asunto abierto?
SELECT a.nombre, a.direccion
FROM Procuradores a
JOIN Asuntos_Procuradores b ON a.id_procurador = b.id_procurador
JOIN Asuntos c ON c.numero_expediente = b.numero_expediente
WHERE c.estado = 'Abierto';

-- 2. ¿Qué clientes han tenido asuntos en los que ha participado el procurador Carlos López?
SELECT a.dni, a.nombre, a.direccion FROM Clientes a -- si pones el *(all) te muestra las columnas de todas las tablas
JOIN Asuntos b ON a.dni = b.dni_cliente
JOIN Asuntos_Procuradores c ON b.numero_expediente = c.numero_expediente
JOIN Procuradores d ON c.id_procurador = d.id_procurador
WHERE d.nombre = 'Carlos López';

-- 3. ¿Cuántos asuntos ha gestionado cada procurador?
SELECT a.nombre AS nombre_procurador, COUNT(b.numero_expediente) AS cantidad_asuntos
FROM Procuradores a
JOIN Asuntos_Procuradores b ON a.id_procurador = b.id_procurador
GROUP BY a.id_procurador, a.nombre;

-- 4. Lista los números de expediente y fechas de inicio de los asuntos de los clientes que viven en Buenos Aires.
SELECT a.numero_expediente, a.fecha_inicio
FROM Asuntos a
JOIN Clientes b ON a.dni_cliente = b.dni
WHERE b.direccion LIKE '%Buenos Aires%';




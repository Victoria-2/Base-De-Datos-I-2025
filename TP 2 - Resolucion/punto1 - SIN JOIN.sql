SELECT * FROM Barcos;
SELECT * FROM Salidas;
SELECT * FROM Socios;

-- ====================================

-- 1. ¿Qué socios tienen barcos amarrados en un número de amarre mayor que 10?
SELECT * FROM Socios
WHERE id_socio IN (
  SELECT id_socio FROM Barcos WHERE numero_amarre > 10
);

-- 2. ¿Cuáles son los nombres de los barcos y sus cuotas de aquellos barcos cuyo socio se llama 'Juan Pérez'?
SELECT nombre, cuota FROM Barcos
WHERE id_socio IN (
  SELECT id_socio FROM Socios WHERE nombre = 'Juan Pérez'
);

-- 3. ¿Cuántas salidas ha realizado el barco con matrícula 'ABC123'?
SELECT COUNT(*) FROM Salidas
WHERE matricula IN (
  SELECT matricula from Barcos WHERE matricula = 'ABC123'
);
-- Agregamos otra salida para revisar si el numero aumenta cuando llamamos el punto 3
INSERT INTO Salidas (matricula, fecha_salida, hora_salida, destino, patron_nombre, patron_direccion)
VALUES('ABC123', '2024-08-15', '10:30:00', 'Ibiza', 'Patrón 5', 'Calle del Sol 4, Ibiza');

-- 4. Lista los barcos que tienen una cuota mayor a 500 y sus respectivos socios.
SELECT * FROM Barcos
WHERE cuota > 500
AND id_socio IN(
  SELECT id_socio FROM Socios
);

-- 5. ¿Qué barcos han salido con destino a 'Mallorca'?
SELECT * FROM Barcos
WHERE matricula IN (
	SELECT matricula FROM Salidas WHERE destino = 'Mallorca'
);

-- 6. ¿Qué patrones (nombre y dirección) han llevado un barco cuyo socio vive en 'Barcelona'?
SELECT * -- sa.patron_nombre, sa.patron_direccion, // so.nombre, so.direccion // no se pueden poner apodos porque están dentro de una subconsulta, no los detecta
FROM Salidas sa
WHERE matricula IN (
	SELECT matricula FROM Barcos b WHERE id_socio IN (
		SELECT id_socio FROM Socios so WHERE direccion LIKE '%Barcelona%'
    )
);


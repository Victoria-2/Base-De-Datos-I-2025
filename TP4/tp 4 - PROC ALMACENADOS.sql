-- Consultas | Procedimientos almacenados --

/* ¡No pongan comentarios en los DELIMITER!
(!!) Borrar procedimiento: 
	DROP PROCEDURE IF EXISTS nombre_proc;
(!!) Fijarnos qué procedimientos tiene la BdD:
	SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';
*/

/* CONSULTA 3 
Crea el procedimiento almacenado sin parámetros VerCuentas() 
que muestre todas las cuentas con su saldo actual.
*/

DELIMITER $$
CREATE PROCEDURE VerCuentas() -- el inner join no es necesario, los alias (as) tampoco
BEGIN
	SELECT a.numero_cuenta as 'Num cuenta', a.saldo as 'Saldo', CONCAT(b.nombre, ' ', b.apellido) as 'Cliente'
    FROM Cuentas a
    JOIN Clientes b
    ON a.numero_cliente = b.numero_cliente;
END$$
DELIMITER ;

CALL VerCuentas();

/* CONSULTA 4
Crea el procedimiento CuentasConSaldoMayorQue(IN limite DECIMAL(10,2)) 
que muestra las cuentas con saldo mayor al valor recibido.
*/

DELIMITER $$
CREATE PROCEDURE CuentasConSaldoMayorQue (IN limite DECIMAL(10,2))
BEGIN
	SELECT numero_cuenta, saldo FROM Cuentas
    WHERE saldo >= limite;
END$$
DELIMITER ;

CALL CuentasConSaldoMayorQue(1000); -- probamos si nos trae las cuentas con saldo > 1000

/* CONSULTA 5
Crea sin utilizar cursores el procedimiento almacenado TotalMovimientosDelMes(IN cuenta INT, OUT total DECIMAL(10,2)) 
que recibe una cuenta y devuelve el total de los movimientos 
de la cuenta en el mes actual, los créditos suman, y los débitos restan.

NOTA: Utilizar CURDATE() y MONTH()
*/

DELIMITER $$
CREATE PROCEDURE TotalMovimientosDelMes (IN cuenta INT, OUT total DECIMAL (10,2))
BEGIN
    DECLARE suma_debito, suma_credito DECIMAL (10,2) DEFAULT 0.00;
    
    -- saldo positivo
	SELECT SUM(a.importe) INTO suma_credito -- con el 'INTO' indicamos dónde se va a guardar el resultado
    FROM Movimientos a
    JOIN Cuentas b ON a.numero_cuenta = b.numero_cuenta
    WHERE a.numero_cuenta = cuenta AND a.tipo = 'CREDITO' AND MONTH(a.fecha) = MONTH(CURDATE());
    
    -- saldo negativo
    SELECT SUM(a.importe) INTO suma_debito -- con el 'INTO' indicamos dónde se va a guardar el resultado
    FROM Movimientos a
    JOIN Cuentas b ON a.numero_cuenta = b.numero_cuenta
    WHERE a.numero_cuenta = cuenta AND a.tipo = 'DEBITO' AND MONTH(a.fecha) = MONTH(CURDATE());
    
	SET total = suma_credito - suma_debito;
END$$
DELIMITER ;

SELECT * FROM Cuentas; 
SELECT * FROM Movimientos; -- Nos fijamos una cuenta que tenga varios movimientos

CALL TotalMovimientosDelMes(1001, @resultado_consulta); -- creamos la variable 'resultado_consulta' con el '@'
SELECT @resultado_consulta; -- mostramos el resultado guardado en el OUT


/* CONSULTA 6
Crea un procedimiento almacenado Depositar(IN cuenta, IN monto) 
que deposita el valor ingresado en la cuenta.
*/

DELIMITER $$
CREATE PROCEDURE Depositar (IN cuenta INT, IN monto decimal(10,2))
BEGIN
	INSERT INTO Movimientos (numero_cuenta, fecha, tipo, importe)
    VALUES (cuenta, CURDATE(), 'CREDITO', monto);
END$$
DELIMITER ;

CALL Depositar(1003, 120.36);
SELECT * FROM Movimientos WHERE numero_cuenta = 1003; -- Nos fijamos si se realizó correctamente

/* CONSULTA 7
Crea un procedimiento almacenado Extraer(IN cuenta, IN monto) que registra la extracción 
de dinero de la cuenta, si es que cuenta con fondos para cubrir el retiro.
*/

DELIMITER $$
CREATE PROCEDURE Extraer (IN cuenta INT, IN monto decimal(10,2))
BEGIN
	INSERT INTO Movimientos (numero_cuenta, fecha, tipo, importe)
    VALUES (cuenta, CURDATE(), 'DEBITO', monto);
END$$
DELIMITER ;

CALL Extraer(1003, 36.89);
SELECT * FROM Movimientos WHERE numero_cuenta = 1003; -- Nos fijamos si se realizó correctamente


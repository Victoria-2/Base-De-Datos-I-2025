/* CONSULTA 8
Crea un Trigger que actualice el saldo de la cuenta luego de cada nuevo movimiento 
que se registra en la cuenta. Probalo ejecutando algunos depósitos/extracciones.
*/
DELIMITER $$
CREATE TRIGGER tr_actualizar_saldo_cuenta
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
	IF NEW.tipo = 'CREDITO' THEN
		UPDATE Cuentas SET saldo = saldo + NEW.importe WHERE numero_cuenta = NEW.numero_cuenta;
	ELSE
		UPDATE Cuentas SET saldo = saldo - NEW.importe WHERE numero_cuenta = NEW.numero_cuenta;
	END IF;
END$$
DELIMITER ;


/* CONSULTA 9
Modifica el trigger anterior para que, luego de actualizado el saldo, se encargue de registrar 
el movimiento en el historial de saldos. Para modificar la implementación del trigger 
primero hay que eliminarlo, y luego volver a crearlo. 
*/

DELIMITER $$
CREATE TRIGGER tr_agregar_movimientos_historial
AFTER INSERT ON Movimientos -- con esto, tenemos disponible todos los atributos de la tabla 'Moviminetos' porque trabajamos sobre esta
FOR EACH ROW
-- FOLLOWS tr_actualizar_saldo_cuenta /*MySQL no lo permite*/
BEGIN
	DECLARE saldo_ant, saldo_act DECIMAL(10,2) DEFAULT 0.00;
    
    SELECT saldo INTO saldo_act FROM Cuentas WHERE numero_cuenta = NEW.numero_cuenta;
    
    IF NEW.tipo = 'CREDITO' THEN
		SET saldo_ant = saldo_act - NEW.importe;
	ELSE
		SET saldo_ant = saldo_act + NEW.importe;
	END IF;
    
    INSERT INTO Historial_Movimientos (numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual) VALUES
	(NEW.numero_cuenta, NEW.numero_movimiento, saldo_ant, saldo_act);
END$$
DELIMITER ;
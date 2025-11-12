/* CONSULTA 10
Crea el procedimiento almacenado TotalMovimientosDelMes(IN cuenta INT, OUT total DECIMAL(10,2)) 
que recibe una cuenta y devuelve el total de los movimientos de la cuenta 
en el mes actual, los créditos suman, y los débitos restan.

NOTA: Utilizar CURDATE() y MONTH()
*/

-- DROP PROCEDURE IF EXISTS cur_TotalMovimientosDelMes;
DELIMITER $$
CREATE PROCEDURE cur_TotalMovimientosDelMes(IN cuenta INT, OUT total DECIMAL(10,2))
BEGIN
	DECLARE fin BOOLEAN DEFAULT FALSE;
    DECLARE var_tipo VARCHAR(7);
    DECLARE var_importe DECIMAL (10,2) DEFAULT 0.00;
    DECLARE suma_debito, suma_credito DECIMAL (10,2) DEFAULT 0.00;
    
    DECLARE cur CURSOR FOR SELECT tipo, importe FROM Movimientos WHERE numero_cuenta = cuenta 
    AND YEAR(fecha) = YEAR(CURDATE()) AND MONTH(fecha) = MONTH(CURDATE());
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    
    OPEN cur;
    -- se puede utilizar para iterar: 'loop_registros : LOOP' o 'REPEAT'
    loop_registros : LOOP
		FETCH cur INTO var_tipo, var_importe;
        
        IF fin THEN
			LEAVE loop_registros;
		END IF;
        
        IF var_tipo = 'CREDITO' THEN
			SET suma_credito = suma_credito + var_importe;
		ELSE
			SET suma_debito = suma_debito + var_importe;
		END IF;
        
	END LOOP loop_registros;
    -- cerramos cursor
    CLOSE cur;
    
    SET total = suma_credito - suma_debito;
END$$
DELIMITER ;

CALL cur_TotalMovimientosDelMes(1005, @total);
SELECT @total as 'Total movimientos mes actual';

/* CONSULTA 11
El banco implementó un beneficio para sus clientes dándoles por única vez un 2% de interés a las cuentas que 
posean saldo mayor a $100.000 (uso otro monto, 1500). Creá un procedimiento almacenado que se encargue de aplicar un porcentaje 
de interés recibido por parámetro a todas las cuentas con saldo mayor a un valor recibido por parámetro.
*/

-- DROP PROCEDURE IF EXISTS cur_aplicar_interes;
DELIMITER $$
CREATE PROCEDURE cur_aplicar_interes (IN saldo_min DECIMAL(10,2), IN interes DECIMAL(5,2))
BEGIN 
	DECLARE fin BOOLEAN DEFAULT FALSE;
	DECLARE var_saldo DECIMAL(10,2);
    DECLARE var_num_cuenta INT;
    DECLARE var_interes_saldo DECIMAL (10,2);
    
    DECLARE cur CURSOR FOR SELECT saldo, numero_cuenta FROM Cuentas WHERE saldo >= saldo_min;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    
    OPEN cur;
    -- en los comentarios está como se utilizaría el REPEAT
    loop_registros : LOOP -- REPEAT
		FETCH cur INTO var_saldo, var_num_cuenta;
    
		IF fin THEN -- si utilizamos REPEAT, este IF no tiene que estar
			LEAVE loop_registros;
        END IF;
        
        SET var_interes_saldo = var_saldo * (interes / 100);
        UPDATE Cuentas SET saldo = saldo + var_interes_saldo WHERE numero_cuenta = var_num_cuenta;
        
    -- UNTIL fin;
    END LOOP loop_registros; -- END REPEAT;
    CLOSE cur;

END$$
DELIMITER ;

CALL cur_aplicar_interes(1500,2);
SELECT * FROM Cuentas; -- Nos fijamos si se actualizaron los saldos

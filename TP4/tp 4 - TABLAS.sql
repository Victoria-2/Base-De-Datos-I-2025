-- CREATE DATABASE tp4_resolucion_2025;
-- USE tp4_resolucion_2025;

-- TABLAS

CREATE TABLE Clientes (
	numero_cliente INT PRIMARY KEY,
    dni INT NOT NULL,
    apellido VARCHAR(60),
    nombre VARCHAR(60)
);

CREATE TABLE Cuentas (
	numero_cuenta INT PRIMARY KEY,
    numero_cliente INT NOT NULL,
    saldo DECIMAL (10,2) DEFAULT 0.00,
    CONSTRAINT fk_cuentas_nro_cliente FOREIGN KEY (numero_cliente) REFERENCES Clientes (numero_cliente)
);

CREATE TABLE Movimientos (
	numero_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    numero_cuenta INT NOT NULL, 
    fecha DATE NOT NULL,
    tipo ENUM ('CREDITO', 'DEBITO') NOT NULL,
    importe DECIMAL (10,2) NOT NULL,
    CONSTRAINT fk_movimientos_nro_cuenta FOREIGN KEY (numero_cuenta) REFERENCES Cuentas (numero_cuenta) -- ,
    -- CONSTRAINT chk_tipo_valido CHECK (tipo IN ('CREDITO', 'DEBITO'))
);

CREATE TABLE Historial_Movimientos(
	id INT PRIMARY KEY AUTO_INCREMENT AUTO_INCREMENT, 
    numero_cuenta INT NOT NULL,
    numero_movimiento INT NOT NULL,
    saldo_anterior DECIMAL (10,2) DEFAULT 0.00,
    saldo_actual DECIMAL (10,2) NOT NULL,
    CONSTRAINT fk_historial_nro_cuenta FOREIGN KEY (numero_cuenta) REFERENCES Cuentas (numero_cuenta),
    CONSTRAINT fk_historial_nro_movimiento FOREIGN KEY (numero_movimiento) REFERENCES Movimientos (numero_movimiento)
);

-- ALTER TABLE Historial_Movimientos MODIFY id INT AUTO_INCREMENT = ult_num_id;
-- SHOW TABLE STATUS LIKE 'Historial_Movimientos';
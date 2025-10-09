CREATE TABLE Clientes (
	dni VARCHAR(255) PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	direccion VARCHAR(255)
);

CREATE TABLE Asuntos (
	numero_expediente INT PRIMARY KEY,
    dni_cliente VARCHAR(255) NOT NULL,
	-- dni_cliente INT NOT NULL, (esta es otra opción por si no era una cadena de caracteres)
	-- fecha_inicio DATE NOT NULL, (esta es otra opción por si no era una cadena de caracteres)
	fecha_inicio VARCHAR(100) NOT NULL,
	-- fecha_fin DATE, (esta es otra opción por si no era una cadena de caracteres)
	fecha_fin VARCHAR(100),
	estado VARCHAR(100) NOT NULL,
	-- estado ENUM('Abierto','Cerrado') NOT NULL, (esto sirve para asegurarse que los estados sean solamente 'Abierto' o 'Cerrado', si ingresamos otro valor da error)

	FOREIGN KEY (dni_cliente) REFERENCES Clientes(dni),
    
	-- CONSTRAINT chk_estado_valido CHECK (estado IN ('Abierto', 'Cerrado')) (lo mismo que con el enum, es para asegurar)
	CONSTRAINT chk_estado_fecha_fin CHECK (
        (estado = 'Abierto' AND fecha_fin IS NULL) OR
        (estado = 'Cerrado' AND fecha_fin IS NOT NULL)
    )
);

CREATE TABLE Procuradores (
	id_procurador INT PRIMARY KEY,
	-- id_procurador INT PRIMARY KEY AUTO_INCREMENT, (esta es otra opción por si no nos daban los id)
	nombre VARCHAR(255) NOT NULL,
	direccion VARCHAR(255)
);

CREATE TABLE Asuntos_Procuradores(
	numero_expediente INT NOT NULL,
	id_procurador INT NOT NULL,

	CONSTRAINT fk_numero_expediente  FOREIGN KEY (numero_expediente) REFERENCES Asuntos(numero_expediente),
	CONSTRAINT fk_id_procurador FOREIGN KEY (id_procurador) REFERENCES Procuradores(id_procurador)
); -- es una tabla auxiliar, no una entidad débil

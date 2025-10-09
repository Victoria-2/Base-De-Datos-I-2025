-- Tabla Socios
CREATE TABLE Socios (
  id_socio INTEGER PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  direccion VARCHAR(255)
);

-- Tabla Barcos
CREATE TABLE Barcos (
    matricula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    numero_amarre INTEGER,
    cuota DECIMAL(10, 2),
    id_socio INTEGER,
    FOREIGN KEY (id_socio) references Socios(id_socio)
);

-- Tabla Salidas
CREATE TABLE Salidas (
    id_salida INTEGER PRIMARY KEY AUTO_INCREMENT,
    matricula VARCHAR(20),
    fecha_salida DATE,
    hora_salida TIME,
    destino VARCHAR(100),
    patron_nombre VARCHAR(100),
    patron_direccion VARCHAR(255),
    FOREIGN KEY (matricula) references Barcos(matricula)
);
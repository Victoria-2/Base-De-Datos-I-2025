INSERT INTO peliculas (idPelicula, titulo, genero, anio) VALUES 
(1, 'El Origen', 'Ciencia Ficción', 2010),
(2, 'Titanic', 'Romance', 1997),
(3, 'Avatar', 'Aventura', 2009),
(4, 'El Padrino', 'Crimen', 1972),
(5, 'Parásitos', 'Drama', 2019),
(6, 'Avengers: Endgame', 'Acción', 2019),
(7, 'Toy Story', 'Animación', 1995),
(8, 'Interestelar', 'Ciencia Ficción', 2014),
(9, 'Joker', 'Drama', 2019),
(10, 'Top Gun: Maverick', 'Acción', 2022);

INSERT INTO Usuarios (idUsuario, nombre, pais) VALUES
(4, 'Carlos', 'México'),
(5, 'María', 'España'),
(6, 'Joaquín', 'Uruguay'),
(7, 'Sofía', 'Argentina'),
(8, 'Diego', 'Perú'),
(9, 'Laura', 'Colombia'),
(10, 'Nicolás', 'Argentina');

INSERT INTO Valoraciones (idUsuario, idPelicula, puntuacion, fecha) VALUES
(1, 1, 9, '2024-03-12'),
(2, 1, 8, '2024-03-13'),
(3, 2, 10, '2024-03-15'),
(4, 6, 9, '2024-03-18'),
(5, 3, 8, '2024-03-19'),
(6, 3, 7, '2024-03-20'),
(7, 6, 10, '2024-03-21'),
(8, 4, 9, '2024-03-22'),
(9, 9, 6, '2024-03-25'),
(10, 3, 8, '2024-03-26'),
(6, 2, 7, '2024-03-20'),
(7, 3, 10, '2024-03-21'),
(8, 3, 9, '2024-03-22'),
(9, 3, 6, '2024-03-25'),
(10, 6, 8, '2024-03-26');
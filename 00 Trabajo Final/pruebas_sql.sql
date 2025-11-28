CREATE DATABASE 00_tp_final_BdD_I_2025;
USE 00_tp_final_BdD_I_2025;

-- 0=========================0
/* Vamos a crear un nuevo usuario con la única función de conectar y administrar la base de datos.

La sintaxis es: 'CREATE USER 'nombre_usuario'@'host' IDENTIFIED BY 'contraseña';'

- 'host' especifica desde qué máquina se puede conectar el usuario.
- Ponemos localhost para que solo se pueda acceder desde esta PC, 
    * La otra opción es poner '%' para que se pueda conectar desde cualquier máquina. No es lo que queremos en este caso.
*/

CREATE USER 'maria'@'localhost' IDENTIFIED BY 'biblioteca.271125';

/* Ahora tenemos que establecer los privilegios de este usuario sobre la base de datos que acabamos de crear.

La sintaxis es: 'GRANT tipo_de_privilegio ON base_de_datos.* TO 'nombre_usuario'@'host';'

- 'base_de_datos.*' indica que los privilegios se aplican a todas las tablas de la base de datos especificada.
- Ponemos ALL PRIVILEGES para darle todos los privilegios sobre la base de datos.
    * También podríamos especificar privilegios específicos como SELECT, INSERT, UPDATE, DELETE, etc.
*/

GRANT ALL PRIVILEGES ON 00_tp_final_BdD_I_2025.* TO 'maria'@'localhost';

-- Guardamos los cambios realizados en los privilegios.

FLUSH PRIVILEGES;

-- 0=========================0

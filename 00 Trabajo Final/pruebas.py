import mysql.connector

def conectar():
    try:
        mybd = mysql.connector.connect(
            host="localhost",                  # Host donde está la base de datos
            port='3306',                       # Puerto de conexión, es el mismo para todos
            user="maria",                      # Nombre del usuario que creamos en MySQL
            password="biblioteca.271125",      # La contraseña que asignamos a ese usuario
            database="00_tp_final_BdD_I_2025"  # Nombre de la base de datos
        )
        if mybd.is_connected():
            print("Conexión exitosa a la base de datos")
            return mybd
        
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None
    return None

'''
    Notas:
    - No se olviden de hacer el import de la libreria mysql.connector al inicio del archivo.
    - No es necesario poner la conexión dentro de una función (conectar()), les va a andar de la misma forma, pero es una buena práctica.
    - Si ven el código, van a ver que tenemos un bloque 'try/except', se lo suele llamar también 'try/catch' en otros lenguajes.
         Lo que hace 'try' es intentar ejecutar el código que está dentro, y si hay un error, en vez de romper todo el programa,
         pasa a ejecutar el bloque 'except', donde podemos indicar qué hacer si surge un error.
         Es como si le decimos "intenta hacer esto, pero en caso de que haya un error, agarralo y te indico qué hacer".
    - No es necesario que lo hagan de esta forma, con una sentencia 'IF' logran lo mismo.
    - Por otro lado, les SUPER recomiendo estas dos extensiones:
        * IntelliCode, de Microsoft: Es una IA que los ayuda a autocompletar el código. Aprentando 'TAB' confirman lo que les sugiere.
        * indent-rainbow, de oderwat: Les pinta con colores diferentes los distintos niveles de indentación. Les va a servir
            para ver si se olvidaron de cerrar un bloque o no, y poder entender mejor la estructura del código.
    
'''


import mysql.connector
from mysql.connector import Error

class Conexion:
    def __init__ (self,host,usuario,contrasena,base_datos):
        self._datos= dict(host=host, user=usuario,password=contrasena,database=base_datos)
        self._conexion=None
    def conectar(self):
        try:
            self._conexion=mysql.connector.connect(**self._datos)
            if self._conexion.is_connected():
                print(f"Conexion establecida con la base de datos '{self._datos['database']}'")
            return self._conexion
        except Error as error:
            print(f"Error al conectar con la base de datos: {error}")
    def cerrar(self):
        if self._conexion and self._conexion.is_connected():
            self._conexion.close()
            print("Conexion cerrada correctamente.")





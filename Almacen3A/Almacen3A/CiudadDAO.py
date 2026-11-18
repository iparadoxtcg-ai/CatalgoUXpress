import Ciudad
from Ciudad import Ciudad

class CiudadDAO:
    def __init__ (self, conexion):
        self._conexion=conexion
        self._cursor=conexion.cursor()

    def agregar(self,ciudad:Ciudad):
        consulta="INSERT INTO ciudad (codigo, nombre) VALUES (%s, %s)"
        self._cursor.execute(consulta, (ciudad.codigo, ciudad.nombre))
        self._conexion.commit()

    def consultar_todas(self):
        self._cursor.execute("SELECT codigo, nombre FROM ciudad")
        return [Ciudad(*fila) for fila in self._cursor.fetchall()]

    def actualizar_nombre(self, codigo, nueva_ciudad):
        consulta = "UPDATE ciudad SET nombre= %s WHERE codigo= %s"
        self._cursor.execute(consulta,(nueva_ciudad, codigo))
        self._conexion.commit()

    def eliminar (self,codigo):
        consulta = "DELETE FROM ciudad WHERE codigo= %s"
        self._cursor.execute(consulta, (codigo,))
        self._conexion.commit()
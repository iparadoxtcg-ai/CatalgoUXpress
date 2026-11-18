class SucursalDAO:
    def __init__(self,conexion):
        self._conexion=conexion
        self._cursor=conexion.cursor()

    def agregar(self,sucursal:Sucursal):
        consulta = ("INSERT INTO sucursal (codigo,nombre,dirCalle,dirNumero,dirColonia,ciudad) VALUES (%s,%s,%s,%s,%s,%s)")
        valores = (sucursal.codigo, sucursal.nombre, sucursal.dirCalle, sucursal.dirNumero, sucursal.dirColonia, sucursal.ciudad)
        self._cursor.execute(consulta,valores)
        self._conexion_commit()

    def consultar_todos(self):
        self.cursor.execute("SELECT codigo,nombre,dirCalle,dirNumero,dirColonia,ciudad FROM sucursal")

    def buscar_por_codigo(self,codigo):
        self._cursor.execute(
            "SELECT codigo,nombre,dirCalle,dirNumero,dirColonia,ciudad FROM sucursal WHERE codigo = %s", (codigo,)
            )

    def actualizar_nombre(self, codigo, nuevo_nombre):
        consulta="UPDATE sucursal SET nombre = %s WHERE codigo = %s"
        self._cursor.execute(consulta, (nuevo_nombre, codigo))
        self._conexion.commit()

    def eliminar(self,codigo):
        consulta= "DELETE FROM sucursal WHERE codigo = %s"
        self._cursor.execute(consulta,(codigo,))
        self._conexion.commit()
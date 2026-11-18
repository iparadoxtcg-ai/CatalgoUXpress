import utils as u
from Conexion import Conexion
from Ciudad import Ciudad
from CiudadDAO import CiudadDAO
from Sucursal import Sucursal
from SucursalDAO import SucursalDAO

def Main():

    #Inicar la conexion
    gestor_conexion = Conexion("localhost", "root", "", "almacen3a")
    conexion_activa=gestor_conexion.conectar()

    #Iniciar el DAO de ciudad
    dao_ciudad=CiudadDAO(conexion_activa)

    #Mostrar datos en la tabla
    print(f"{'Codigo':<5} | {'Ciudad':<15}")
    for cod in dao_ciudad.consultar_todas():
        print(cod)

    u.sls(50)

    #Creacion de nuevos registros
    ciudad=Ciudad("MOCH", "Los Mochis")
    dao_ciudad.agregar(ciudad)
    ciudad=Ciudad("OBRE", "Ciudad Obregon")
    dao_ciudad.agregar(ciudad)

    #Actualizacion de un registro
    dao_ciudad.actualizar_nombre('ENS', 'La Ene')

    #Mostrar datos en la tabla
    print(f"{'Codigo':<5} | {'Ciudad':<15}")
    for cod in dao_ciudad.consultar_todas():
        print(cod)

    #ELiminicion de los registros nuevos
    dao_ciudad.eliminar('MOCH')
    dao_ciudad.eliminar('OBRE')

    u.sls(50)

    sucursal=Sucursal("REFU", "El Refugio")

    #Cerrar conexion
    gestor_conexion.cerrar()



Main()

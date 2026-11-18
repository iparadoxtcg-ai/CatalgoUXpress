class Sucursal:
    def __init__(self,codigo,nombre,dirCalle,dirNumero,dirColonia,ciudad):
        self.codigo=codigo
        self.nombre=nombre
        self.dirCalle=dirCalle
        self.dirNumero=dirNumero
        self.dirColonia=dirColonia
        self.ciudad=Ciudad
    def __str__(self):
        return f"{self.codigo:<5} | {self.nombre:<30} | {self.dirCalle:<30} | {self.dirNumero:<10} | {self.dirColonia:<30} | {self.ciudad:<5}"
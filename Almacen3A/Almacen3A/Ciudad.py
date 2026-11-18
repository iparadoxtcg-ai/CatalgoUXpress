class Ciudad:
    def __init__(self,codigo,nombre):
        self.codigo=codigo
        self.nombre=nombre
    def __str__(self):
        return f"{self.codigo:<6} | {self.nombre:<15}"
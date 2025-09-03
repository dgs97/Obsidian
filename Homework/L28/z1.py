class Circle:
    def __init__(self,r=3,color="blue"):
        self.r = r
        self.p = 3.14
        self.color = color

    def square(self):
        return int(self.p*self.r*self.r)
    
    def circuit(self):
        return int(2*self.p*self.r)
    

a = Circle(r=10,color="Red")
b = Circle(r=5,color="Blue")

print(f"Площадь {a.color} круга: {a.square()}")
print(f"Площадь {b.color} круга: {b.square()}")

print(f"Длина окружности {a.color} круга: {a.circuit()}")
print(f"Длина окружности {b.color} круга: {b.circuit()}")
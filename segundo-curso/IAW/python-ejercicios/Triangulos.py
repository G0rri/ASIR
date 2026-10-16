#Programa que pinta triangulos con caracteres

c = input("Caracter: ")
d = c
i = int(input("Altura: "))

#Triángulo rectángulo, solución con el bucle for

for x in range(i):
    print(c * (x + 1))

#Triángulo rectángulo, solución con el bucle while

while (i > 0):
    print(d)
    d += c
    i -= 1 #Empiezas p.e en 10 y lo que hace es 10-1=9 9-1=8 y así sucesivamente.

#Triángulo isósceles, solución con el bucle for

c = input("Caracter: ")
d = c
i = int(input("Altura: "))

for x in range(i):
    print(" " * (i - x) + c * (x * 2 + 1))

# Función que imprime un triangulo rectángulo cuya altura se pasa como parámetro.

def my_function(i, c):
    for x in range(i):
        print(c * (x + 1))

my_function(10, "*")
mialtura = int(input("Altura: "))
micaracter = input("Caracter: ")
my_function(mialtura, micaracter)

# Función que imprime un rectángulo
# Recibe tres parámetros:
# Alto
# Ancho
# Carácter de relleno

def rectangulo(h, w, c):
    for x in range(h):
        print(w * c)

rectangulo(10, 5, "r")

# Le pedimos al usuario que introduzca los datos de alto, ancho y caracter

def rectangulo(alt, anc, car):
    for x in range(alt):
        print(anc * car)

alt = int(input("Altura: "))
anc = int(input("Ancho: "))
car = input("Caracter: ")
rectangulo(alt, anc, car)

# Después de pintar el rectángulo se pregunta al susuario si quiere continuar
# y se repite el proceso mientras el usuario diga que sí.

def rectangulo(h, w, c):
    for x in range(h):
        print(w * c)

h = int(input("Altura: "))
w = int(input("Ancho: "))
c = input("Caracter: ")
rectangulo(h, w, c)
sn = input("Continue (s/n)? ")

while sn.upper() != "N":
    h = int(input("Altura: "))
    w = int(input("Ancho: "))
    c = input("Caracter: ")
    rectangulo(h, w, c)
    sn = input("Continue (s/n)? ")



rectangulo(int(input("h: ")),int(input("w: ")),input("c: "))



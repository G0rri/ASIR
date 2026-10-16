# Función que genera un rombo. 
# Recibe dos parámetros:
# - Diagonal (si es par se le suma 1)
# - Carácter

def rombo(d, c):
    if d % 2 == 0:
        d += 1
    nb = d // 2 #number of blanks
    nc = 1 #number of chars
    inc = -1
    for i in range(d):
        print(" " * nb + c * nc)
        if nb == 0:
            inc = inc * (-1)
        nb += inc
        nc -= inc * 2

rombo(int(input("Diagnal: ")),input("Carácter: "))

# Función que genera una lista con un rombo. 
# Recibe dos parámetros:
# - Diagonal (si es par se le suma 1)
# - Carácter

def rombo(d, c):
    mylist = []
    if d % 2 == 0:
        d += 1
    nb = d // 2 #number of blanks
    nc = 1 #number of chars
    inc = -1
    for i in range(d):
        mylist.append(" " * nb + c * nc + " " * nb)
        if nb == 0:
            inc = inc * (-1)
        nb += inc
        nc -= inc * 2
    return mylist

n = int(input("Número de rombos: "))
x = rombo(int(input("Diagonal: ")),input("Carácter: "))
print("La lista del rombo es: ", x)
print("El dibujo del rombo es: ")
for y in x:
    print(y * n)
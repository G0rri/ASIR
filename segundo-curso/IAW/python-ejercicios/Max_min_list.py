#Pedimos al usuario una serie de números.
#Cuando introduzca el cero se imprime el máximo y termina

x = int(input("Teclea un número: "))
max = x

while x != 0:
    if x > max:
        max = x
    x = int(input("Teclea un número: "))
print("El máximo es: ", max)

#Cuando introduzca el cero se imprime el máximo y el mínimo y termina

x = int(input("Teclea un número: "))
max = x
min = x

while x != 0:
    if x > max:
        max = x
    elif x < min:
        min = x
    x = int(input("Teclea un número: "))
print("El máximo es: ", max, "\nEl mínimo es: ", min)

i = 0
fruits = ["apple", "banana", "cherry", "lemon"]
for x in fruits:
    print(x)
    i += 1
print("El número de iteraciones del bucle es: ", i)

i = 0
s = "banana"
for x in "banana":
    print(x, s[i])
    i += 1

#Cuando introduzca el cero se imprime la lista, el máximo y el mínimo y termina

mylist = []
x = int(input("Teclea un número: "))
max = x
min = x

while x != 0:
    mylist.append(x)
    if x > max:
        max = x
    elif x < min:
        min = x
    x = int(input("Teclea un número: "))
print("La lista es: ",mylist)
print("El máximo es: ", max, "\nEl mínimo es: ", min)

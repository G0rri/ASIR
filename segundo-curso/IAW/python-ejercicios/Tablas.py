#Programa que imprime en pantalla varias tablas de multiplicar.

x = 1
print("La tabla del 2")
while x <= 10:
    print("2 *", x, "=", 2 * x)
    x += 1

x = 1
print("La tabla del 3")
while x <= 10:
    print("3 *", x, "=", 3 * x)
    x += 1

x = 1
y = int(input("Que tabla quieres: "))
print("La tabla del", y)
while x <= 10:
    print(y, "*", x, "=", y * x)
    x += 1
# 1. Print first 10 natural numbers using while loop

x = 1

while x < 11:
    print(x)
    x += 1

# 2. The same in reverse order

x = 10

while x >= 1:
    print(x)
    x = x - 1


# 3. Print first 10 natural numbers using for loop

x = 0

for x in range(0, 10):
    x += 1
    print(x)

# 4. The same in reverse order

x = 0

for x in range(10, 0):
    x += 1
    print(x)

# 5. Input a number and print its multiplication table

x = 1
y = int(input("Que tabla quieres: "))
print("La tabla del", y)

while x <= 10:
    print(y, "*", x, "=", y * x)
    x += 1

# 6. Input numbers until user types 0 (zero). Then print the count and the sum of the numbers.

x = 1
suma = -1

while x != 0:
    suma = suma + x
    x = int(input("Teclea un número: "))
    print(x)
print("La suma es: ", suma)

# 7. Print the following pattern
# 1
# 12
# 123
# 1234

c = ""

for x in range(1, 5):
    c += str(x)# hay que tratarlo como una cadena para que sea sucesivo.
    print(c)
    

# 8. Print the following pattern
# 1
# 1-2
# 1-2-3
# 1-2-3-4

for x in range(1, 5):
    c = ""# hay que ponerlo dentro de un for para que reinicie en cada línea.
    for z in range(1, x + 1):
        c += str(z)
        if z < x:
            c += "-"
    print(c)

# 9. Print the following pattern
# 4321
# 321
# 21
# 1

for x in range(4, 0, -1): # El -1 hace que vaya en decremento.
    c = ""
    for z in range(x, 0, -1):
        c += str(z)
    print(c)

# 10. Print the following pattern
# 4-3-2-1
# 3-2-1
# 2-1
# 1

for x in range(4, 0, -1):
    c = ""
    for z in range(x, 0, -1):
        c += str(z)
        if z > 1:
            c += "-"
    print(c)

# 11. Input a number and calculate the sum of all numbers from 1 to a given number. For
# example, if the user entered 10 the output should be 55 (1+2+3+4+5+6+7+8+9+10)

x = int(input("Teclea un número: "))
suma = 0

for r in range(1, x + 1):
    suma += r
print("La suma es: ", suma)

# 12. Given a list of numbers = [7, 8, 12, 29, 75, 150, 180, 145, 525, 50] print those that are
# divisible by 4 or by 5.

x = [7, 8, 12, 29, 75, 150, 180, 145, 525, 50] # Las llaves son para listar.

for y in x:
    if y % 4 == 0 or y % 5 == 0:
        print(y)

# 13. The same but stop the loop if a number is not greater than his predecessor.

x = [7, 8, 12, 29, 75, 150, 180, 145, 525, 50] # Las llaves sirven para listar.
z = 0

for y in x:
    if y < z:
        break
    if y % 4 == 0 or y % 5 == 0:
        print(y)
    z = y

# % es un módulo que da como resultado el resto ejemplo: if x % 4 == 0.
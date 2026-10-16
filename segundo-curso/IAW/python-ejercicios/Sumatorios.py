#Programa que pide al usuario que teclee una serie de numeros. 
# Cuando el usuario teclee el 0, el programa imprime la suma y termina.

x = 1
suma = -1

while x != 0:
    suma = suma + x
    x = int(input("Teclea un número: "))
print("La suma es: ", suma)

x = int(input("Teclea un número: "))
suma = 0

while x != 0:
    suma = suma + x
    x = int(input("Teclea un número: "))
print("La suma es: ", suma)


1

# Preguntar cuántos números se van a introducir
n = int(input("¿Cuántos valores va a introducir? "))

# Pedir el primer número
numero_anterior = int(input("Escriba un número: "))

# Bucle para pedir los demás números
for i in range(1, n):
    numero = int(input("Escriba un número más grande que " + str(numero_anterior) + ": "))
    
    # Comprobar si el número es mayor que el anterior
    if numero > numero_anterior:
        numero_anterior = numero  # Actualizamos el número anterior con el válido
    else:
        print("¡" + str(numero) + " no es mayor que " + str(numero_anterior) + "!")
        # Pedimos al usuario que ingrese un número válido
        numero = int(input("Escriba un número más grande que " + str(numero_anterior) + ": "))
        numero_anterior = numero  # Actualizamos el número anterior con el nuevo número válido

# Fin del programa
print("Game over")





2 

# Solicitar el número de palabras a ingresar
n = int(input("Escriba cuántas palabras tiene la lista: "))

# Crear la lista de palabras
palabras = []
for i in range(n):
    palabra = input(f"Escriba la palabra {i+1}: ")
    palabras.append(palabra)

# Solicitar la palabra a buscar
buscar = input("Dígame la palabra a buscar: ")

# Contar cuántas veces aparece la palabra en la lista
cantidad = palabras.count(buscar)

# Mostrar el resultado
print(f"La palabra {buscar} aparece {cantidad} veces en la lista")

# Finalizar el programa
print("Game over")

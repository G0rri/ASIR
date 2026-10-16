# Juego del ahorcado
# Pedimos una palabra al primer jugador
# Entramos en un bucle donde pedimos al segundo jugador una letra,
# y si existe en la palabra, mostramos su posición
# El bucle termina cuando la palabra esté completa o cuando se
# llegue a 10 fallos

s1 = input("Type the hyde word: ")
s2 = "_" * len(s1)
s2 = list(s2) # casting del string s2 a lista para poder hacer s2[i] = c
failed = 0

while failed < 10 and "_" in s2:
	c = input("Type a letter: ")
	if c in s1:
		for i in range(len(s1)):
			if s1[i] == c:
				s2[i] = c
	else:
		failed += 1
	print(s2, "Failed:", failed)
if failed == 10:
	print("You have lost!")
else:
	print("Congratulations!")
print("Game over")
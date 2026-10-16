print("Hello, World!")

x = 5
y = "Jhon"
print(x)
print(y)

x, y, z = "Orange", "Banana", "Cherry"
print(x)
print(y)
print(z)

x = y = z = "Orange"
print(x)
print(y)
print(z)

x = "Python"
y = "is"
z = "awesome"
print(x, y, z)
print(x + y + z)

x = 5
y = 10
print(x + y)

x = "awesome"

def myfunc():
  print("How is Python?")
  print("Python is " + x)

myfunc()
myfunc()

x = "awesome"

def myfunc():
  x = "fantastic"
  print("Python is " + x)

myfunc()

print("Python is " + x)
a = """Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."""
print(a)

a = "Hello, World!"
print(a[1])

y = 1
for x in "banana":
 print(x, y)
 y = y + 1
print('Fin del programa')

txt = 'The best thing in life are free!'
if 'xxx' in txt :
  print("Yes, 'free' is present.")
  print('Bye')
else :
  print("No, 'free' is not present.")
  print('Bye')
print('Se acabó')

b = "Hello Wolrd"
print(b[2:9])

a = "Hello World"
print(a.upper())
print(a)
a = a.upper() # upper es un método
print(a)

a = "       Hello, World"
b = "       Bye World"
print(a, b)
print(a.strip()) # Quita los espacios en blanco

a = "Hello, World"
print(a.replace("H", "J"))
print(a.replace("l", "*"))
print(a)
a = a.replace("Hello", "Hola")
a = a.replace("World", "Mundo")
print(a)

a = "Hello, World!, Python, ASIR"
b = a.split(",")
print(b)
print(b[0])
print(b[1])
print(b[2])

a = "Hello"
b = "World"
c = a + " " + b
print(c)

a = 33
b = 33

if b > a:
  print("b is greater")
elif a == b:
  print("a and b are equal")
else:
  print("a is greater than b")
print("Fin")

x = 4

if x > 10:
  print("Above ten,")
  if x > 20:
    print("and also above 20!")
  else:
    print("No above")

i = 1

while i < 6:
  print(i)
  i += 1
print("End")
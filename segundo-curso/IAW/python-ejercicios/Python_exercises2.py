# Write some functions that take a list of integers as argument and return the following:
# 1. The sum of the elements(no usar sum).

def mysum(mylist):
    s = 0
    for x in mylist:
        s += x
    return s

print(mysum([3, 4, 22, 11, 0, 4]))

# 2. The smallest element(no usar min).

def mymin(mylist):
    m = mylist[0]
    for x in mylist:
        if x < m:
            m = x
    return m

print(mymin([5, 2, 8, 1, 9]))

# 3. The largest element(no usar max).

def mymax(mylist):
    m = mylist[0]
    for x in mylist:
        if x > m:
            m =  x
    return m

print(mymax([5, 2, 8, 1, 9]))

# 4. How many elements are multiple of the number passed as second argument.

def my_mult(list, number):
    x = 0
    for y in list:
        if y % number == 0:
            x += 1
    return x

print(my_mult([1, 2, 3, 4, 5, 6], 2))

# 5. An object with sum, count, avg, max and min from the elements.

class MyClass:
    su = 0
    co = 0
    av = 0
    ma = 0
    mi = 0

def SuCoAvMaMi(mylist):
    x = MyClass()
    x.su = mysum(mylist)
    x.co = len(mylist)
    x.av = x.su / x.co
    x.ma = mymax(mylist)
    x.mi = mymin(mylist)
    return x

y = SuCoAvMaMi([3, 4, 55, 11, 0, 9])
print("Suma:", y.su, ", cuenta:", y.co, ", media:", y.av, ", máximo:", y.ma, ", mínimo:", y.mi)

# 6. A copy of the list ordered without duplicates, using sort() and pop() methods.

def ordenar(lista):
    x = lista.copy() #Crea una copia
    x.sort() #Ordena los elementos(ascendente)
    i = 0

    while i < len(x) - 1:
        if x[i] == x[i + 1]:
            x.pop(i) #Quita los duplicados
        else:
            i += 1
    
    return x

r = [5, 2, 8, 1, 9, 2, 5, 8, 3, 1, 9, 0]

print(ordenar(r))

# 7. The same as exercise 5, after adding the element passed as second argument.

class MyClass:
    su = 0
    co = 0
    av = 0
    ma = 0
    mi = 0

def SuCoAvMaMi(mylist, element):
    mylist.append(element) #Añade un elemento

    x = MyClass()
    x.su = mysum(mylist)
    x.co = len(mylist)
    x.av = x.su / x.co
    x.ma = mymax(mylist)
    x.mi = mymin(mylist)
    return x

y = SuCoAvMaMi([3, 4, 55, 11, 0, 9], 33)
print("Suma:", y.su, ", cuenta:", y.co, ", media:", y.av, ", máximo:", y.ma, ", mínimo:", y.mi)

# 8. The same as exercise 5, after deleting the element passed as second argument.

class MyClass:
    su = 0
    co = 0
    av = 0
    ma = 0
    mi = 0

def SuCoAvMaMi(mylist, element):
    if element in mylist:
        mylist.remove(element) #Elimina un elemento

    x = MyClass()
    x.su = mysum(mylist)
    x.co = len(mylist)
    x.av = x.su / x.co
    x.ma = mymax(mylist)
    x.mi = mymin(mylist)
    return x

y = SuCoAvMaMi([3, 4, 55, 11, 0, 9], 33)
print("Suma:", y.su, ", cuenta:", y.co, ", media:", y.av, ", máximo:", y.ma, ", mínimo:", y.mi)

# 9. The same as exercise 5, after adding the elements of the list passed as second argument.

class MyClass:
    su = 0
    co = 0
    av = 0
    ma = 0
    mi = 0

def SuCoAvMaMi(mylist, element):
    mylist.extend(element) #Añade los elementos de la segunda lista a la otra 

    x = MyClass()
    x.su = mysum(mylist)
    x.co = len(mylist)
    x.av = x.su / x.co
    x.ma = mymax(mylist)
    x.mi = mymin(mylist)
    return x

y = SuCoAvMaMi([3, 4, 55, 11, 0, 9], [1, 2, 1])
print("Suma:", y.su, ", cuenta:", y.co, ", media:", y.av, ", máximo:", y.ma, ", mínimo:", y.mi)

# 10. The element more repeated, using count() method. In case of tie, return the first one.
#Este ejercicio tuve que recurrir a la IA, ya que no encontrba como hacerlo correctamente.

def repeated(mylist):
    count = {}

    for q in mylist:
        if q in count:
            count[q] += 1
        else:
            count[q] = 1
    
    max_count = 0                 
    more_repeated = None

    for q,  w in count.items():
        if w > max_count:
            max_count = w
            more_repeated = q
    
    return more_repeated

e = repeated([1, 1, 1, 1, 2, 2, 2, 2, 3, 3])
print("El mas repetido es el: ", e)


# 11. Similar to exercise 6, but don’t return anything. Just order the original list and eliminate
# duplicates. Call the function in order to check that the list is passed by reference to the
# function.

def ordenar(lista):
    lista.sort()
    i = 0

    while i < len(lista) - 1:
        if lista[i] == lista[i + 1]:
            lista.pop(i) #Quita los duplicados
        else:
            i += 1
    
    return lista

r = [5, 2, 8, 1, 9, 2, 5, 8, 3, 1, 9, 0]
print(ordenar(r))

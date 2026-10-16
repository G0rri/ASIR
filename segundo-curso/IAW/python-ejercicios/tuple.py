# Using Tuples
# Es lo mismo que una lista pero se utiliza con () en vez de [],
# además de que no se puede modificar el contenido.
# 1. The sum of the elements.

def mysum(tuple):
    x = 0
    for i in tuple:
        x += i
    return x

print(mysum((3, 4, 22, 11, 0, 4)))

# 2. The smallest element.

def mymin(tuple):
    x = tuple[0]
    for i in tuple:
        if i < x:
            x = i
    return x

print(mymin((5, 2, 8, 1, 9)))

# 3. The largest element.

def mymax(tuple):
    x = tuple[0]
    for i in tuple:
        if i > x:
            x =  i
    return x

print(mymax((5, 2, 8, 1, 9)))

# 4. How many elements are multiple of the number passed as second argument.

def my_mult(tuple, number):
    x = 0
    for i in tuple:
        if i % number == 0:
            x += 1
    return x

print(my_mult((1, 2, 3, 4, 5, 6), 2))

# 5. An object with sum, count, avg, max and min from the elements.

class MyClass:
    su = 0
    co = 0
    av = 0
    ma = 0
    mi = 0

def SuCoAvMaMi(tuple):
    x = MyClass()
    x.su = mysum(tuple)
    x.co = len(tuple)
    x.av = x.su / x.co
    x.ma = mymax(tuple)
    x.mi = mymin(tuple)
    return x

y = SuCoAvMaMi((3, 4, 55, 11, 0, 9))
print("Suma:", y.su, ", cuenta:", y.co, ", media:", y.av, ", máximo:", y.ma, ", mínimo:", y.mi)

# 6. Nothing, but order the tuple and eliminate duplicates.

def ordenar(x):
    list = []
    
    for item in x:
        if item not in list:
            list.append(item)
            list.sort()
    
    return tuple(list)

mytuple = (1, 8, 4, 2, 0, 1, 4)  
result = ordenar(mytuple)
print(result)  

# 7. Nothing, but reverse the tuple.

mytuple = ()
for i in range(10,-1,-1):
    xtuple = (i,)
    mytuple += xtuple
print(mytuple)

# 8. A copy of the tuple ordered and without duplicates. Don’t change the original tuple.

def ordenado(tupla):
    lista = []
    
    for i in tupla:
        if i not in lista:  
            lista.append(i)  
    
    lista.sort()
    return tuple(lista)

mytuple = (1, 8, 4, 2, 0, 1, 4)  
print(ordenado(mytuple))  


# 9. True if all the tuple elements are the same, otherwise return false.

def same(tupla):
    element = tupla[0]  
    for i in tupla:
        if i != element:
            return False 
    return True 

print(same((1, 1, 1, 1)))
print(same((1, 2, 1, 1)))

# 10. True if all the tuple elements are greater than the number passed as second parameter.

def greater(tupla, numero):
    for i in tupla:
        if i <= numero:  
            return False  
    return True  

print(greater((5, 6, 7), 4)) 
print(greater((5, 3, 7), 4)) 
print(greater((10, 20, 30), 5))  
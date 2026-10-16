# Write a program that declare a global set like this:
# myset = ()
# The program interacts with the user through this menu:
# 1. Display all items
# 2. Clear
# 3. Add an item
# 4. Remove an item (avoid runtime errors)
# 5. Pop an item (avoid runtime errors)
# 6. Check if an item exists
# 7. Add some fruits { "apple", "banana", "cherry", “lemon” }
# 8. Subtract some big-techs { “google”, “amazon”, “apple”, “microsoft”}
# 9. Display all items in capital letters
# 10. Exit

myset = {'banana', 'pera', 'manzana'}

def menu():
    print("1. Display all items")
    print("2. Clear")
    print("3. Add an item")
    print("4. Remove an item (avoid runtime errors)")
    print("5. Pop an item (avoid runtime errors)")
    print("6. Check if an item exists")
    print("7. Add some fruits { 'apple', 'banana', 'cherry', 'lemon' }")
    print("8. Subtract some big-techs { 'google', 'amazon', 'apple', 'microsoft'}")
    print("9. Display all items in capital letters")
    print("10. Exit")
    return int(input("Option: "))

opt = 0
while opt != 10:
    opt = menu()
    
    if opt == 1:
        print(myset)

    elif opt == 2:
        myset.clear()
        print("Set limpio.")

    elif opt == 3:
        i = input("Añade un item: ")
        myset.add(i)
        print("'" + i + "' ha sido añadido al set.")

    elif opt == 4:
        i = input("Escribe un ítem para borrar: ")
        myset.discard(i) 
        print("'" + i + "' ha sido borrado con éxito.")

    elif opt == 5:
        if myset:
            i = myset.pop()  
            print("Se ha eliminado: '" + i + "'")
        else:
            print("Set está vacío, porfavor añada algo antes de hacer pop.")

    elif opt == 6:
        i = input("Escribe un ítem: ")
        if i in myset:
            print("'" + i + "' este ya existe en el set.")
        else:
            print("'" + i + "' este no existe en el set.")

    elif opt == 7:
        fruits = {'apple', 'banana', 'cherry', 'lemon'}
        myset.update(fruits) # Este método permite unir un set con otro.
        print("Fruta añadida.")

    elif opt == 8:
        big_techs = {'google', 'amazon', 'apple', 'microsoft'}
        myset.difference_update(big_techs) # Este método permite analizar 2 set y eliminar los elementos que se encuentren en el segundo set.
        print("La gran compañía ha sido sustraída")

    elif opt == 9:
        print({i.upper() for i in myset}) 
        
    elif opt == 10:
        print("Exiting the program.")

print("Game Over")

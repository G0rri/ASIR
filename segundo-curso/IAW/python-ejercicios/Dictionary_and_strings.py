# Write a program that declare a dictionary and a string like this:

# In a menu.

# The program should print the following:
# 1. The whole string
# 2. The string, one character per line
# 3. The number of repetitions for each character. How-to: for each character, add(or update)
# an item to the dictionary where the key is the character and the value is the number of 
# repetitions, and finally print the dictionary.
# 4. Keys unordened.
# 5. Keys ordered.
# 6. Keys in descending order.
# 7. Values unordered.
# 8. Values ordered.
# 9. Values in descending order.
# 10. Items unordered.
# 11. Items ordered by keys.
# 12. Items in descending order by key.
# 13. Items ordered by values.
# 14. Items in descending order by value
# 15. Quit.

d = dict()
s = '''Lorem ipsum dolor sit amet, 
    consectetur adipiscing elit, 
    sed do eiusmod tempor incididunt 
    ut labore et dolore magna aliqua.''' 

def menu():
    print('1. The whole string')
    print('2. The string, one character per line.')
    print('3. The number of repetitions for each character.')
    print('4. Keys unordened.')
    print('5. Keys ordered.')
    print('6. Keys in descending order.')
    print('7. Values unordered.')
    print('8. Values ordered.')
    print('9. Values in descending order.')
    print('10. Items unordered.')
    print('11. Items ordered by keys.')
    print('12. Items in descending order by key.')
    print('13. Items ordered by values.')
    print('14. Items in descending order by value.')
    print('15. Quit')
    return int(input("Option: "))

opt = 0
while opt != 15:
    opt = menu()

    if opt == 1:
        print(s)

    elif opt == 2:
        for x in s:
            print(x) 

    elif opt == 3:
        for x in s:
            if x in d:
                d[x] += 1
            else:
                d[x] = 1
        print(d)

    elif opt == 4:
        print(d.keys())

    elif opt == 5:
        print(sorted(d.keys()))

    elif opt == 6:
        y = sorted(d.keys())
        for x in range(len(y) - 1, -1, -1):
            print(y[x])

    elif opt == 7:
        print(d.values())

    elif opt == 8:
        print(sorted(d.values()))

    elif opt == 9:
        y = sorted(d.values())
        for x in range(len(y) - 1, -1, -1):
            print(y[x])
    
    elif opt == 10:
        print(d.items())

    elif opt == 11:
        print(sorted(d.items()))

    elif opt == 12:
        y = sorted(d.items())
        for x in range(len(y) - 1, -1, -1):
            print(y[x])

    elif opt == 13:
        def sort_by_value(item):
            return item[1]
        sorted_items = sorted(d.items(), key=sort_by_value)
        for x in sorted_items:
            print(x)

    elif opt == 14:
        def sort_by_value(item):
            return item[1]
        sorted_items = sorted(d.items(), key=sort_by_value)
        for x in range(len(sorted_items) -1, -1, -1):
            print(sorted_items[x])

    elif opt == 15:
        print("Exiting the program.")
        
print("You leave")

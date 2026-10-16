# Write a program that declare a dictionary like this:
# The program will ask the user for the name of a text file and print the number of repetitions for
# each word. If the file does not exist, display an error message.
# How-to:
# 1. Read the file and put it into an string
# 2. Remove punctuation marks from the string using translate method
# 3. Split the string in words using split method
# 4. For each word, add (or update) an item to the dictionary where the key is the word and
# the value is the number of repetitions
# 5. Print the dictionary

d = dict()

filename = input("Nombre del archivo de texto: ")
file = open(filename, 'r')

if not file:
    print("Error: El archivo no existe.")

else:
    x = file.read()
    
    marks = ".,;:!?\"'()-[]{}<>/\\|@#$%^&*_+=~`" 
    t = str.maketrans("", "", marks)
    text = x.translate(t)
    
    words = text.split()

    for word in words:
        word = word.lower()  
        if word in d:
            d[word] += 1
        else:
            d[word] = 1

print(d)

file.close()
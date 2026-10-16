# Make a program that merge two ordered input files and write them into an ordered output file.
# How-to:
# 1. Ask the user for the name of two input files. If some of them don’t exist, display an error
# message and exit.
# 2. Ask the user for the name the output file. If it exists, display a warning message and
# ask the user for overwriting the file or exit.
# 3. Using a while loop and the method readline(), read the input files line by line and write
# them into the output file in such a way that it is ordered too. Do not use any kind of
# array.
import os

def merge_files(if1, if2, of):
    with open(if1, 'r', encoding='utf-8') as file1, open(if2, 'r', encoding='utf-8') as file2, open(of, 'w', encoding='utf-8') as outfile:
        line1 = file1.readline()
        line2 = file2.readline()
        
        while line1 or line2:
            if not line1:
                outfile.write(line2 + '\n')
                line2 = file2.readline()
            elif not line2:
                outfile.write(line1 + '\n')
                line1 = file1.readline()
            elif line1 < line2:
                outfile.write(line1 + '\n')
                line1 = file1.readline()
            else:
                outfile.write(line2 + '\n')
                line2 = file2.readline()

if1 = input("Nombre del primer archivo: ")
if2 = input("Nombre del segundo archivo: ")
of = input("Nombre del archivo saliente: ")

if not os.path.exists(if1):
    print("Primer archivo no existe")
    exit()

if not os.path.exists(if2):
    print("Segundo archivo no existe")
    exit()

if os.path.exists(of):
    overwrite = input("El archivo de salida ya existe. ¿Desea sobrescribirlo? (s/n): ")
    if overwrite.lower() != 's':
        exit()

merge_files(if1, if2, of)
print('Ha salido exitosamente')
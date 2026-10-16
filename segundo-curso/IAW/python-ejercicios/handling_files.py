namefile = input('Type name file: ')
myfile = open(namefile)
x = 1
for myline in myfile:
    print(x, ':', myline)
    x += 1
myfile.close()
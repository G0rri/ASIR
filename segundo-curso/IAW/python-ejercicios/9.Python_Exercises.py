# 2. Make a Pyhton program that reads the csv file and display a graph bar like this:
import matplotlib.pyplot as plt
import os

f = input('Type csv file: ')
if not os.path.exists(f):
    print('File not found')
    exit()

x1 = list()
y1 = list()
x2 = list()
y2 = list()
x3 = list()
y3 = list()
file = open(f, 'r', encoding='utf-8')
line = file.readline()
leyenda = line.strip().split(',')[1:] # Para que el tercer nombre salga sin  espacios de por medio, hay que poner 2 veces el split.
line = file.readline()
print(line)

while line:
    x1.append(int(line.split(',')[0]) - 0.25)
    y1.append(int(line.split(',')[1]))
    x2.append(int(line.split(',')[0]))
    y2.append(int(line.split(',')[2]))
    x3.append(int(line.split(',')[0]) + 0.25)
    y3.append(int(line.split(',')[3]))
    line = file.readline()
file.close()

plt.bar(x1, y1, 0.25)
plt.bar(x2, y2, 0.25)
plt.bar(x3, y3, 0.25)
plt.title('2023 monthly sales report')
plt.legend(leyenda)
plt.xlabel("Months")
plt.ylabel("Millions Dollars")
plt.xticks(range(1, 13)) # Para que no se salte los números
plt.grid()
plt.show()

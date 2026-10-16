# 1. Make a program that plots the following:
# Se le debe pregntar al usuario
import matplotlib.pyplot as plt
x = [-4,0,4,0,-4] #No tocar
y = [0,-4,0,4,0]
plt.plot(x,y)
x = [-2,-2,2,2,-2]
y = [2,-2,-2,2,2]
plt.plot(x,y)
x = [-2,0,2,0,-2] #No tocar
y = [0,-2,0,2,0]
plt.plot(x,y)
x = [-1,-1,1,1,-1]
y = [1,-1,-1,1,1]
plt.plot(x,y)

plt.show()
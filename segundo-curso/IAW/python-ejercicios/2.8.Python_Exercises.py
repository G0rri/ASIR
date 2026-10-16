# 2. Make a program that plots the following functions:
# y = 5x+1
# y = 3x+2
# y = -3x+4
# y = -2x+1
# The range for x is from -10 to 10 with increments of 0.5
import matplotlib.pyplot as plt

xpoints = list()
qpoints = list()
wpoints = list()
epoints = list()
rpoints = list()


for i in range(-20, 20):
    xpoints.append(i/2)
    qpoints.append(5*i+1)
    wpoints.append(3*i*i+2)
    epoints.append(-3*i*i+4) #Importante no poner el menos en las variable, hay incompatibilidad.
    rpoints.append(-2*i*i*i+1)

plt.plot(xpoints, qpoints)
plt.plot(xpoints, wpoints)
plt.plot(xpoints, epoints)
plt.plot(xpoints, rpoints)
plt.grid()
plt.show()
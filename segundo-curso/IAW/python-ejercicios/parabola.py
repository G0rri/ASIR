import matplotlib.pyplot as plt

xpoints = list()
ypoints = list()
zpoints = list()

for i in range(-20, 20):
    xpoints.append(i)
    ypoints.append(i*i)
    zpoints.append(-i*i)

font1 = {'family':'serif','color':'blue','size':20}
plt.subplot(1, 2, 1)
plt.xlabel("X")
plt.ylabel("Y")
plt.title("Parábola normal", fontdict = font1)
plt.grid()
plt.plot(xpoints, ypoints, 'o-.m')
plt.subplot(1, 2, 2)
plt.plot(xpoints, zpoints, '*:r')
plt.xlabel("X")
plt.ylabel("Y")
plt.title("Parábola invertida", fontdict = font1)
plt.grid()
plt.show()
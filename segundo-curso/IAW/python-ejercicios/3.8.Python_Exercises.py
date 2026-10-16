# 3. Make a program that plots the following:
import math
import matplotlib.pyplot as plt

x = [i * 0.01 for i in range(int(-2 * math.pi / 0.01), int(2 * math.pi / 0.01) + 1)]
sin_x = [math.sin(i) for i in x]
cos_x = [math.cos(i) for i in x]

plt.plot(x, sin_x, label='sin x')
plt.plot(x, cos_x, label='cos x')

plt.xlim(min(x), max(x))
plt.ylim(-2, 2)

# El xticks se lo he pedido a la IA ya que no tenía ni idea de como mostrar los simbolos de pi en el eje x.
# Por lo que tengo entendido la r'$\pi$' es para mostrar el simbolo de pi usando el formateo de LaTeX.
plt.xticks(
    [-2 * math.pi, -3 * math.pi / 2, -math.pi, -math.pi / 2, 0, math.pi / 2, math.pi, 3 * math.pi / 2, 2 * math.pi],
    [r'$-2\pi$', r'$-\frac{3\pi}{2}$', r'$-\pi$', r'$-\frac{\pi}{2}$', '0', r'$\frac{\pi}{2}$', r'$\pi$', r'$\frac{3\pi}{2}$', r'$2\pi$']
)
plt.yticks([-2,-1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2])
plt.legend()
plt.grid(True)
plt.show()
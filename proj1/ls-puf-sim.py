from pypuf.simulation import LightweightSecurePUF
from pypuf.io import random_inputs
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

no_of_challenges=10_000
size_tab = np.array([8, 16, 24, 32, 48, 54, 64, 72, 80, 88, 96, 104, 112, 120, 128 ], dtype='int')
noisiness_tab = np.array([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0], dtype='float')

Z0 = np.empty(shape=[len(size_tab), len(noisiness_tab)], dtype='float')
Z1 = np.empty(shape=[len(size_tab), len(noisiness_tab)], dtype='float')

for size in range(len(size_tab)):
    for noise in range(len(noisiness_tab)):
        print("Rozmiar Lighweight Secure PUF:", size_tab[size], "Noisiness:", noisiness_tab[noise])

        puf = LightweightSecurePUF(n=size_tab[size], k=8, seed=1, noisiness=noisiness_tab[noise])
        response = puf.eval(random_inputs(n=size_tab[size], N=no_of_challenges, seed=1))

        hist, bin_edges = np.histogram(response, bins=2)
        print(hist)

        Z0[size][noise] = hist[0]
        Z1[size][noise] = hist[1]
        print("---------------------------------------")

print(np.amin(Z0), np.amax(Z0), np.amin(Z1), np.amax(Z1))
X, Y = np.meshgrid(size_tab, noisiness_tab, indexing='ij')

plot = plt.figure()
w = plot.add_subplot(projection='3d')
w.set_xlabel('n')
w.set_ylabel('noisiness')
w.set_zlabel(r'$Z_{0/1}$')
w.set_proj_type('ortho')
w.view_init(elev=30, azim=45)

w.plot_surface(X, Y, Z0, cmap=mpl.colormaps['Blues'], linewidth=.5, rstride=1, cstride=1)
w.plot_surface(X, Y, Z1, cmap=mpl.colormaps['Reds'], linewidth=.5, rstride=1, cstride=1)

plt.savefig('plot.png', dpi=300)
plt.show()

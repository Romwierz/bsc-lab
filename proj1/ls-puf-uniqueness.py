import sys
from pypuf.simulation import LightweightSecurePUF
from pypuf.io import random_inputs
from pypuf.metrics import uniqueness
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

# Ustaw domyślne wartości i sparsuj argumenty linii poleceń
mode = 'var_n'
n_k = 8
puf_seed = 1
challenges_seed = 1
uniq_seed = 1
image_name = 'plot.png'
show_plot = False
if len(sys.argv) > 1:
    if sys.argv[1] == 'var_k':
        mode = 'var_k'
    if len(sys.argv) > 2:
        n_k = int(sys.argv[2])
    if len(sys.argv) > 3:
        image_name = sys.argv[3]
    if len(sys.argv) > 4 and sys.argv[4] == 'show-plot':
        show_plot = True

no_of_challenges = 10_000
noisiness_tab = np.array([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0], dtype='float')

def var_n_sim(k=8):
    size_tab = np.array([8, 16, 24, 32, 48, 54, 64, 72, 80, 88, 96, 104, 112, 120, 128], dtype='int')
    Z_uniq = np.empty(shape=[len(size_tab), len(noisiness_tab)], dtype='float')

    for size in range(len(size_tab)):
        for noise in range(len(noisiness_tab)):
            print("Rozmiar Lighweight Secure PUF:", size_tab[size], "Noisiness:", noisiness_tab[noise])

            
            instances = [LightweightSecurePUF(n=size_tab[size], k=k, seed=seed,
                                              noisiness=noisiness_tab[noise]) for seed in range(5)]

            puf_uniq = uniqueness(instances, seed=uniq_seed, N=no_of_challenges)
            print ("LS PUF Uniqueness:", puf_uniq)

            Z_uniq[size][noise] = puf_uniq[0]
            print("---------------------------------------")

    return Z_uniq, size_tab

def var_k_sim(n=8):
    no_of_pufs_tab = np.array([8, 16, 24, 32, 48, 54, 64, 72, 80, 88, 96, 104, 112, 120, 128], dtype='int')
    Z_uniq = np.empty(shape=[len(no_of_pufs_tab), len(noisiness_tab)], dtype='float')

    for no_of_pufs in range(len(no_of_pufs_tab)):
        for noise in range(len(noisiness_tab)):
            print("Liczba składowych PUF w Lighweight Secure PUF:", no_of_pufs_tab[no_of_pufs], "Noisiness:", noisiness_tab[noise])

            instances = [LightweightSecurePUF(n=n, k=no_of_pufs_tab[no_of_pufs], seed=seed, 
                                              noisiness=noisiness_tab[noise]) for seed in range(5)]
            puf_uniq = uniqueness(instances, seed=uniq_seed, N=no_of_challenges)
            print ("LS PUF Uniqueness:", puf_uniq)

            Z_uniq[no_of_pufs][noise] = puf_uniq[0]
            print("---------------------------------------")

    return Z_uniq, no_of_pufs_tab

# Przeprowadź symulację
if mode == 'var_k':
    Z_uniq, n_k_tab = var_k_sim(n=n_k)
    desc = ' n='
else:
    Z_uniq, n_k_tab = var_n_sim(k=n_k)
    desc = ' k='

# Zapisz statystyki do pliku
with open("data-stats.txt", "a") as file:
    header = '\n--- ' + mode + desc + str(n_k) + ' puf_seed=' + str(puf_seed) + \
            ' challenges_seed=' + str(challenges_seed) + '\n'
    file.write(header)
    file.write('Z_uniq=[' + str(np.amin(Z_uniq)) + ',' + str(np.amax(Z_uniq)) + '], ')
    file.write('Z_uniq_mean=' + str(np.mean(Z_uniq)) + ', ')
    file.write('Z_uniq_std=' + str(np.std(Z_uniq)))

# Utwórz wykresy
X, Y = np.meshgrid(n_k_tab, noisiness_tab, indexing='ij')

plot = plt.figure()
w = plot.add_subplot(projection='3d')
xlabel = 'n' if mode == 'var_n' else 'k'
w.set_xlabel(xlabel)
w.set_ylabel('noisiness')
w.set_zlabel(r'$Z_{uniq}$')
w.set_proj_type('ortho')
w.view_init(elev=30, azim=45)

w.plot_surface(X, Y, Z_uniq, cmap=mpl.colormaps['PuRd'], linewidth=.5, rstride=1, cstride=1)

plt.savefig(image_name, dpi=300)
if show_plot: plt.show()

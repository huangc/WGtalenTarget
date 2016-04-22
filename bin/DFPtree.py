#!/usr/bin/python
# coding: utf-8

import sys
import numpy as np
import scipy as sp
import scipy.cluster.hierarchy as hac
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import dendrogram, linkage
import pandas as pd
from pandas import Series, DataFrame
import gzip
import re

infile = sys.argv[1]
outfile = sys.argv[2]

# Import data Seq.t_sum_Lg${GAP_MINSIZE_FP}.matrix as a panda dataframe object
# use the first row as header, first column as index
df = pd.read_table(infile, sep=' ', header=0, index_col=0) 

# Compute DM as a symmetrical nonnegative N-by-N distance matrix, 
# where DM[i,j] is the hamming distance between samples feature vectors i and j.

DM = DataFrame(np.zeros((len(df.columns), len(df.columns)), dtype='f'),  columns=df.columns, index=df.columns)

for i in df.columns:
    for j in df.columns:
        DM.ix[i,j] = sum(abs(df.ix[:,i] - df.ix[:,j])) / float(len(df.index)) 

# Plot distance matrix.
fig = plt.figure(figsize=(12,12))
axmatrix = fig.add_axes([0.3,0.1,0.6,0.6])

# Compute and plot first dendrogram.
ax1 = fig.add_axes([0.09,0.1,0.2,0.6])
Y1 = linkage(DM, method='centroid')
Z1 = dendrogram(Y1, orientation='right', labels=DM.index, leaf_font_size=9)
idx1 = Z1['leaves']

# Compute and plot second dendrogram.
ax2 = fig.add_axes([0.3,0.71,0.6,0.2])
Y2 = linkage(DM, method='centroid')
Z2 = dendrogram(Y2, labels=DM.index, leaf_font_size=9)
idx2 = Z2['leaves']

# Plot distance matrix.
DM1 = DM.ix[idx1,:]
DM2 = DM1.ix[:,idx2]
im = axmatrix.matshow(DM2, aspect='auto', origin='lower', cmap=plt.cm.YlGnBu)
axmatrix.set_xticks([])
axmatrix.set_yticks([])
# axmatrix.set_xticks(idx2, minor=True)
# axmatrix.set_xticklabels(idx2a, fontdict=None, minor=True, fontsize='small', horizontalalignment='center')

# Plot colorbar and save figure
axcolor = fig.add_axes([0.91,0.1,0.02,0.6])
plt.colorbar(im, cax=axcolor)
fig.show()
fig.savefig('Seq.t_sum_dendrogram.png')

# Output DM2
DM2.to_csv(outfile, sep='\t', float_format='%.2f')


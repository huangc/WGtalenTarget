#!/usr/bin/python
# coding: utf-8


# module add python
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

# Import data as a panda dataframe object
# use the first row as header, first column as index
df = pd.read_table(infile, sep=' ', header=0, index_col=0)

#? To compare every cultivar to reference, add a cultivar called REFERENCE to the df.

# Compute DM as a symmetrical nonnegative N-by-N distance matrix,
# where DM[i,j] is the hamming distance between samples feature vectors i and j.
DM = DataFrame(np.zeros((18, 18), dtype='f'),  columns=df.columns, index=df.columns)
DM2 = DataFrame(np.zeros((18, 18), dtype='f'),  columns=df.columns, index=df.columns)
DM3 = DataFrame(np.zeros((18, 18), dtype='f'),  columns=df.columns, index=df.columns)

for i in df.columns:
    for j in df.columns:
        DM.ix[i,j] = sum(abs(df.ix[:,i] - df.ix[:,j]))
        DM2.ix[i,j] = sum(abs(df.ix[:,i] - df.ix[:,j])) / 12738.0
        DM3.ix[i,j] = sum(abs(df.ix[:,i] - df.ix[:,j])) * 100 / 12738.0

# Output DM2
DM2.to_csv(outfile, sep='\t', float_format='%.2f')

# Compute and plot first dendrogram.
fig = pylab.figure(figsize=(8,8))
ax1 = fig.add_axes([0.09,0.1,0.2,0.6])
Y = linkage(DM2, method='centroid')
Z1 = dendrogram(Y, orientation='right')
# ax1.set_xticks([])
# ax1.set_yticks([])

# Compute and plot second dendrogram.
ax2 = fig.add_axes([0.3,0.71,0.6,0.2])
Y = linkage(DM2, method='single')
Z2 = dendrogram(Y)
# ax2.set_xticks([])
# ax2.set_yticks([])

# Plot distance matrix.
axmatrix = fig.add_axes([0.3,0.1,0.6,0.6])
idx1 = Z1['leaves']
idx2 = Z2['leaves']
DM2 = DM2.ix[idx1,:]
DM2 = DM2.ix[:,idx2]
im = axmatrix.matshow(DM2, aspect='auto', origin='lower', cmap=pylab.cm.YlGnBu)
# axmatrix.set_xticks([])
# axmatrix.set_yticks([])

# Plot colorbar.
axcolor = fig.add_axes([0.91,0.1,0.02,0.6])
pylab.colorbar(im, cax=axcolor)
fig.show()
fig.savefig('dendrogram.png')


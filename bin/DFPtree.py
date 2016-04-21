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
fig = plt.figure(figsize=(8,8))
ax1 = fig.add_axes([0.09,0.1,0.2,0.6])
Y1 = linkage(DM2, method='centroid')
Z1 = dendrogram(Y1, orientation='right')
idx1 = Z1['leaves']
idx1a = DM2.columns[idx1]
# ax1.set_yticks(idx1, minor=True)
# ax1.set_yticklabels(idx1a, fontdict=None, minor=True, horizontalalignment='center')

# Compute and plot second dendrogram.
ax2 = fig.add_axes([0.3,0.71,0.6,0.2])
Y2 = linkage(DM2, method='single')
Z2 = dendrogram(Y2)
idx2 = Z2['leaves']
idx2a = DM2.columns[idx2]
# ax2.set_xticks(idx2, minor=True)
# ax2.set_xticklabels(idx2a, minor=True)

# Plot distance matrix.
axmatrix = fig.add_axes([0.3,0.1,0.6,0.6])
DM2a = DM2.ix[idx1,:]
DM2b = DM2a.ix[:,idx2]
im = axmatrix.matshow(DM2b, aspect='auto', origin='lower', cmap=plt.cm.YlGnBu)
axmatrix.set_xticks(idx2, minor=True)
# axmatrix.set_xticklabels(idx2a, fontdict=None, minor=True, horizontalalignment='center', rotation='vertical')


# Plot colorbar.
axcolor = fig.add_axes([0.91,0.1,0.02,0.6])
plt.colorbar(im, cax=axcolor)
fig.show()
fig.savefig('dendrogram.png')

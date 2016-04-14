#!/usr/bin/env python2
# coding: utf-8

# from numpy import * as np
import numpy as np
import scipy.cluster.hierarchy as hac
import matplotlib.pyplot as plt
import gzip
import re
# from parsers import ped_iterator,strip_vcf,map_parser
# from distance import hamdist
# from itertools import izip


data = np.genfromtxt("Seq.t_sum_Lg20.Matrix", delimiter=' ', dtype = int)
fh = open("Seq.t_sum_Lg20.Matrix",'r')
for i,line in enumerate(fh):
    if i is n: break
    do_other_stuff_to_header(line)
fh.close()

#### Deletion Fingerprint (DFP) numbers of the sample cultivars:
* DFP are deletions of the assembled contigs when compared to reference genome by Blat alignment. They are further restricted to size range 20-5,000 bp and limited to genic region plus up-/down- stream 100 bp.
* Shared DFPs are defined as DFPs that have the exact same deletion start and end positions on the reference genome.
* DFP vector is a binary vector of sample that represents the prsence/absence of each accounted DFPs from all samples in comparison.
* The DFP distance between sample _**i**_ and _**j**_ is defined as the Hamming distance of the DFP vector between sample _**i**_ and _**j**_, divided by the total number of accounted DFPs from all samples in comparison. DFP distance of 0 indicates complete identical on all accounted DFPs, and distance of 1 indicates complete heterogeneous on all accounted DFPs.

##### YB samples
* YB1: 1196
* YB2: 2536
* YB3: 2718
* YB4: 2768
* YB5: 2889
* YB6: 2901
* YB7: 2885
* YB8: 2926

##### Temperate japonica
* GINMASARI: 1024
* KOTOBUKIMOCHI: 927
* NIPPONBARE (CX140): 380
* SACHIKAZE: 668

##### Tropical japonica
* BINIAPAN: 3497
* KOTOOURA: 3540
* PATIEROUGE: 3870
* MANYALOJOPOIHUN: 4175
* A2_257: 4555

##### Basmati/Aus
* ARC11571: 4772
* JC_157: 5236
* KEYANUNIA: 5385
* MADHUWAKARIA: 5384
* CR441: 5368

##### Indica
* OSATIVA: 8189
* CHINGCHUNG: 9381
* NIAOYAO: 7669
* CHINGLIU: 8389

#### Summary
##### Summary by DFP numbers (see details at VarYB-stat.result):
* Temperate_japonica < YB1 < YB2-8 < Tropical_japonica < Basmati/Aus < Indica
* YB2-8 samples have in average 2.3 folds more DFPs than YB1.   

##### Summary by DFP phylogeny (see details at VarYB_SeqDel_sum_dendrogram.png):
* YB1 is significantly closer to the Temperate japonica representatives than YB2-8.
* YB2-8 can be further clustered into two subgroups (YB2 YB3 YB4) and (YB5 YB6 YB7 YB8).

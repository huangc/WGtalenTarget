#!/bin/bash

echo "## Aim1: To demonstrate that YB1 has very distinct Deletion Fingerprints (DFP) [1] as compared to YB2-YB8, while YB2-YB8 share similar DFP. 
# Aim2: To investigate whether NIPPONBARE (CX140) is a close relative to sample YB1 as compared to YB2-YB8 samples.
# Proposition: Rice cultivars with high proportion of shared deletion sites [2] have similar DFP, and are close to each other in phylogeny.
# Method: Find DFP of CX140, YB1-YB8, then evaluate the proportion of shared deletion sites among them.
# SeqDel_sum_Lg5.table contains the deletion sites in size range 100-5,000 bp of samples YB1-YB8, as well as NIPPONBARE (CX140), 
# as compared to the reference Nipponbare IRGSP-1.0.
# Samples: YB1, YB2, YB3, YB4, YB5, YB6, YB7, YB8
# NIPPONBARE (cultivar CX140) is downloaded from 3kRGP.

# [1] Deletion Fingerprints (DFP): Set of deletions of the assembled contigs when compared to the reference genome. 
# To reduce the noise, we define DFP as the deletions that are located in the genic region (iloci).
# [2] Shared deletion site: the deletion site has EXACT start and end position in the reference for the compared samples.
#----------------------------
" > stat.result

# Setup for comparison
QUERY=NIPPONBARE
QUERYNAME=CX140
SAMPLE="YB1 YB2 YB3 YB4 YB5 YB6 YB7 YB8"
SAMPLENAME=YB

\rm -f FP*

for i in ${SAMPLE}
do
egrep "(${QUERY}|$i)" SeqDel_sum_Lg${GAP_MINSIZE_FP}.table > FP_union_${QUERYNAME}_${i}
egrep "${QUERY}" SeqDel_sum_Lg${GAP_MINSIZE_FP}.table | egrep "$i" > FP_intcpt_${QUERYNAME}_${i}
done


target=`wc -l SeqDel_sum_Lg${GAP_MINSIZE_FP}.table | cut -d" " -f1`
echo "Total deletion sites in SeqDel_sum_Lg${GAP_MINSIZE_FP}.table are $target" >> stat.result

query=`grep "NIPPONBARE" SeqDel_sum_Lg${GAP_MINSIZE_FP}.table | wc -l | cut -d" " -f1`
echo "Total deletion sites from ${QUERYNAME} are $query" >> stat.result

# grep union of all samples
egrep "(YB1|YB2|YB3|YB4|YB5|YB6|YB7|YB8)" SeqDel_sum_Lg${GAP_MINSIZE_FP}.table > FP_union_${SAMPLENAME}
samples=`wc -l FP_union_${SAMPLENAME} | cut -d" " -f1`
echo "Total deletion sites from ${SAMPLENAME} samples are ${samples}" >> stat.result

# grep intercept of all samples
egrep "${QUERY}" SeqDel_sum_Lg${GAP_MINSIZE_FP}.table | egrep "YB1" | egrep "YB2" | \
egrep "YB3" | egrep "YB4" | egrep "YB5" | egrep "YB6" | \
egrep "YB7" | egrep "YB8" > FP_intcpt_${QUERYNAME}_${SAMPLENAME}
query_samples=`wc -l FP_intcpt_${QUERYNAME}_${SAMPLENAME} | cut -d" " -f1`
echo "Total deletion sites that are shared among ${QUERYNAME} and ${SAMPLENAME} samples are ${query_samples}" >> stat.result
echo "" >> stat.result


for i in ${SAMPLE}
do
echo "##" >> stat.result
sample=`grep "$i" SeqDel_sum_Lg${GAP_MINSIZE_FP}.table | wc -l | cut -d" " -f1`
echo "Total deletion sites from sample ${i} are $sample" >> stat.result
query_sample=`wc -l FP_intcpt_${QUERYNAME}_${i}  | cut -d" " -f1`
echo "Total deletion sites from sample ${i} that are also shared with ${QUERYNAME} are ${query_sample}" >> stat.result
perc_sample=`awk "BEGIN { print ${query_sample}/${sample}*100 }"`
echo "Percentage of deletion sites that are shared by ${i} and ${QUERYNAME} as compared to deletion sites of sample ${i} is ${perc_sample}%" >> stat.result
done

echo "

#-------------------------
## Conclusion: 
#1. The NIPPONBARE (CX140) from 3kRGP has already accumulated 694 deletions as compared to the reference of its own.
#2. Using deletion sites as fingerprinting marker, NIPPONBARE shared similar number of deletions (187-212, average 201) 
#   with individual sample. Among them, 80 deletions sites are shared for NIPPONBARE and all YB1-YB8. 
#3. There are 2.86 folds more deletions in YB2-YB8 than in YB1, as compared to the reference Nipponbare.
#4. YB1 has higher percentage (10%) of Nipponbare-shared deletion sites than other YB samples (~3.8%).
#5. It is likely that YB1 is a cultivar closer to NIPPONBARE than YB2-YB8 are to NIPPONBARE, based on the observations #3 and #4.
#6. The Indel fingerprinting result is consistent with the SNP fingerprinting result, which shows strong evidence that 
#   NIPPONBARE is the closest relative among all 3kRGP to YB1. 

" >> stat.result


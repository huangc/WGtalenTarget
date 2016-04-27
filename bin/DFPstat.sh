#!/bin/bash

# PARAMETERS
QUERY=YB1
QUERYNAME=YB1
SAMPLE="YB1 YB2 YB3 YB4 YB5 YB6 YB7 YB8 GINMASARI KOTOBUKIMOCHI NIPPONBARE SACHIKAZE BINIAPAN KOTOOURA PATIEROUGE MANYALOJOPOIHUN A2_257 ARC11571 JC_157 KEYANUNIA MADHUWAKARIA CR441 OSATIVA CHINGCHUNG NIAOYAO CHINGLIU"
SAMPLENAME=VarYB
SANPLENUM=26
INFILE="VarYB_SeqDel_sum_Lg20.table"
OUTFILE="VarYB-stat.result"

##------------------------------
## NO MODIFICATION NEEDED BELOW
##------------------------------
mkdir -p ${SAMPLENAME}-on-${QUERYNAME}
\cp ${INFILE} ${SAMPLENAME}-on-${QUERYNAME}
cd ${SAMPLENAME}-on-${QUERYNAME}
\rm -f FP*

##--------------------------
echo "## Aim: To reveal the phylogenic relationship of ${QUERYNAME} as compared to ${SAMPLENAME} using Deletion Fingerprints (DFP) [1].
# Proposition: Rice cultivars with high proportion of shared deletion sites [2] have similar DFP, and are close to each other in phylogeny.
# Method: Find shared DFP of ${QUERYNAME} and ${SAMPLENAME}, then evaluate the proportion of shared deletion sites among them.
# Input: ${INFILE} contains the deletion sites in size range 100-5,000 bp of samples in the genic region plus 100 bp up- and downstream.
# ${SAMPLENAME} samples: ${SAMPLE}
# [1] Deletion Fingerprints (DFP): Set of deletions of the assembled contigs when compared to the reference genome.
# To reduce the noise, we define DFP as the deletions that are located in the genic region (iloci).
# [2] Shared deletion site: the deletion site has EXACT start and end position in the reference for the compared samples.
#----------------------------
" > ${OUTFILE}

for i in ${SAMPLE}
do
egrep "(${QUERY}|$i)" ${INFILE} > FP_union_${QUERYNAME}_${i}
egrep "${QUERY}" ${INFILE} | egrep "$i" > FP_intcpt_${QUERYNAME}_${i}
done

target=`wc -l ${INFILE} | cut -d" " -f1`
echo "Total deletion sites in ${INFILE} are $target" >> ${OUTFILE}

query=`grep "${QUERY}" ${INFILE} | wc -l | cut -d" " -f1`
echo "Total deletion sites in ${QUERYNAME} are $query" >> ${OUTFILE}

for i in ${SAMPLE}
do
echo "##" >> ${OUTFILE}
sample=`grep "$i" ${INFILE} | wc -l | cut -d" " -f1`
echo "Total deletion sites in sample ${i} is $sample" >> ${OUTFILE}
query_sample=`wc -l FP_intcpt_${QUERYNAME}_${i}  | cut -d" " -f1`
echo "Total shared deletion sites with ${QUERYNAME} in sample ${i} is ${query_sample}" >> ${OUTFILE}
perc_sample=`awk "BEGIN { print ${query_sample}/${sample}*100 }"`
echo "Percentage of shared deletion sites with ${QUERYNAME} in sample ${i} is ${perc_sample}%" >> ${OUTFILE}
done

##---------------
# Report
\cp ${OUTFILE} ..

##---------------
# grep union of all samples
# egrep "(YB1|YB2|YB3|YB4|YB5|YB6|YB7|YB8)" ${INFILE} > FP_union_${SAMPLENAME}
# samples=`wc -l FP_union_${SAMPLENAME} | cut -d" " -f1`
# echo "Total deletion sites from ${SAMPLENAME} samples are ${samples}" >> ${OUTFILE}

# grep intercept of all samples
# egrep "${QUERY}" ${INFILE} | egrep "YB1" | egrep "YB2" | \
# egrep "YB3" | egrep "YB4" | egrep "YB5" | egrep "YB6" | \
# egrep "YB7" | egrep "YB8" > FP_intcpt_${QUERYNAME}_${SAMPLENAME}
# query_samples=`wc -l FP_intcpt_${QUERYNAME}_${SAMPLENAME} | cut -d" " -f1`
# echo "Total deletion sites that are shared among ${QUERYNAME} and ${SAMPLENAME} samples are ${query_samples}" >> ${OUTFILE}
# echo "" >> ${OUTFILE}


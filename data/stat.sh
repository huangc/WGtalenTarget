#!/bin/bash

echo "## Aim: This is to investigate if NIPPONBARE is a closer relative to sample YB1 than to other YB samples.
# Proposition: Rice cultivars with similar InDel fingerprints are closer to each other.
# Method: investigate the closeness of NIPPONBARE to samples YB1-YB8 with the shared deletion sites from SeqDel_sum_Lg5.table
# SeqDel_sum_Lg5.table contains the deletion sites in size range 5-5,000 bp of samples YB1-YB8, as well as NIPPONBARE, 
# as compared to the reference Nipponbare IRGSP-1.0.
# Samples: YB1, YB2, YB3, YB4, YB5, YB6, YB7, YB8
# NIPPONBARE is downloaded from 3kRGP, cultivar CX140.
# Shared deletion site: the deletion site has EXACT start and end position in the reference for the compared samples.
#----------------------------
" > stat.result

SAMPLE="YB1 YB2 YB3 YB4 YB5 YB6 YB7 YB8"
for i in ${SAMPLE}
do
egrep "(NIPPONBARE|$i)" SeqDel_sum_Lg5.table > SeqDel_sum_grep_Nipp_or_${i}.table
egrep "NIPPONBARE" SeqDel_sum_Lg5.table | egrep "$i" > SeqDel_sum_grep_Nipp_n_${i}.table
done


Tot=`wc -l SeqDel_sum_Lg5.table | cut -d" " -f1`
echo "Total deletion sites from NIPPONBARE and samples YB1-YB8 are $Tot" >> stat.result

Nipp=`grep "NIPPONBARE" SeqDel_sum_Lg5.table | wc -l | cut -d" " -f1`
echo "Total deletion sites from NIPPONBARE are $Nipp" >> stat.result

egrep "(YB1|YB2|YB3|YB4|YB5|YB6|YB7|YB8)" SeqDel_sum_Lg5.table > SeqDel_sum_grep_samples.table
Samples=`wc -l SeqDel_sum_grep_samples.table  | cut -d" " -f1`
echo "Total deletion sites from samples YB1-YB8 are ${Samples}" >> stat.result

egrep "NIPPONBARE" SeqDel_sum_Lg5.table | egrep "YB1" | egrep "YB2" | \
egrep "YB3" | egrep "YB4" | egrep "YB5" | egrep "YB6" | \
egrep "YB7" | egrep "YB8" > SeqDel_sum_grep_Nipp_n_all.table
Nipp_All=`wc -l SeqDel_sum_grep_Nipp_n_all.table  | cut -d" " -f1`
echo "Total deletion sites that are shared among NIPPONBARE and samples YB1-YB8 are ${Nipp_All}" >> stat.result
echo "" >> stat.result


for i in ${SAMPLE}
do
Sample=`grep "$i" SeqDel_sum_Lg5.table | wc -l | cut -d" " -f1`
echo "" >> stat.result
echo "Total deletion sites from sample ${i} are $Sample" >> stat.result
Nipp_Sample=`wc -l SeqDel_sum_grep_Nipp_n_${i}.table  | cut -d" " -f1`
echo "Total deletion sites from NIPPONBARE that are also shared with sample ${i} are ${Nipp_Sample}" >> stat.result
Perc_sample=`awk "BEGIN { print ${Nipp_Sample}/${Sample}*100 }"`
echo "Percentage of Nipponbare deletion sites that are shared with ${i} as compared to deletions of sample ${i} is ${Perc_sample}%" >> stat.result
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
#   NIPPONBARE is the closest relative among all 3kRGP to YB1, while B182 is the closest relative of all 3kRGP to YB2-YB8. 

" >> stat.result


# Finding whole genome TALEN off-target sites with denovo-assembled contigs from NGS reads
Contributed by Chun-Yuan Huang, 2/16/2016

## Aims:
Transcription activator-like effector nucleases (TALENs) is a genetic engineering powertool in generating site-specific mutagenesis in plants. TALEN attributes its site-specific DNA recognition and cleavage to its highly editable and specific DNA recognition repeats domain (derived from TAL effector), and its DNA cleavage domain (derived from endonuclease FokI). However, TALENs can potentially leave receiving plants with undesired off-target cleavage sites. This workflow is to find whole genome (WG) TALEN off-target sites of genomic samples using three-step approach: the first step to find WG deletion sites using the blat algorithm, the second step to find predicted TALEN off-target sites using the TALE-NT2 targetter, and the third step to find the overlapping sites for deletions that are predicted to be TALEN target sites. Blat (BLAST-like alignment tool) is used for the pairwise sequence alignment of denovo-assembled contigs against reference in order to identify long indels. The workflow takes paired-TALEN RVD sequences and de-novo assembled contigs as inputs, then generates summary table that describe the overlappiing sites for both deletions and TALEN target sites of the sample. The workflow can be used as a off-target site search tool, as well as an on-target site validation tool.

## Workflow description:
1. WG Blat of sample contigs (by SOAP-denovo assembly using TRegGA) against reference.
2. Make indel summary table that combines same indels from all samples in each row based on the indel features
3. Use the indel summary table to retrieve indel sequences.

## Workflow execution:
1. Edit and setup the parameters as described in 0SOURCE, then `source 0SOURCE`
2. Edit and prepare for the prerequisite files and softwares as described in PREREQ.sh, then `sh PREREQ.sh`
3. Submit qsub script for whole genome blat alignment on Mason: `qsub x1-WGblat`
4. Submit qsub script for whole genome indel analysis on Mason: `qsub x2-WGindel`
5. Submit qsub script for TALE-NT2 targetter on Mason: `qsub x3-TALENtarget`
6. Submit qsub script for TALEN target and deletion overlapping site finder on Mason: `qsub x4-TALENdelfinder`
6. Find main outputs in *data/*.
6. Cleanup files with `sh xcleanup`

## Sub-directories for workflow implementation:
1. *prereq/*: prerequisite inputs such as retrieval and storage of TRegGA assembled contigs; retrieval and storage of reference genomes, preparation of BLAST+ database for reference genome.
2. *doc/*: reference and tutorial documents.
3. *bin/*: ancillary codes and scripts.
4. *run/*: main scripts and execution results.
5. *data/*: final outputs and reports.

## Notes: 
1. The workflow default to run a test case using 10% contigs from rice cultivar Zhengshan97 against reference rice Japponica Chr10. 
2. The run time for whole genome blat of a typical 3kRGP rice cultivar contigs against reference rice Japonica takes about 90-100 hrs on Mason, so plan carefully for submitting the job `x1-WGblat`.
3. Make sure blast+ is in your PATH: */N/dc2/projects/brendelgroup/TRegGA/bin*

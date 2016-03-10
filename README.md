# Finding whole genome TALEN target and off-target sites with denovo-assembled contigs from NGS reads
Contributed by Chun-Yuan Huang, 3/8/2016

## Aims:
Transcription activator-like effector nuclease (TALEN) is a genetic engineering powertool in generating site-specific mutagenesis in plants. TALEN attributes its site-specific DNA recognition and cleavage to its highly editable and specific DNA recognition repeats domain (derived from TAL effector), and its DNA cleavage domain (derived from endonuclease FokI). However, TALEN can potentially leave receiving plants with undesired off-target cleavage sites. This workflow is to find whole genome (WG) TALEN target and off-target sites of genomic samples using three-step approach: the first step to find WG deletion sites using the blat algorithm, the second step to find predicted TALEN target sites using the TALE-NT2 targetter, and the third step to identify the WG deletions sites that are predicted to be TALEN target sites. Blat (BLAST-like alignment tool) is used for the pairwise sequence alignment of denovo-assembled contigs against reference in order to identify long indels. The workflow takes paired-TALEN repeat variable diresidue (RVD) sequences and de-novo assembled contigs as inputs, then generates summary table that describe the associated sites for both deletions and TALEN target sites of the sample. The workflow can be used as a off-target site search tool, as well as an on-target site validation tool.

## Workflow description:
1. WG blat of sample contigs (by SOAP-denovo2 assembly) against reference.
2. Make indel summary table for each deletion in sample contigs and filter for desired gap sizes.
3. Find paired TALEN binding sites in each sample.
4. Generate join table that contains the "associated" pTALEN and indels for each sample, where the association is defined by the desired distance (e.g. 10 bp) between pTALEN and indel.

## Workflow execution:
1. Edit and setup the parameters as described in 0SOURCE, then `source 0SOURCE`
2. Edit and prepare for the prerequisite files and softwares as described in PREREQ.sh, then `sh PREREQ.sh`
3. Generate and submit qsub script for whole genome blat alignment: `sh x1-WGblat`
4. Submit qsub script for whole genome indel analysis: `qsub x2-WGindelT`
5. Submit qsub script for TALE-NT2 target finder: `qsub x3-WGtalen`
6. (Optional) submit qsub script for finding leftover TDNA vector sequence: `qsub x4-WGtdna`  
7. Find main outputs in: *data/*.
8. Cleanup files with: `sh xcleanup`

## Sub-directories for workflow implementation:
1. *prereq/*: prerequisite inputs such as retrieval and storage of TRegGA assembled contigs; retrieval and storage of reference genomes, preparation of BLAST+ database for reference genome.
2. *doc/*: reference and tutorial documents.
3. *bin/*: ancillary codes and scripts.
4. *src/*: prerequisite softwares
5. *run/*: main scripts and execution results.
6. *data/*: final outputs and reports.
7. *doc/*: reference and tutorial documents.

## Notes: 
1. The run time for whole genome blat of a typical 3kRGP rice cultivar contigs against reference rice Japonica takes about 120 hrs on Mason, so plan carefully for submitting the job `x1-WGblat`.

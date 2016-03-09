*blat_at_pTALENdel* directory contains:
* The deletion site from reference sequence plus its surrounding GAP_BORDER size, as reported in SeqDel_pTALENs-on-*.OUT, are retrieved for blat alignment against sample contig for evaluation of the pTALEN target site. 
* Filenames are in this format: *blat.Sample.Contig-on-RefChr.GapStart.GapEnd.psl.pretty.(long)*
* Files of *.psl.pretty.long: the regular blat alignment.
* Files of *.psl.pretty: the concised version of *.psl.pretty.long where a long deletion region is indicated by its length instead of its actual sequences.
* The blat alignment result could be suboptimal depending on the deletion's site in contig or its size. Adjust PERC_IDENTITY_RET value to optimize the blat alignment, if needed.
* Note that a deletion at low complexity region may be contributed to sequencing error, and not considered a good candidate for pTALEN target.


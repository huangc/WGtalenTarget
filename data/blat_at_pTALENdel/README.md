*blat_at_pTALENdel* directory contains:
* The blat alignments of the pTALEN target sites against the reference, as reported in SeqDel_pTALENs-on-*.OUT. 
* Files of *.psl.pretty.long: the regular blat alignment.
* Files of *.psl.pretty: the concised version of *.psl.pretty.long where a long deletion region is indicated by its length instead of its actual sequences.
* Filenames are in this format: *blat.Sample.Contig-on-RefChr.GapStart.GapEnd.psl.pretty.(long)*
* Note that the deletion site from reference sequence plus its surrounding GAP_BORDER size, defined in 0SOURCE, are retrieved for blat alignment with the full sample contig. The blat alignment result could be less than optimal or absent due to the deletion's site in contig or its size. Lower PERC_IDENTITY_RET value, defined in 0SOURCE, to optimize the blat alignment if needed.
* Note that a deletion at low complexity region may be contributed to sequencing error, and not considered a good candidate for pTALEN target.


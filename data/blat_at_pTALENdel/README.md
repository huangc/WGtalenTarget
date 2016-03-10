*blat_at_pTALENdel* directory contains:
* Filenames are in this format: *blat.Sample.Contig-on-RefChr.GapStart.GapEnd.psl.pretty.(long)*
* Files of *.psl.pretty.long: the regular blat alignment.
* Files of *.psl.pretty: the concised version of *.psl.pretty.long where a long deletion region is indicated by its length instead of its actual sequences.
* The blat alignment result could be suboptimal depending on the deletion's site in contig or its size. Adjust PERC_IDENTITY_RET value (in 0SOURCE) to optimize the blat alignment, if needed.
* Note that a deletion at low complexity region may have confounding factor from sequencing error, and should be more careful in consideration for pTALEN target candidate.


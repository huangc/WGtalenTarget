## *src/* directory contains prerequisite softwares:
- blat
- blast+
- talesf-paired (Paired Target Finder for TALEN binding sites)

WGtalenTarget is implemented as a collection of shell scripts and ancillary Python codes, so no compilation is required. However, the workfl\
ow depends on several third-party programs, and many of which do require compiling and/or additional configuration for your particular syste\
m. Please see the cited URLs below for details on the software installation. *src/* is assumed for the installation path, but should be repl\
aced with the actual path.

For IU Mason cluster users, the prerequisite softwares can be loaded from the system:
- module add blat/35

### Blat
* See https://genome.ucsc.edu/FAQ/FAQblat.html.
* Last update: Dec. 2014
```bash
cd ${src_DIR}
mkdir blatSuite
cd blatSuite
wget http://hgwdev.cse.ucsc.edu/~kent/exe/linux/blatSuite.zip
unzip blatSuite.zip
export PATH=$PATH:${src_DIR}/blatSuite
```

### BLAST
* See https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download.
* Last update: Dec. 2015
```bash
cd ${src_DIR}
mkdir blast
cd blast
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.3.0/ncbi-blast-2.3.0+-x64-linux.tar.gz
tar -xzf ncbi-blast-2.3.0+-x64-linux.tar.gz
export PATH=$PATH:${src_DIR}/blast//ncbi-blast-2.3.0+/bin
```

### Paired TALEN Target Finder
* See https://github.com/boglab/talesf/tree/paired
* Last update: Sep. 2015
```bash
module load gcc
cd ${src_DIR}
mkdir -p tale_nt2
cd tale_nt2
# git clone the target finder
git clone https://github.com/boglab/talesf.git

# git clone the utils
cd talesf/
git clone https://github.com/boglab/cutils.git
\rm -r bcutils/
mv cutils/ bcutils/
cd bcutils/
make

# download the paired target finder
cd ${src_DIR}/tale_nt2
wget https://github.com/boglab/talesf/archive/paired.zip
unzip paired.zip
cd talesf-paired/
git clone https://github.com/boglab/cutils.git
\rm -r bcutils/
mv cutils/ bcutils/
cd bcutils/
make

# modify original talesf and talesf-paired makefiles for LD_LIBRARY_PATH error
cd ${src_DIR}/tale_nt2/talesf
sed -i 's/gcc -fmax/gcc -I . -L . -L bcutils -fmax/' makefile
make
make frontend

cd ${src_DIR}/tale_nt2/talesf-paired
sed -i 's/gcc -fmax/gcc -I . -L . -L bcutils -fmax/' makefile
make
make frontend

export PATH=$PATH:${src_DIR}/tale_nt2/talesf
export PATH=$PATH:${src_DIR}/tale_nt2/talesf-paired
export LD_LIBRARY_PATH=$(pwd)/bcutils:$(pwd)
```

#!/bin/bash -l
#$ -S /bin/bash
#$ -l h_rt=1:00:0
#$ -l mem=2G
#$ -l tmpfs=15G
#$ -N MD
#$ -pe mpi 2
#$ -cwd 

module unload compilers mpi
module load compilers/intel/2015/update2
module load mpi/intel/2015/update3/intel
module load gromacs/5.1.1/intel-2015-update2

module load python/3.6.3
module load boost/1_63_0/gnu-4.9.2
module load dssp/3.0.0/gnu-4.9.2

export DSSP="$(which mkdssp)"

echo 1 | gmx do_dssp -f C226S.pdb -s C226S.pdb -ssdump ssdump.dat -map ss.map -o ss.xpm -sc scount.xvg -a area.xpm -ta totarea.xvg -aa averarea.xvg -tu ns

gmx xpm2ps -f ss.xpm -o ss.eps
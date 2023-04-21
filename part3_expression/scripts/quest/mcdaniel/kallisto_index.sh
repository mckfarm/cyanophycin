#!/bin/bash
#SBATCH --job-name="kallisto_index"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 01:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output=out_kall_index.txt
#SBATCH --error=err_kall_index.txt

module purge all
module load kallisto/0.46.1

cd /projects/b1052/mckenna/cyanophycin/mcdaniel2021

kallisto index -i ./kallisto/allmags.idx ./prokka/cds_allmags.ffn

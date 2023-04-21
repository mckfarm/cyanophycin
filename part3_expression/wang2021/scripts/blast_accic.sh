#!/bin/bash
#SBATCH --job-name="blast_ic"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 10:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output=blast.out
#SBATCH --error=blast.err

module purge all
module load blast/2.12.0

cd /projects/b1052/mckenna/blast_db/ppk1

blastn -query /projects/b1052/mckenna/cyanophycin/wang2021/prokka/Acc_IC/Acc_IC.ffn \
-db ppk1 -task blastn -evalue 1e-10 \
-out /projects/b1052/mckenna/cyanophycin/wang2021/blast_ic/blast_ic.txt -outfmt "6 std staxids sscinames scomnames pident qcovs"

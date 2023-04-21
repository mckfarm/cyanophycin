#!/bin/bash
#SBATCH --job-name="prokka"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 12:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=6
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output=out_prokka.txt
#SBATCH --error=err_prokka.txt

module purge all
module load python/anaconda3.6
source activate /projects/b1052/pythonenvs/python3.6/prokka
module load perl/5.26

cd /projects/b1052/McKenna/cyanophycin/wang2021/raw_data

for F in *.fna; do
  N=$(basename $F .fna) ;
  prokka $F --outdir ../prokka/$N --prefix $N --metagenome --cpus 6;
done

#!/bin/sh
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 04:00:00
#SBATCH --mem=5G
#SBATCH --job-name="fasterq_dump"
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module purge all
module load sratoolkit/2.10.5
cd /projects/b1052/mckenna/cyanophycin/mcdaniel2021/raw_data

fasterq-dump SRR12813959
fasterq-dump SRR12813960
fasterq-dump SRR12813961
fasterq-dump SRR12813962
fasterq-dump SRR12813963
fasterq-dump SRR12813964
fasterq-dump SRR12813965

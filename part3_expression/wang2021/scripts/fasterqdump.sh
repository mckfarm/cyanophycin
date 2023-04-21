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

fasterq-dump SRR10267787
fasterq-dump SRR10267788
fasterq-dump SRR10267789
fasterq-dump SRR10267790
fasterq-dump SRR10267791
fasterq-dump SRR10267792

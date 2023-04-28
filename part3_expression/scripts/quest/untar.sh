#!/bin/bash
#SBATCH --job-name="untar"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output=untar.out
#SBATCH --error=untar.err

module purge all

cd /projects/b1052/mckenna/cyanophycin/

tar -xvf wang2021.tar.gz 
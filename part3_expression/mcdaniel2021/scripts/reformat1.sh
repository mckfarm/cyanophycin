#!/bin/bash
#SBATCH --job-name="reformat"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH --output=/projects/b1052/mckenna/cyanophycin/mcdaniel2021/scripts/reformat_%A_%a.out
#SBATCH --error=/projects/b1052/mckenna/cyanophycin/mcdaniel2021/scripts/reformat_%A_%a.err
#SBATCH --array=1-7
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all

param_store=/projects/b1052/mckenna/cyanophycin/mcdaniel2021/scripts/reformat1.txt
# reformat.txt should be formatted like this
# in1.fastq in2.fastq out.fastq

param_a=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
param_b=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
param_c=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')

/home/mmf8608/programs/bbmap_38.94/reformat.sh -Xmx1g -eoom \
in1=$param_a in2=$param_b out=$param_c

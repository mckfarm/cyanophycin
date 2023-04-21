#!/bin/bash
#SBATCH --job-name="bbduk"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 02:00:00
#SBATCH -N 1
#SBATCH --mem=10G
#SBATCH --output=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/bbduk_%A_%a.out
#SBATCH --error=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/bbduk_%A_%a.err
#SBATCH --array=1-6
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all

# reference command
# bbduk.sh in=data.fa outm=ribo.fa outu=nonribo.fa k=31 ref=silva.fasta

param_store=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/bbduk_16s.txt
# bbduk_16s.txt should be formatted like this
# inputfastq output16s outputclean

param_a=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
param_b=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
param_c=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')

/home/mmf8608/programs/bbmap_38.94/bbduk.sh -Xmx10g -eoom \
in=$param_a outm=$param_b outu=$param_c k=31 ref=/projects/b1052/shared/SILVA_138.1_SSURef_NR99_tax_silva.fasta

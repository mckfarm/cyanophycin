#!/bin/bash
#SBATCH --job-name="kallisto_quant"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 10:00:00
#SBATCH -N 1
#SBATCH --output=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/kallisto_%A_%a.out
#SBATCH --error=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/kallisto_%A_%a.err
#SBATCH --array=1-6
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu


module purge all
module load kallisto/0.46.1

param_store=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/kallisto_quant.txt

param_a=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
param_b=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
param_c=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')

kallisto quant -i /projects/b1052/McKenna/cyanophycin/wang2021/kallisto/allmags.idx \
-o $param_a $param_b $param_c

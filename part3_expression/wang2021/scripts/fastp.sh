#!/bin/bash
#SBATCH --job-name="fastp"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 01:00:00
#SBATCH -N 1
#SBATCH --mem=5G
#SBATCH --output=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/fastp_%A_%a.out
#SBATCH --error=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/fastp_%A_%a.err
#SBATCH --array=1-6
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu

module purge all
module load python/anaconda3.6
source activate /projects/b1052/pythonenvs/python3.6/fastp

param_store=/projects/b1052/McKenna/cyanophycin/wang2021/scripts/fastp.txt

param_a=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
param_b=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
param_c=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')
param_d=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $4}')
param_e=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $5}')
param_f=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $6}')

fastp -i $param_a -I $param_b -o $param_c -O $param_d -h $param_e -j $param_f

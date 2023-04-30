#!/bin/bash
#SBATCH --job-name="gg_viz"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 00:05:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=1G
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output=gg_viz.out
#SBATCH --error=gg_viz.err

module purge all
module load python/anaconda3.6
source activate /projects/b1052/pythonenvs/python3.9/genegrouper

cd /projects/b1052/mckenna/cyanophycin/genegrouper/

GeneGrouper -n cpha -d gg_search visualize \
--visual_type main

GeneGrouper -n cpha -d gg_search visualize \
--visual_type group --group_label -1

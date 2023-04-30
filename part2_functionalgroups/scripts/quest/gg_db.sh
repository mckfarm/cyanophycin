#!/bin/bash
#SBATCH --job-name="gg_db_sch"
#SBATCH -A b1042
#SBATCH -p genomicsguest
#SBATCH -t 00:20:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=10G
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output=gg_db_sch.out
#SBATCH --error=gg_db_sch.err

module purge all
module load python/anaconda3.6
source activate /projects/b1052/pythonenvs/python3.9/genegrouper

cd /projects/b1052/mckenna/cyanophycin/genegrouper

GeneGrouper -g ./genomes -d ./gg_search build_database

GeneGrouper -n cpha -g genomes -d gg_search find_regions -f query_genes/uniprot_cphA.txt \
-us 6000 -ds 6000 -i 20 -c 80 --min_group_size 2

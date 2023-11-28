#!/usr/bin/env bash

#SBATCH -p short
#SBATCH --job-name=example
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=32gb
#SBATCH --time=23:00:00
#SBATCH --mail-type=NONE
#SBATCH --mail-user=emye7956@email.com

set -e pipefail

### TODO: modify these paths for each setup! 

# scripts
index_script=src/index.sh # This has the snakefile instructions

# directories
main_dir="/Users/emye7956/research/projects/Group-6-Metagenomic-Pipeline/"
out_dir="/Users/emye7956/research/projects/Group-6-Metagenomic-Pipeline/doc/data/"
config_dir="/Users/emye7956/research/projects/Group-6-Metagenomic-Pipeline/src/"

# config file
config_file=$config_dir'config.yml' # This file also needs unique path changes prior

# make log directory
test ! -d $out_dir"log/" && mkdir $out_dir"log/"

# move to project dir
cd $main_dir

# run indexing step
echo "Running QC step."
bash $index_script $main_dir $out_dir $config_file

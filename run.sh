#!/usr/bin/env bash

### TODO: modify these options for your system !

#SBATCH -p short
#SBATCH --job-name=example
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=32gb
#SBATCH --time=23:00:00
#SBATCH --mail-type=NONE
#SBATCH --mail-user=emye7956@email.com
#SBATCH --output=err/
#SBATCH --error=err/

set -e pipefail

### TODO: modify these paths for each setup! 

# scripts
# index_script=src/index.sh # WE STILL NEED TO EDIT THE INDEX SCRIPT

# directories
main_dir="/Users/emye7956/research/projects/Group-6-Metagenomic-Pipeline/"
out_dir="/Users/emye7956/research/projects/Group-6-Metagenomic-Pipeline/doc/data/"
config_dir="/Users/emye7956/research/projects/Group-6-Metagenomic-Pipeline/src/"

# config file
config_file=$config_dir'config.yml' # MAKE SURE THIS FILE GETS PUT IN THE RIGHT PLACE

# make log directory
test ! -d $out_dir"log/" && mkdir $out_dir"log/" # HUH - CHECK UP ON THIS 

# move to project dir
cd $main_dir

# run indexing step
echo "Running QC step."
bash $index_script $main_dir $out_dir $config_file

#!/usr/bin/env bash

pmed_dir=$1
out_dir=$2
config=$3 

echo $pmed_dir
echo $out_dir
echo $config

## These directories should be correct.
## If you have changed where scripts exist, change these paths
smk_dir=$pmed_dir"workflow/"
log='log/ind_log.txt'
##
##

# for singularity container 
#. /opt/conda/etc/profile.d/conda.sh
# load conda and activate snakemake env for run
#module load anaconda
#.~/miniconda3/bin/conda
#conda_dir="/home/sdp/miniconda3/envs/"
#source ~/miniconda3/etc/profile.d/mamba.sh 
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:~/miniconda3/condabin/conda
#conda activate snakemake

# activate conda / mamba
source  ~/.bashrc
# go to project directory
echo 'Going to project directory...'
cd ~/Group-6-Metagenomic-Pipeline

# runnning QC pipeline
echo 'running QC pipeline' > $log
start_slice=$(date +%s.%3N)
snakemake \
    -s snakeFile \
    -c 16 \
    -j 5 \
    --configfile=$config
end_slice=$(date +%s.%3N)
slice_time=$(echo "scale=3; $end_slice - $start_slice" | bc)
echo "QC: $slice_time seconds" >> $log
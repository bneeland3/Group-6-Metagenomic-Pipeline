#!/usr/bin/env bash

# these positional arguments get called in in run.sh 
main_dir=$1 # Location of snakefile and runsh file.
out_dir=$2
config=$3 

echo $main_dir
echo $out_dir
echo $config

## These directories should be correct.
## If you have changed where scripts exist, change these paths
smk_dir=$main_dir
log=$out_dir'log/ind_log.txt'

# ADD TO THE README FOR INITIAL SETUP - this needs to be editted/removed
# for singularity container 
#. /opt/conda/etc/profile.d/conda.sh
# load conda and activate snakemake env for run
# module load anaconda
#.~/miniconda3/bin/conda
#conda_dir="/home/sdp/miniconda3/envs/"
#source ~/miniconda3/etc/profile.d/mamba.sh 
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:~/miniconda3/condabin/conda
#conda activate quality

# activate conda / mamba (PUT AN EG OF OUR BASHRC ON REPO)
# source  ~/.bashrc
# source ~/miniconda3/bin/activate
# conda activate quality
echo 'Going to project directory...'
cd $main_dir

# runnning QC pipeline
echo 'running QC pipeline' > $log
start_slice=$(date +%s.%3N)
snakemake \
    --snakefile ${main_dir}Snakefile \
    --use-conda \
    --cores 6 \
    --jobs 5 \
    --configfile=$config
    #--dag --dry-run | dot -Tpng > ${out_dir}dag.png \
end_slice=$(date +%s.%3N)
slice_time=$(echo "scale=3; $end_slice - $start_slice" | bc)
echo "QC: $slice_time seconds" >> $log

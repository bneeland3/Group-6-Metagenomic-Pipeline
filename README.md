# Group-6-Metagenomic-Pipeline

Metagenomic sequencing is a method used in the field of genomics to study genetic material recovered directly from environmental or clinical samples. It involves the sequencing of nucleotide sequences isolated from all the organisms present in a given sample. Because of its ability to reveal the previously hidden diversity of microscopic life, metagenomics offers a powerful way of understanding the microbial world that might revolutionize understanding of biology... HOWEVER:

Metagenomic data processing and utilization requires complex bioinformatic tools. This pipeline is aimed at simplifying the initial steps of metagenomic sequence quality screening, trimmiming and removal of host contamination. 

![unnamed](https://github.com/bneeland3/Group-6-Metagenomic-Pipeline/assets/104112036/be4737fa-e19a-4a93-bad9-16e3ada7e0ae)

Major Goals: 
    -Quality check DNA data 
    -Remove low quality reads 
    -Redo quality check
    -Remove host-contamination reads
    -Redo quality check
    -Run gene alignment tool

# Requirements:
  Please be sure that conda or mamba (faster) is already installed/updated to the latest version. 

# Installation:
1. Clone repository using

        git clone git@github.com:bneeland3/Group-6-Metagenomic-Pipeline.git

# Usage:
2. Ensure you have conda or mamba installed on your computer or cluster. If using mamba (faster), ensure all instances of "conda" below are replaced by "mamba" when utilizing. If you are unsure if either is initialized please run: 

        conda init
        (or)
        mamba init
3. Setup metagenomic pipeline environment by running the following from your main directory:

        conda env create -f env/quality.yaml
        conda env create -f env/trimmomatic.yaml

        conda activate quality

    * note: depending on the cluster used and the conda/miniconda installation, sometimes the command `source ~/miniconda3/bin/activate` is necessary prior to running steps 1 and 2. 
   
4. Data Download

   **i. Option 1:** Using provided data:
    If you are planning on using the provided data as a demo run, please either make sure the test example samples exist within your workspace in doc/data:

        --SRS014466.denovo_duplicates_marked.trimmed.1.fastq
        --SRS014466.denovo_duplicates_marked.trimmed.2.fastq
        --SRS023534.denovo_duplicates_marked.trimmed.1.fastq
        --SRS023534.denovo_duplicates_marked.trimmed.2.fastq
    
    If these did not download simply run the following from the main repo to download demo data. 

        python src/download_test_data.py
    When the download is complete, run the following to generate a txt file of your sample names you will be using:

        python src/sample_names.py

   **i. Option 2:** Using your own data:
    If you are planning on using your own data, please skip running the download_test_data.py script and run the following from the main repo, to generate a txt file of your sample names you will be using:

        python src/sample_names.py 

4. Before you run snakemake, some file paths need to be changed for your unique directory setup. The changes needed will be in files:

    **1.run.sh:**
    This file is used to submit a job to your cluster (here holding sbatch command parameters). You will need to change the main_dir, output_dir and config_dir paths in lines 20-22. It calls the file `src/index.sh` that will call the snakefile with appropriate parameters. You can also change the sbatch email and partition depending on the cluster system being utilized.  
    **2.index.sh:**
    This file holds the snakemake execution command parameters. You can see more options that could be included here by running `snakemake --help` if in the activated "quality" conda environment that has snakemake installed.
    **3.src/config.yml**
    This file contains paths to files and directories used by snakemake. Additional snakefile parameters (such as for the trimmomatic rule) are also included here to avoid needing to edit the raw snakefile.

5. Next, run the quality control pipeline from the src directory. To do this, you need to ensure that you are in the "quality" environment created in step 2 and 3. Then, if you are using a cluster system that utilizes slurm and batch jobs submissions, run:

        sbatch run.sh

    * note: If you would like to test the snakemake workflow without actually running anything, or if you would like to see the directed acyclic graph (DAG) of jobs submitted, you can do so by editting the `src/index.sh file to include` `--dag --dry-run | dot -Tpng > dag.png` in the snakemake command (hashed out in the index.sh file on line 43)

6. Information about the progress of the job submitted will be found in a file that starts with "slurm", end with "out", and has the job ID in the middle. For example, if you type `ls` from the directory you submited step 5, you might see the file `slurm-9261423.out`. To see how it went, type:

        less slurm-9261423.out

    You can learn more about slurm settings [here](https://slurm.schedmd.com/sbatch.html).

7. Review the quality of the sequencing data in the MultiQC report in the `doc/fastqc1_output`. The multiqc script looks something like this: 

 INSERT MULTIQC HTML LINK OR SCREEN SHOT


# Updates:
    10/17/23: 
        1. Created/updated README.md
        2. Uploaded TSV files to doc for later download
        3. Created src and doc files
        4. created environment.yml 
        5. created main.yml
    10/27/23:
        6. Rule all added to snakefile
        7. Added fastqc 1 rule to snakefile
    10/30/23:
        8. Alteration to Snakefile and updates to repository organization
    11/1/23:
        9. Multiqc/fastqc/trimmomatic environments added to repository
        10. Creation of Snakefile and read samples function in quality_utils.py
        11. Modification of read samples function within snakefile
        12. Expand rule changed to use zip files to hopefully reduce size issue within github
        13. Altered rules to further defining steps fastqc_1, mutliqc_1, trimmomatic, fastqc_2, multiqc_2, etc
    11/3/23:
        14. Changes to Snakefile to see if gz files work better than large fastq files using SeqTK
        15. Creation of indvidual download links for wgets in snakefile
    11/5/23:
        12. Snakefile modified to use specific files for the time being to simplify the pipeline during testing
        13. New fastq files added to github ../doc/data
        14. Working snakefile added by Emily!
        15. Pycodestyle updates and overall github cleanup
    11/6/23:
        16. Updated snakefile to run with fastqc environment as well as conda setups
    11/8/23:
        17. Emily upated snakefile, and created download_test_data.py and sample_names.txt
        18. Usage/Instructions updated in readme
    11/10/23:
        19. Initialized accounts for Fiji cluster to run larger datasets
    11/15/23:
        20. Worked on activating conda environments for set up 
        21. Created index.sh and config.yml
    11/16/23:
        22. Tested environment setup on another computer to ensure all files could be cloned and accessed properly.
        23. Run.sh created and modified.
    


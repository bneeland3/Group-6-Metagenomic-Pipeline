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
  Please be sure that conda or mamba (faster) is already installed/updated to the latest version

# Installation:
    1. Clone repository 

# Usage:
    1. Ensure you have conda installed on your computer

    2. Setup metagenomic pipeline environment by running the following from your main directory:
        `conda env create -f env/quality.yaml`
        `conda activate quality`

    3. Data Download
        i. Option 1: Using provided data:
        --If you are planning on using the provided data as a demo run, please either make sure the test example samples exist within your workspace in doc/data:
      --SRS014466.denovo_duplicates_marked.trimmed.1.fastq
      --SRS014466.denovo_duplicates_marked.trimmed.2.fastq
      --SRS023534.denovo_duplicates_marked.trimmed.1.fastq
      --SRS023534.denovo_duplicates_marked.trimmed.2.fastq
    
        If these did not download simply run `python src/download_test_data.py` from the main repo. Then run `python src/sample_names.py` from the main repo, to generate a txt file of your sample names you will be using.

        ii: Option 2: Using your own data:
        --If you are planning on using your own data, please skip running the download_test_data.py script and run `python src/sample_names.py` from the main repo, to generate a txt file of your sample names you will be using. 

    4. Next, run the snakefile from the src directory using:
        `snakemake -c1`

    5. Review the MultiQC report in the doc/data/fastqc1_output 


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


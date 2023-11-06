# Group-6-Metagenomic-Pipeline

# Installation:
    1. Clone repository 
    2. Find the doc/data repository
    3. Please double check that the samples exist within your workspace:
      --SRS014466.denovo_duplicates_marked.trimmed.1.fastq
      --SRS014466.denovo_duplicates_marked.trimmed.2.fastq
      --SRS023534.denovo_duplicates_marked.trimmed.1.fastq
      --SRS023534.denovo_duplicates_marked.trimmed.2.fastq
    4. From this point you can run the SnakeFile using:
       snakemake -c1

# Updates:
    10/17/23: 
        1. Created/updated README.md
        2. Uploaded TSV files to doc for later download
        3. Created src and doc files
        4. created environment.yml <-- is unfinished
        5. created main.yml <-- is unfinished 
        
    11/1/23:
        6. Multiqc/fastqc/trimmomatic environments added to repository
        7. Creation of Snakefile and read samples function in quality_utils.py
        
    11/3/23:
        8. Changes to Snakefile to see if gz files work better than large fastq using SeqTK
        
    11/5/23:
        9. Snakefile modified to use specific files for the time being to simplify the pipeline during testing
        10. New fastq files added to github ../doc/data
        11. Modified snakefile added by Emily!


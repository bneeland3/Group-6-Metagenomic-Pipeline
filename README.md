# Group-6-Metagenomic-Pipeline

Steps:
# Installaion: 
  1. Clone repository 
  2. Find the doc/data repository
  3. Please download the following samples from google drive: https://drive.google.com/drive/folders/1fbhYhUw00HcxrOJPBv6Tw4DfHZWE70k_?usp=sharing
     --Sample Names: 
      SRS014466.denovo_duplicates_marked.trimmed.1.fastq.gz
      SRS014466.denovo_duplicates_marked.trimmed.2.fastq.gz
  4. Then please manually import them into the doc/data directory within the repository
  5. Once those files are within the ../doc/data directory you can run the SnakeFile using:
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
    

!#/bin/bash

for infile in *.denovo_duplicates_marked.trimmed.1.fastq; do
    base=$(basename ${infile} .denovo_duplicates_marked.trimmed.1.fastq)
    echo "Running sample ${base}"

    R1="${reads[0]}"
    R2="${reads[1]}"

    echo "FASTQC 1 for ${base}"
    fastqc ${R1} ${R2} -o "${snakemake_output[0]}"
  done

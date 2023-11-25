import os

# extract only the part of the sample name before the first "." or "_".
def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

# Read sample names from "sample_names.txt"
sample=read_sample_names("doc/data/sample_names.txt")

rule all:
    input:
        expand("doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=sample),
        "doc/data/fastqc1_results/multiqc_report.html"

rule fastqc:
    input:
        F="doc/data/{sample}.denovo_duplicates_marked.trimmed.1.fastq",
        R="doc/data/{sample}.denovo_duplicates_marked.trimmed.2.fastq"
    output:
        html1="doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.html",
        zip1="doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.zip",
        html2="doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.2_fastqc.html",
        zip2="doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.2_fastqc.zip"
    conda: "quality"
    shell:
        """
        mkdir -p doc/data/fastqc1_results
        fastqc {input.F} --outdir doc/data/fastqc1_results/
        fastqc {input.R} --outdir doc/data/fastqc1_results/
        """

rule multiqc:
    input:
        html1=expand("doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=sample),
        html2=expand("doc/data/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.2_fastqc.html", sample=sample)
    output:
        html="doc/data/fastqc1_results/multiqc_report.html",
        data=directory("doc/data/fastqc1_results/multiqc_data")
    conda: "quality"
    shell:
        """
        cd doc/data/fastqc1_results
        multiqc .
        """

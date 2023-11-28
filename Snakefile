import os
from types import SimpleNamespace
config = SimpleNamespace(**config)

# extract only the part of the sample name before the first "." or "_".
def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

# Read sample names from "sample_names.txt" made using sample_names.py prior to snakemake
samples=read_sample_names(f"{config.sample_IDs}")

rule all:
    input:
        expand(f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=samples),
        f"{config.out_dir}fastqc1_results/multiqc_report.html"

rule fastqc:
    input:
        F=f"{config.data_dir}{{sample}}.denovo_duplicates_marked.trimmed.1.fastq",
        R=f"{config.data_dir}{{sample}}.denovo_duplicates_marked.trimmed.2.fastq"
    output:
        html1=f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.1_fastqc.html",
        zip1=f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.1_fastqc.zip",
        html2=f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.2_fastqc.html",
        zip2=f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.2_fastqc.zip"
    conda: "quality"
    shell:
        """
        mkdir -p {config.out_dir}fastqc1_results
        fastqc {input.F} --outdir {config.out_dir}fastqc1_results/
        fastqc {input.R} --outdir {config.out_dir}fastqc1_results/
        """

rule multiqc:
    input:
        html1=expand(f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=samples),
        html2=expand(f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.2_fastqc.html", sample=samples)
    output:
        html=f"{config.out_dir}fastqc1_results/multiqc_report.html",
        data=directory(f"{config.out_dir}fastqc1_results/multiqc_data")
    conda: "quality"
    shell:
        """
        cd {config.out_dir}fastqc1_results
        multiqc .
        """

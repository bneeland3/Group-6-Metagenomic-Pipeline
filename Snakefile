import os
from types import SimpleNamespace
config = SimpleNamespace(**config)

# extract only the part of the sample name before the first "." or "_".
# THIS FUNCTION NEEDS A NEAT DEFINITION? 
def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

# Read sample names from "sample_names.txt" made using src/sample_names.py prior to snakemake
samples=read_sample_names(f"{config.sample_IDs}")

rule all:
    input:
        expand(f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=samples),
        f"{config.out_dir}fastqc1_results/multiqc_report.html",
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_1P", sample=samples),
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2P", sample=samples),
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_1U", sample=samples),
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2U", sample=samples),

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

rule trimmomatic:
    input:
        F=f"{config.data_dir}{{sample}}.denovo_duplicates_marked.trimmed.1.fastq",
        R=f"{config.data_dir}{{sample}}.denovo_duplicates_marked.trimmed.2.fastq"
    output:
        #directory(f"{config.out_dir}trimmed_output/{{sample}}"),
        p1=f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_1P",
        p2=f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2P",
        u1=f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_1U",
        u2=f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2U"
    conda:"trimmomatic"
    params:
        adapters=config.adapters,
        a_settings=config.adapter_settings,
        swindow=config.sliding_window,
        leading=config.leading,
        trailing=config.trailing,
        minlen=config.min_length,
        threads=config.trim_threads
    shell:
        """
        mkdir -p {config.out_dir}trimmed_output/{wildcards.sample}
        touch {config.out_dir}trimmed_output/failures.txt
        trimmomatic PE -threads {params.threads} \
            -trimlog {config.out_dir}trimmed_output/{wildcards.sample}/{wildcards.sample}.trimlog \
            -summary {config.out_dir}trimmed_output/{wildcards.sample}/{wildcards.sample}.trim.log \
            -validatePairs {config.data_dir}{wildcards.sample}.denovo_duplicates_marked.trimmed.1.fastq {config.data_dir}{wildcards.sample}.denovo_duplicates_marked.trimmed.2.fastq \
            -baseout {config.out_dir}trimmed_output/{wildcards.sample}/{wildcards.sample}.trimmed \
            ILLUMINACLIP:{params.adapters}{params.a_settings} SLIDINGWINDOW:{params.swindow} LEADING:{params.leading} TRAILING:{params.trailing} MINLEN:{params.minlen} \
            || echo {wildcards.sample} >> {config.out_dir}trimmed_output/failures.txt
        """
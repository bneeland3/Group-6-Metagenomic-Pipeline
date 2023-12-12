import os
import sys
from types import SimpleNamespace
config = SimpleNamespace(**config)
sys.path.insert(0, '../../src')  # noqa #set up a path using sys

from read_sample_names import read_sample_names

# Read sample names from "sample_names.txt" made using src/sample_names.py prior to snakemake
samples=read_sample_names(f"{config.sample_IDs}")

rule all:
    input:
    #fastqc1 output
        expand(f"{config.out_dir}fastqc1_results/{{sample}}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=samples),
        f"{config.out_dir}fastqc1_results/multiqc_report.html",
    #trimmomatic output
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_1P", sample=samples),
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2P", sample=samples),
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_1U", sample=samples),
        expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2U", sample=samples),
    #fastqc2 output
        expand(f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_1P_fastqc.html", sample=samples),
        f"{config.out_dir}fastqc2_results/multiqc_report.html",

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
        #adapters=config.adapters,
        swindow=config.sliding_window,
        leading=config.leading,
        trailing=config.trailing,
        minlen=config.min_length,
        threads=config.trim_threads
    shell:
        """
        mkdir -p {config.out_dir}trimmed_output/{wildcards.sample}
        touch {config.out_dir}trimmed_output/failures.txt
        trimmomatic PE -threads 1 \
            -trimlog {config.out_dir}trimmed_output/{wildcards.sample}/{wildcards.sample}.trimlog \
            -summary {config.out_dir}trimmed_output/{wildcards.sample}/{wildcards.sample}.trim.log \
            -validatePairs {config.data_dir}{wildcards.sample}.denovo_duplicates_marked.trimmed.1.fastq {config.data_dir}{wildcards.sample}.denovo_duplicates_marked.trimmed.2.fastq \
            -baseout {config.out_dir}trimmed_output/{wildcards.sample}/{wildcards.sample}.trimmed \
            SLIDINGWINDOW:{params.swindow} LEADING:{params.leading} TRAILING:{params.trailing} MINLEN:{params.minlen} \
            || echo {wildcards.sample} >> {config.out_dir}trimmed_output/failures.txt
        """

rule fastqc2:
    input:
        P1=f"{config.trimmed_files}{{sample}}/{{sample}}.trimmed_1P",
        P2=f"{config.trimmed_files}{{sample}}/{{sample}}.trimmed_2P"
    output:
        html1=f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_1P_fastqc.html",
        zip1=f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_1P_fastqc.zip",
        html2=f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_2P_fastqc.html",
        zip2=f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_2P_fastqc.zip"
    conda: "quality"
    shell:
        """
        mkdir -p {config.out_dir}fastqc2_results
        fastqc {input.P1} --outdir {config.out_dir}fastqc2_results/
        fastqc {input.P2} --outdir {config.out_dir}fastqc2_results/
        """

rule multiqc2:
    input:
        html1=expand(f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_1P_fastqc.html", sample=samples),
        html2=expand(f"{config.out_dir}fastqc2_results/{{sample}}.trimmed_2P_fastqc.html", sample=samples)
    output:
        html=f"{config.out_dir}fastqc2_results/multiqc_report.html",
        data=directory(f"{config.out_dir}fastqc2_results/multiqc_data")
    conda: "quality"
    shell:
        """
        cd {config.out_dir}fastqc2_results
        multiqc .
        """

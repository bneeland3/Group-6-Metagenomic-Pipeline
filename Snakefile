rule all:
    input:
        expand("doc/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=["SRS014466", "SRS023534"]),
        "doc/fastqc1_results/multiqc_report.html"
        

#rule download_data:
#    output:
#        directory("doc/data")
#    shell:
#        """
#        mkdir -p doc/data/
#        cd doc/data/
#        gdown "https://drive.google.com/uc?id=11oVlLFy2M4vZou6mlq02vcwaLknFexWd&export=download" -O SRS014466.1.fastq
#        gdown "https://drive.google.com/uc?id=1c8bXKesFJ7pDeM29-K2iUv3ZvUtqxlyU&export=download" -O SRS014466.2.fastq
#         """

#rule generate_sample_list:
#   output:
#        "doc/data/sample_names.txt"
#    shell:
#        """
#        cd doc/data/
#        for file in *.fastq; do
#            echo ${file%%.*} >> {output}
#        done
#        """


rule fastqc:
    input:
        F="doc/data/{sample}.denovo_duplicates_marked.trimmed.1.fastq",
        R="doc/data/{sample}.denovo_duplicates_marked.trimmed.2.fastq"
    output:
        html="doc/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.html",
        zip="doc/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.zip"
    conda: "env/fastqc.yaml"
    shell:
        """
        mkdir -p doc/fastqc1_results
        fastqc {input.F} {input.R} --outdir doc/fastqc1_results/
        """

rule multiqc:
    input:
        html=expand("doc/fastqc1_results/{sample}.denovo_duplicates_marked.trimmed.1_fastqc.html", sample=["SRS014466", "SRS023534"])
    output:
        html="doc/fastqc1_results/multiqc_report.html",
        data=directory("doc/fastqc1_results/multiqc_data")
    conda: "env/fastqc.yaml"
    shell:
        """
        cd doc/fastqc1_results
        multiqc .
        """

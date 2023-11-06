# This script is going to contain some useful functions our snakemake will use

def read_samples(file_name):
    sample = []
    with open(file_name) as file:
        for line in file:
            countries.append(line.rstrip())
    return sample

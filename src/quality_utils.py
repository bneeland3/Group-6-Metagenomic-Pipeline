# This script is going to contain some useful functions our snakemake will use

def read_samples(file_name):
    sample = []
    with open(file_name) as f:
      for l in f:
        countries.append(l.rstrip())
    return sample
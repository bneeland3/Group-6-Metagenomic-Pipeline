import os
import sys

sys.path.insert(0, '../')  # noqa

data_dir = 'doc/data'

# List all files in the data_dir
files = os.listdir(data_dir)

# Extract sample names from the file names if they end in fastq or fq.gz
sample_names = [os.path.splitext(file)[0].split('.')[0].split('_')[0] for file in files if 
file.endswith('.fastq') or file.endswith('.fq.gz')]

# Create a sample_names.txt file
sample_names_file_path = os.path.join(data_dir, 'sample_names.txt')
with open(sample_names_file_path, 'w') as sample_file:
    for sample_name in sample_names:
        sample_file.write(sample_name + '\n')




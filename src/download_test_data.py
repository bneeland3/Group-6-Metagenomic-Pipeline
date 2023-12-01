import os
import gdown
import sys

'''
Script to download test data from repository
--------------------------------------------
    Creates directory to store data.
    Defines file URLs and downlaods files.
'''

sys.path.insert(0, '../')  # noqa

# Create a directory to store the data
data_dir = 'doc/data'
os.makedirs(data_dir, exist_ok=True)

# Define the file URLs
file_urls = {
    'SRS014466.1.fastq.gz':
    'https://drive.google.com/uc?id=11oVlLFy2M4vZou6mlq02vcwaLknFexWd&export=download',
    'SRS014466.2.fastq.gz':
    'https://drive.google.com/uc?id=1c8bXKesFJ7pDeM29-K2iUv3ZvUtqxlyU&export=download'
}

# Download the files
for filename, url in file_urls.items():
    file_path = os.path.join(data_dir, filename)
    gdown.download(url, file_path, quiet=False)

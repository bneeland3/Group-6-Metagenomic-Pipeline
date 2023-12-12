import sys


def read_sample_names(filename):
    '''
    Function opens a file and read sample names from the file

    Parameters
    ----------
    filename : str
        str input containing desired sample names

    Returns
    -------
        returns lines containing split up names in the file
    '''
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

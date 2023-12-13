from os import path

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


def remove_adapters(default, config, rule_name):
    # First, check the config for a rule-specific adapters
    config_param = "trimmomatic_adapters"
    if config_param is not None:
        return config_param
    # Then, check the config for a different default adapter name
    # This looks for default_no_adapters.
    config_diff_default = "default_noq_adapters"
    if config_diff_default is not None:
        return config_diff_default
    
    # If there's nothing in the config, use what's in the snakefile
    return default
    

def get_threads(default, config, rule_name):
    config_param = config.get(f"{rule_name}_threads")
    if config_param is not None:
        return int(config_param)
    return default
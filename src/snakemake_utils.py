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
    '''
    Determines if adapters need removal based on configuration parameters.

    Parameters
    ----------
    default : str
        Default no adapter removal.
    config : dict
        Dictionary containing configuration parameters.
    rule_name : str
        Name of the rule.

    Returns
    -------
    str
        Adapter name to be used.
    '''
    config_param_none = "# trimmomatic_adapters"
    config_param_yes = "trimmomatic_adapters"
    config_diff_default = "default_no_adapters"
    config_no_adapters = " "
    
    if config_param_none is None:
        return config_param_yes

    if config_diff_default is not None:
        return config_no_adapters
    
    # If there's nothing in the config, use what's in the snakefile
    return default
    

def get_threads(default, config, rule_name):
    config_param = config.get(f"{rule_name}_threads")
    if config_param is not None:
        return int(config_param)
    return default
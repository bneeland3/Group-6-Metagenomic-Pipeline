#!/bin/bash/env python

cd ../../src # Change directory to ../src
parent_dir='$(pwd)' # parent_dir is defined as the print working directory.
file_name= 'download_test_data.py' # Creates a variable name for the file name.
file_path='${parent_dir}/${file_name}' # The file path is defined as the dir/file_name.

# echo 'File Path: ${file_path}' # This prints our file path

# Lines 11 and 13 are for the Stupid Simple Bash Testing.
test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest

source ssshtest

# run basic_assert python "file_path"
# assert_equal $file_name $( ls $file_name )

# run basic_obs python python 'file_path'
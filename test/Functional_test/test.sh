#!/bin/bash

# Lines 11 and 13 are for the Stupid Simple Bash Testing.
test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest

source ssshtest

cd ../../src # Change directory to ../src
pip install gdown

run test_basic_download_code python download_test_data.py 
assert_exit_code 0

run test_basic_samples python sample_names.py
assert_exit_code 0

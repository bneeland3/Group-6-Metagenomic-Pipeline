#!/bin/bash 
test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest 
. ssshtest
cd ../../src # 
dir="$(pwd)"
file="scatter.py" 
path="${dir}/${file}" 
echo "File Path: ${path}"
test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest
source ssshtest
run basic_assert python "path"
assert_equal $file $( ls $file )
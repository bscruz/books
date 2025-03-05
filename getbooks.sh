#!/bin/bash

curr_dir=$PWD
inputfile=$1 

for line in $(cat $inputfile);
do
    echo "$line"
done
    

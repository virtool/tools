#! /bin/bash

# Get the version from the command line argument
version=$1

wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${version}.zip
unzip fastqc_v${version}.zip
ls
chmod 755 FastQC/fastqc
mkdir -p "/fastqc"
mv FastQC "/fastqc/${version}"

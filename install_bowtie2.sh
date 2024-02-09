#!/bin/bash

# Get the version from the command line argument
version=$1

# Download, extract, configure, and install the version
wget https://github.com/BenLangmead/bowtie2/archive/refs/tags/v${version}.tar.gz
tar -xvf v${version}.tar.gz
cd bowtie2-${version}
make
mkdir -p "/bowtie2/${version}"
cp bowtie2* "/bowtie2/${version}"

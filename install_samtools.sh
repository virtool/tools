#!/bin/bash

# Get the version from the command line argument
version=$1

# Download, extract, configure, and install the version
wget https://github.com/samtools/samtools/releases/download/${version}/samtools-${version}.tar.bz2
tar -xjf samtools-${version}.tar.bz2
cd samtools-${version}
mkdir -p "/samtools/${version}"
./configure --prefix="/samtools/${version}"
make && make install
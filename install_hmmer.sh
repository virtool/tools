#!/bin/bash

# Get the version from the command line argument
version=$1

# Download, extract, configure, and install the version
wget http://eddylab.org/software/hmmer/hmmer-$version.tar.gz
tar -xf hmmer-$version.tar.gz
cd hmmer-$version
./configure --prefix /build/hmmer-$version
make && make install
#!/bin/bash

# Get the version from the command line argument
version=$1
slug=$2

# Download, extract, configure, and install the version
wget https://github.com/weizhongli/cdhit/releases/download/V${version}/cd-hit-${slug}.tar.gz
tar -xf cd-hit-$slug.tar.gz
cd cd-hit-$slug
make && make install
cd ..
mkdir -p /cd-hit/${version}
mv cd-hit-$slug/cd-hit* /cd-hit/${version}
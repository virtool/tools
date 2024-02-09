#!/bin/bash

# Get the version from the command line argument
version=$1

# Download, extract, configure, and install the version
wget http://opengene.org/fastp/fastp.${version}
mkdir -p /fastp/${version}
mv fastp.${version} /fastp/${version}/fastp
chmod ugo+x /fastp/${version}/fastp

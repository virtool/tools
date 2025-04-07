#!/bin/bash

version=$1

# Download, extract, configure, and install the version
wget https://github.com/BenLangmead/bowtie2/archive/refs/tags/v$version.tar.gz
ls
tar -xvf v${version}.tar.gz
cd bowtie2-${version}
make
mkdir /build/bowtie2
cp bowtie2* /build/bowtie2/

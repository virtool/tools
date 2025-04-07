#!/bin/bash

version=$1

url="https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v$version.zip"

wget url
unzip fastqc_v${version}.zip

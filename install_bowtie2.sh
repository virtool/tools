#!/bin/bash

# Get the version from the command line argument
version=$1

# Download, extract, configure, and install the version
RUN wget https://github.com/BenLangmead/bowtie2/releases/download/v${version}/bowtie2-${version}-linux-x86_64.zip
RUN unzip bowtie2-${version}-linux-x86_64.zip
RUN mv bowtie2-${version}-linux-x86_64 /build/bowtie2-${version}

#!/bin/bash

# Get the version from the command line argument
version=$1

wget https://zlib.net/pigz/pigz-${version}.tar.gz
tar -xzvf pigz-${version}.tar.gz
cd pigz-${version}
make
mkdir -p /pigz/${version}
mv pigz /pigz/${version}/pigz

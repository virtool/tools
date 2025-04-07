#!/bin/bash

version=$1

mkdir /download
cd /download
wget https://zlib.net/pigz/pigz-$version.tar.gz
tar -xzvf pigz-$version.tar.gz
ls
cd pigz-$version
make
mkdir /build/pigz-$version
cp pigz /build/pigz-$version/pigz

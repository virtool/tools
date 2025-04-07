#!/bin/bash

version=$1

wget https://github.com/relipmoc/skewer/archive/refs/tags/$version.tar.gz
tar -xf 0.2.2.tar.gz
cd skewer-0.2.2
make
mv skewer /build
#!/bin/bash

version=$1

wget https://github.com/relipmoc/skewer/archive/${version}.tar.gz
tar -xf ${version}.tar.gz
cd skewer-${version}
make
mkdir -p /skewer/${version}
mv skewer /skewer/${version}/skewer

#! /bin/bash



wget https://zlib.net/pigz/pigz-2.8.tar.gz
tar -xzvf pigz-2.8.tar.gz
cd pigz-2.8
make
mkdir -p /pigz/2.8
mv pigz /pigz/2.8/pigz

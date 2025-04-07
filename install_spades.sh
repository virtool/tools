
version = $1

wget https://github.com/ablab/spades/releases/download/v3.15.5/SPAdes-3.15.5.tar.gz
RUN tar -xvf SPAdes-3.15.5.tar.gz
WORKDIR SPAdes-3.15.5
ENV PREFIX=/build/spades
RUN ./spades_compile.sh
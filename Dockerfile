FROM debian:bullseye as hmmer
WORKDIR /build
RUN apt-get update && apt-get install -y build-essential wget bioperl
COPY install_hmmer.sh .
RUN bash install_hmmer.sh 3.2.1
RUN bash install_hmmer.sh 3.3.2


FROM debian:buster as skewer-0-2-2
RUN wget https://github.com/relipmoc/skewer/archive/0.2.2.tar.gz && \
    tar -xf 0.2.2.tar.gz && \
    cd skewer-0.2.2 && \
    make && \
    mv skewer /build

# Bowtie2
FROM debian:bullseye as bowtie2
WORKDIR /build
COPY install_bowtie2.sh .
RUN bash install_bowtie2.sh 2.3.2
RUN bash install_bowtie2.sh 2.5.3

# FastQC
FROM debian:bullseye as fastqc
WORKDIR /build
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
RUN unzip fastqc_v0.11.9.zip

# Pigz
FROM debian:bullseye as pigz
WORKDIR /build
RUN apt-get update && apt-get install -y make gcc zlib1g-dev wget
RUN wget https://zlib.net/pigz/pigz-2.7.tar.gz
RUN tar -xzvf pigz-2.7.tar.gz
RUN cd pigz-2.7
RUN make

FROM debian:bullseye

WORKDIR /tools/bowtie
COPY --from=bowtie /build/bowtie2-2.3.2/ ./bowtie2-2.3.2

WORKDIR /tools/hmmer
COPY --from=hmmer /build/hmmer /build/hmmer
COPY --from=bowtie /build/bowtie2/* /usr/local/bin/
COPY --from=debian /build/hmmer /opt/hmmer
COPY --from=debian /build/skewer /usr/local/bin/
COPY --from=fastqc /build/FastQC /opt/fastqc
COPY --from=pigz /build/pigz-2.7/pigz /usr/local/bin/pigz
RUN chmod ugo+x /opt/fastqc/fastqc && \
    ln -fs /opt/fastqc/fastqc /usr/local/bin/fastqc && \
    for file in `ls /opt/hmmer/bin`; do ln -fs /opt/hmmer/bin/${file} /usr/local/bin/${file};  done
ENV PATH $PATH:/root/.local/bin
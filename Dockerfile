# Bowtie2
FROM debian:bookworm as bowtie2
WORKDIR /build
RUN apt-get update
RUN apt-get install -y build-essential cmake wget zlib1g-dev
COPY install_bowtie2.sh .
RUN bash install_bowtie2.sh 2.3.2
RUN bash install_bowtie2.sh 2.5.3

# FastQC
FROM debian:bookworm as fastqc
WORKDIR /build
RUN apt-get update && apt-get install -y wget unzip
COPY install_fastqc.sh .
RUN bash install_fastqc.sh 0.11.9
RUN bash install_fastqc.sh 0.12.0

# HMMER
FROM debian:bookworm as hmmer
WORKDIR /build
RUN apt-get update && apt-get install -y build-essential wget bioperl
COPY install_hmmer.sh .
RUN bash install_hmmer.sh 3.2.1
RUN bash install_hmmer.sh 3.3.2

# Pigz
FROM debian:bookworm as pigz
WORKDIR /build
RUN apt-get update && apt-get install -y make gcc zlib1g-dev wget
COPY install_pigz.sh .
RUN bash install_pigz.sh 2.8

# Skewer
FROM debian:bookworm as skewer
RUN apt-get update && apt-get install -y build-essential wget
COPY install_skewer.sh .
RUN bash install_skewer.sh 0.2.2

# SPAdes
RUN debian:bookworm as spades
RUN apt-get update && apt-get install -y build-essential cmake libbz2-dev wget zlib1g-dev
COPY install_spades.sh .
RUN bash install_spades.sh 3.15.5

FROM debian:bookworm as staging
WORKDIR tools
COPY --from=bowtie /build/bowtie2* ./
COPY --from=fastqc /build/FastQC ./fastqc/
COPY --from=hmmer /build/hmmer ./hmmer/
COPY --from=pigz /build/pigz* ./pigz/
COPY --from=skewer /build/skewer ./skewer

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
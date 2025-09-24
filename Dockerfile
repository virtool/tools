# Bowtie2
FROM debian:bookworm AS bowtie2
WORKDIR /build
RUN apt-get update && apt-get install -y build-essential perl wget zlib1g-dev && rm -rf /var/lib/apt/lists/*
COPY install_bowtie2.sh .
RUN bash install_bowtie2.sh 2.5.3
RUN bash install_bowtie2.sh 2.5.4

# fastp
FROM debian:bookworm AS fastp
WORKDIR /build
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
COPY install_fastp.sh .
RUN bash install_fastp.sh 0.23.2

# FastQC
FROM debian:bookworm AS fastqc
WORKDIR /build
RUN apt-get update && apt-get install -y unzip wget && rm -rf /var/lib/apt/lists/*
COPY install_fastqc.sh .
RUN bash install_fastqc.sh 0.11.9

# HMMER
FROM debian:bookworm AS hmmer
WORKDIR /build
RUN apt-get update && apt-get install -y bioperl build-essential wget && rm -rf /var/lib/apt/lists/*
COPY install_hmmer.sh .
RUN bash install_hmmer.sh 3.2.1
RUN bash install_hmmer.sh 3.3.2

# Pigz
FROM debian:bookworm AS pigz
WORKDIR /build
RUN apt-get update && apt-get install -y gcc make wget zlib1g-dev && rm -rf /var/lib/apt/lists/*
COPY install_pigz.sh .
RUN bash install_pigz.sh 2.8

# Skewer
FROM debian:bullseye AS skewer
WORKDIR /build
RUN apt-get update && apt-get install -y build-essential wget && rm -rf /var/lib/apt/lists/*
COPY install_skewer.sh .
RUN bash install_skewer.sh 0.2.2

# Samtools
FROM debian:bookworm AS samtools
WORKDIR /build
RUN apt-get update && apt-get install -y build-essential wget libbz2-dev zlib1g-dev libncurses5-dev libncursesw5-dev liblzma-dev libcurl4-openssl-dev && rm -rf /var/lib/apt/lists/*
COPY install_samtools.sh .
RUN bash install_samtools.sh 1.22.1

FROM debian:bookworm AS cdhit
WORKDIR /build
RUN apt-get update && apt-get install -y wget build-essential libz-dev && rm -rf /var/lib/apt/lists/*
COPY install_cdhit.sh .
RUN bash install_cdhit.sh 4.8.1 v4.8.1-2019-0228

# Combine tools into a single image.
FROM debian:bookworm AS combine
WORKDIR /tools
COPY --from=bowtie2 /bowtie2/ ./bowtie2
COPY --from=fastp /fastp/ ./fastp
COPY --from=fastqc /fastqc ./fastqc
COPY --from=hmmer /hmmer ./hmmer
COPY --from=pigz /pigz/ ./pigz
COPY --from=samtools /samtools/ ./samtools
COPY --from=skewer /skewer ./skewer
COPY --from=cdhit /cd-hit ./cd-hit

# Testing
FROM debian:bookworm AS test
WORKDIR /tools
RUN apt-get update && apt-get install -y default-jre perl libcurl4 && rm -rf /var/lib/apt/lists/*
COPY --from=combine /tools /tools
COPY test.sh .
RUN bash test.sh


FROM debian:bookworm
WORKDIR /tools
RUN apt-get update && apt-get install -y libcurl4 && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --from=test /tools /tools
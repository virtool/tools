#!/bin/bash

# Test Bowtie2
bowtie2_versions=("2.5.3" "2.5.4")

for version in "${bowtie2_versions[@]}"; do
    bowtie2_path="/tools/bowtie2/${version}/bowtie2"
    if [ -x "$bowtie2_path" ]; then
        detected_version=$("$bowtie2_path" --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+$')
        if [ "$detected_version" = "$version" ]; then
            echo "Bowtie2 version ${version} is installed and correct."
        else
            echo "Bowtie2 version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "Bowtie2 version ${version} is not installed or not executable."
        exit 1
    fi
done

# Test fastp
fastp_versions=("0.23.2")

for version in "${fastp_versions[@]}"; do
    if command -v "/tools/fastp/${version}/fastp" >/dev/null 2>&1; then
        detected_version=$("/tools/fastp/${version}/fastp" --version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+$')
        if [ "$detected_version" = "$version" ]; then
            echo "Fastp version ${version} is installed and correct."
        else
            echo "Fastp version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "Fastp version ${version} is not installed."
        exit 1
    fi
done

# Test FastQC
fastqc_versions=("0.11.9")

for version in "${fastqc_versions[@]}"; do
    fastqc_path="/tools/fastqc/${version}/fastqc"
    chmod +x "$fastqc_path"

    if [ -x "$fastqc_path" ]; then
        detected_version=$("$fastqc_path" --version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        if [ "$detected_version" = "$version" ]; then
            echo "FastQC version ${version} is installed and correct."
        else
            echo "FastQC version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "FastQC version ${version} is not installed or not executable."
        exit 1
    fi
done

# Test HMMER
hmmer_versions=("3.2.1" "3.3.2")

for version in "${hmmer_versions[@]}"; do
    hmmer_path="/tools/hmmer/${version}/bin/hmmsearch"

    if [ -x "$hmmer_path" ]; then
        detected_version=$("$hmmer_path" -h | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        if [ "$detected_version" = "$version" ]; then
            echo "HMMER version ${version} is installed and correct."
        else
            echo "HMMER version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "HMMER version ${version} is not installed or not executable."
        exit 1
    fi
done

# Test Pigz
pigz_versions=("2.8")

for version in "${pigz_versions[@]}"; do
    pigz_path="/tools/pigz/${version}/pigz"

    if [ -x "$pigz_path" ]; then
        detected_version=$("$pigz_path" -V | grep -oE '[0-9]+\.[0-9]+$')
        if [ "$detected_version" = "$version" ]; then
            echo "Pigz version ${version} is installed and correct."
        else
            echo "Pigz version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "Pigz version ${version} is not installed or not executable."
        exit 1
    fi
done

# Test Samtools
samtools_versions=("1.22.1")

for version in "${samtools_versions[@]}"; do
    samtools_path="/tools/samtools/${version}/bin/samtools"

    if [ -x "$samtools_path" ]; then
        detected_version=$("$samtools_path" --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+$')
        if [ "$detected_version" = "$version" ]; then
            echo "Samtools version ${version} is installed and correct."
        else
            echo "Samtools version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "Samtools version ${version} is not installed or not executable."
        exit 1
    fi
done

# Test Skewer
skewer_versions=("0.2.2")

for version in "${skewer_versions[@]}"; do
    skewer_path="/tools/skewer/${version}/skewer"


    if [ -x "$skewer_path" ]; then
        detected_version=$("$skewer_path" --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+$')
        if [ "$detected_version" = "$version" ]; then
            echo "Skewer version ${version} is installed and correct."
        else
            echo "Skewer version ${version} is installed but version mismatch (found $detected_version)."
            exit 1
        fi
    else
        echo "Skewer version ${version} is not installed or not executable."
        exit 1
    fi
done
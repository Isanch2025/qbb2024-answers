#!/bin/bash

#Exercise 2: Count feature SNPs and determine enrichment

#Step 2.1 Create a bash script to find the overlap of SNPs and features and calculate the SNP density enrichment for each MAF-feature combination

# Initialize the output file
echo -e "MAF\tFeature\tEnrichment" > snp_counts.txt

# Define the MAF and feature files (no "feature_files/" prefix)
maf_snp_files=("chr1_snps_0.1.bed" "chr1_snps_0.2.bed" "chr1_snps_0.3.bed" "chr1_snps_0.4.bed" "chr1_snps_0.5.bed")
feature_files=("merged_sorted_exons_chr1.bed" "introns_chr1.bed" "merged_sorted_ccres_chr1.bed" "other_chr1.bed")
genome_file="genome_chr1.bed"

#Pseudo code
#Create the results file with a header
# Create the results file with a header
# Loop through each possible MAF value
#   Use the MAF value to get the file name for the SNP MAF file
#   Find the SNP coverage of the whole chromosome
#   Sum SNPs from coverage
#   Sum total bases from coverage
#   Calculate the background
#   Loop through each feature name
#     Use the feature value to get the file name for the feature file
#     Find the SNP coverage of the current feature
#     Sum SNPs from coverage
#     Sum total bases from coverage
#     Calculate enrichment
#     Save result to results file

# Loop over MAF values
for MAF in 0.1 0.2 0.3 0.4 0.5
do
    maf_file="chr1_snps_${MAF}.bed"
    echo "Processing MAF: ${MAF}, maf_file: ${maf_file}"  # Debugging output

    # Ensure the MAF file exists
    if [ ! -f "${maf_file}" ]; then
        echo "Error: ${maf_file} does not exist. Skipping this MAF level."
        continue
    fi

    # Get coverage for the entire genome
    bedtools coverage -a "${genome_file}" -b "${maf_file}" > "${MAF}_cov_chr1.txt"

    snp_sum=$(awk '{s+=$4}END{print s}' "${MAF}_cov_chr1.txt")
    total_sum=$(awk '{s+=$6}END{print s}' "${MAF}_cov_chr1.txt")
    background=$(bc -l -e "${snp_sum} / ${total_sum}")

    # Loop over feature files
    for feature in "${feature_files[@]}"
    do
        echo "Processing feature: ${feature}"  # Debugging output

        # Ensure the feature file exists
        if [ ! -f "${feature}" ]; then
            echo "Error: ${feature} does not exist. Skipping this feature."
            continue
        fi

        # Get coverage for the feature
        bedtools coverage -a "${feature}" -b "${maf_file}" > "${MAF}_cov_${feature}.txt"
        snp_sum_f=$(awk '{s+=$4}END{print s}' "${MAF}_cov_${feature}.txt")
        total_sum_f=$(awk '{s+=$6}END{print s}' "${MAF}_cov_${feature}.txt")
        ratio=$(bc -l -e "${snp_sum_f} / ${total_sum_f}")
        enrichment=$(bc -l -e "${ratio} / ${background}")

        # Output enrichment to the result file
        echo -e "${MAF}\t${feature}\t${enrichment}" >> snp_counts.txt
    done
done

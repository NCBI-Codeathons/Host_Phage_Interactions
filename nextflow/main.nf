#!/usr/bin/env nextflow

params.input = 'Aquifex_aeolicus_VF5.fna'
params.minced_out = 'minced_out'
input_channel = Channel.fromPath(params.input)

process minced {
    echo true
    publishDir params.minced_out

    input:
    file fasta from input_channel

    output:
    file '*.gff' into minced_output

    """
    minced $fasta -gffFull /dev/stdout | grep -v "^#" > ${fasta.simpleName}.gff
    head *.gff
    """
}


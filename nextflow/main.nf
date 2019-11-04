#!/usr/bin/env nextflow

params.input = 'Aquifex_aeolicus_VF5.fna'
input_channel = Channel.fromPath(params.input)

process minced {
    echo true

    input:
    file fasta from input_channel

    output:
    file '*.gff' into minced_output

    """
    minced $fasta -gffFull /dev/stdout | grep -v "^#" > ${fasta.simpleName}.gff
    head *.gff
    """
}


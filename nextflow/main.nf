#!/usr/bin/env nextflow

params.input = 'Aquifex_aeolicus_VF5.fna'
params.minced_out = 'minced_out'
input_channel = Channel.fromPath(params.input)

process minced {
    echo true
    publishDir params.minced_out
    errorStrategy 'ignore'

    input:
    file fasta from input_channel

    output:
    file '*.gff' into minced_output

    """
    echo $fasta
    minced -gffFull $fasta tmp.crisprs ${fasta.simpleName}.gff
    """
}

